import tkinter as tk
from tkinter import filedialog
from collections import defaultdict

# ──────────────────────────────────────────────────────────────
# (Your existing classes & functions go here verbatim:)
class LineTrace:
    cycle = 0; router = ""; op = ""; cw = ""; ccw = ""; pe = ""; ns = ""; sn = ""
    def __init__(self, cycle, router, op, cw, ccw, pe, ns, sn):
        self.cycle = cycle; self.router = router; self.op = op
        self.cw = cw if cw!="zzzzzzzzzzzzzzzz" and cw!="0000000000000000" else "0"
        self.ccw = ccw if ccw!="zzzzzzzzzzzzzzzz" and ccw!="0000000000000000" else "0"
        self.pe = pe if pe!="zzzzzzzzzzzzzzzz" and pe!="0000000000000000" else "0"
        self.ns = ns if ns!="zzzzzzzzzzzzzzzz" and ns!="0000000000000000" else "0"
        self.sn = sn if sn!="zzzzzzzzzzzzzzzz" and sn!="0000000000000000" else "0"
    def isReset(self): return self.op=="**RESET**"
    def isNoOp(self): return all(p=="0" for p in (self.cw,self.ccw,self.pe,self.ns,self.sn))

class PacketTrace:
    def __init__(self, cycle, router, op, packet):
        self.cycle, self.router, self.op, self.packet = cycle, router, op, packet

def decode_packet(val):
    return {
        'vc':     (val >> 63) & 0x1,
        'ns_dir': (val >> 62) & 0x1,
        'ew_dir': (val >> 61) & 0x1,
        'y_hop':  (val >> 52) & 0xF,
        'x_hop':  (val >> 48) & 0xF,
        'y_src':  (val >> 40) & 0xFF,
        'x_src':  (val >> 32) & 0xFF,
        'data':   val & 0xFFFFFFFF,
    }

def parse_hex_string(s):
    s = s.strip()
    if s.lower().startswith('0x'): s = s[2:]
    return int(s, 16)

def read_packet_trace(file_path):
    packet_trace = defaultdict(list)
    with open(file_path, 'r') as f:
        for line in f:
            cols = [c.strip() for c in line.split(',')]
            if not cols or cols[0]=="cycle": continue
            lt = LineTrace(int(cols[0]), cols[1], cols[2], *cols[3:8])
            if lt.isReset() or lt.isNoOp(): continue

            for direction in ('cw','ccw','pe','ns','sn'):
                raw = getattr(lt, direction)
                if raw!="0":
                    pkt = decode_packet(parse_hex_string(raw))
                    key = pkt['data']
                    packet_trace[key].append(
                        PacketTrace(lt.cycle, lt.router, lt.op, pkt)
                    )
    return packet_trace
# ──────────────────────────────────────────────────────────────


class PacketTraceGUI(tk.Frame):
    def __init__(self, master, packet_trace):
        super().__init__(master)
        self.master.title("Packet Trace Viewer")
        self.packet_trace = packet_trace
        self.grid()
        self._build_widgets()
        # compute grid layout from router names
        self._compute_router_positions()

    def _build_widgets(self):
        # Left: list of packet keys
        self.listbox = tk.Listbox(self, width=20)
        for key in sorted(self.packet_trace):
            self.listbox.insert(tk.END, hex(key))
        self.listbox.bind("<<ListboxSelect>>", self.on_select)
        self.listbox.grid(row=0, column=0, rowspan=3, sticky="ns")

        # Right: canvas for grid
        self.canvas = tk.Canvas(self, width=400, height=400, bg="white")
        self.canvas.grid(row=0, column=1, padx=10, pady=10)

        # Slider & label
        self.cycle_label = tk.Label(self, text="Cycle: –")
        self.cycle_label.grid(row=1, column=1, sticky="w", padx=10)
        self.scale = tk.Scale(self, from_=0, to=0, orient="horizontal",
                              command=self.on_slide, length=300)
        self.scale.grid(row=2, column=1, sticky="we", padx=10)
        
        # Rightmost: metadata panel
        self.meta_frame = tk.LabelFrame(self, text="Packet Metadata", padx=10, pady=10)
        self.meta_frame.grid(row=0, column=2, rowspan=3, sticky="n", padx=10, pady=10)

        # for each field, create a label
        fields = ["vc","ns_dir","ew_dir","y_hop","x_hop","y_src","x_src","data"]
        self.meta_labels = {}
        for i, fld in enumerate(fields):
            lbl = tk.Label(self.meta_frame, text=f"{fld}: –", anchor="w")
            lbl.grid(row=i, column=0, sticky="w")
            self.meta_labels[fld] = lbl

    def _compute_router_positions(self):
        # find all router coords, e.g. "router_2_3"
        coords = set()
        for traces in self.packet_trace.values():
            for pt in traces:
                _, x, y = pt.router.split('_')
                coords.add((int(x), int(y)))
        xs = [c[0] for c in coords]; ys = [c[1] for c in coords]
        self.min_x, self.max_x = min(xs), max(xs)
        self.min_y, self.max_y = min(ys), max(ys)
        # spacing & margin
        w = int(self.canvas['width']); h = int(self.canvas['height'])
        cols = self.max_x - self.min_x + 1
        rows = self.max_y - self.min_y + 1
        self.cell_w = w / (cols + 1)
        self.cell_h = h / (rows + 1)
        # map router name → canvas coords
        self.router_pos = {}
        for x,y in coords:
            px = (x - self.min_x + 1) * self.cell_w
            # invert y so that min_y at bottom
            py = h - (y - self.min_y + 1) * self.cell_h
            self.router_pos[f"router_{x}_{y}"] = (px, py)

        # draw all nodes
        self.node_ids = {}
        self.node_io_ids = {}    # input_out block IDs
        self.node_oi_ids = {}    # output_in block IDs
        
        r = min(self.cell_w, self.cell_h) * 0.3
        bx = r * 0.6
        by = r * 0.6
        for name, (cx, cy) in self.router_pos.items():
            nid = self.canvas.create_oval(cx-r, cy-r, cx+r, cy+r,
                                          fill="lightgray", outline="black")
            self.node_ids[name] = nid
            self.canvas.create_text(cx, cy, text=name.split('_')[-2] + ',' + name.split('_')[-1])
            
             # draw INPUT_OUT block (to the left)
            io_rect = self.canvas.create_rectangle(
                cx - r - bx, cy - by/2,
                cx - r,       cy + by/2,
                fill="white", outline="black"
            )
            self.node_io_ids[name] = io_rect
            self.canvas.create_text(
                cx - r - bx/2, cy,
                text="IN→OUT", font=("Arial", 7)
            )

            # draw OUTPUT_IN block (to the right)
            oi_rect = self.canvas.create_rectangle(
                cx + r,       cy - by/2,
                cx + r + bx,  cy + by/2,
                fill="white", outline="black"
            )
            self.node_oi_ids[name] = oi_rect
            self.canvas.create_text(
                cx + r + bx/2, cy,
                text="OUT→IN", font=("Arial", 7)
            )

    def on_select(self, evt):
        sel = evt.widget.curselection()
        if not sel: return
        key = int(self.listbox.get(sel[0]), 16)
        self.current_trace = sorted(self.packet_trace[key], key=lambda pt: pt.cycle)
        # configure slider
        self.scale.configure(to=len(self.current_trace)-1)
        self.scale.set(0)
        self._highlight_step(0)

    def on_slide(self, val):
        idx = int(val)
        self._highlight_step(idx)

    def _highlight_step(self, idx):
        pt = self.current_trace[idx]
        # update label
        self.cycle_label.config(text=f"Cycle {pt.cycle} @ {pt.router} ({pt.op})")
        # reset all nodes
        for nid in self.node_ids.values():
            self.canvas.itemconfig(nid, fill="lightgray")
        
        for io_id in self.node_io_ids.values():
            self.canvas.itemconfig(io_id, fill="white")

        # 3) reset all OUTPUT_IN blocks
        for oi_id in self.node_oi_ids.values():
            self.canvas.itemconfig(oi_id, fill="white")    
        
        # highlight this router
        nid = self.node_ids.get(pt.router)
        if nid:
            self.canvas.itemconfig(nid, fill="orange")
    
        # highlight the INPUT_OUT block on a certain op:
        if pt.op == "INPUT_OUT":
            self.canvas.itemconfig(self.node_io_ids[pt.router], fill="orange")
        elif pt.op == "OUTPUT_IN":
            self.canvas.itemconfig(self.node_oi_ids[pt.router], fill="orange")
        
         # update metadata panel
        for key, lbl in self.meta_labels.items():
            # packet fields are integers; format hex for 'data'
            val = pt.packet[key]
            text = hex(val) if key=="data" else str(val)
            lbl.config(text=f"{key}: {text}")


if __name__ == "__main__":
    root = tk.Tk()
    # ask for a trace file on startup
    path = filedialog.askopenfilename(title="Select packet trace CSV",
                                      filetypes=[("CSV","*.csv"),("All","*.*")])
    if not path:
        root.destroy()
    else:
        data = read_packet_trace(path)
        app = PacketTraceGUI(root, data)
        app.mainloop()
