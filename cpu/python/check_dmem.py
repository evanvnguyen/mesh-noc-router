import csv
import tkinter as tk
from tkinter import filedialog, scrolledtext, messagebox

def load_unique_tuples(filename):
    """
    Reads the CSV (or log/txt) file and returns a set of unique tuples
    (last9_data, x_source, y_source), where last9_data is the last 9 characters of the 'data' field.
    Skips rows that do not have 'data', 'x_source', or 'y_source' or if they are blank.
    """
    unique_tuples = set()
    try:
        with open(filename, 'r', newline='') as csvfile:
            reader = csv.DictReader(csvfile, delimiter=',')
            for row in reader:
                if not row:
                    continue

                # Retrieve values for the desired columns
                data_val = row.get('data')
                x_val    = row.get('x_source')
                y_val    = row.get('y_source')
                
                if data_val is None or x_val is None or y_val is None:
                    continue

                # Remove extra spaces
                data_val = data_val.strip()
                x_val    = x_val.strip()
                y_val    = y_val.strip()

                # Skip if any are empty strings
                if not data_val or not x_val or not y_val:
                    continue

                # Extract the last 9 characters for data comparison if possible
                if len(data_val) >= 9:
                    data_val = data_val[-9:]
                
                unique_tuples.add((data_val, x_val, y_val))
    except Exception as e:
        messagebox.showerror("Error", f"Could not read {filename}:\n{e}")
    return unique_tuples

def select_inject_file():
    """Let the user select the cpu_inject_log file (log, csv, or txt)."""
    filepath = filedialog.askopenfilename(
        title="Select cpu_inject_log file",
        initialdir=".",
        filetypes=[
            ("Log Files", "*.log"),
            ("CSV Files", "*.csv"),
            ("Text Files", "*.txt"),
            ("All Files", "*.*")
        ]
    )
    if filepath:
        inject_file_entry.delete(0, tk.END)
        inject_file_entry.insert(0, filepath)

def select_dmem_file():
    """Let the user select the cpu_x_y_dmem file (log, csv, or txt)."""
    filepath = filedialog.askopenfilename(
        title="Select cpu_0_0_dmem file",
        initialdir=".",
        filetypes=[
            ("Log Files", "*.log"),
            ("CSV Files", "*.csv"),
            ("Text Files", "*.txt"),
            ("All Files", "*.*")
        ]
    )
    if filepath:
        dmem_file_entry.delete(0, tk.END)
        dmem_file_entry.insert(0, filepath)

def run_comparison():
    """
    Compare the unique (data, x_source, y_source) tuples between the two log files.
    The data field is compared using the last 9 characters.
    If all tuples in the inject file are present in the dmem file, display "CPU DMEM MATCH".
    Otherwise, display each mismatched tuple in a friendly format.
    
    If the "Show Matches" checkbox is selected, the matches will also be printed.
    """
    inject_filepath = inject_file_entry.get().strip()
    dmem_filepath   = dmem_file_entry.get().strip()

    if not inject_filepath or not dmem_filepath:
        messagebox.showwarning("File Missing", "Please select both files before running the comparison.")
        return

    inject_set = load_unique_tuples(inject_filepath)
    dmem_set   = load_unique_tuples(dmem_filepath)

    # Determine mismatches and matches
    mismatches = inject_set - dmem_set
    matches    = inject_set & dmem_set

    # Clear the output area
    output_text.delete("1.0", tk.END)
    
    if not mismatches:
        output_text.insert(tk.END, "CPU DMEM MATCH!! :==)\n")
    else:
        output_text.insert(tk.END, "DMEM mismatches found:\n\n")
        for (data_val, x_val, y_val) in mismatches:
            output_text.insert(tk.END, f"Data [{data_val}] from source router [{x_val}, {y_val}] is not passed to DMEM.\n\n")
    
    # If checkbox is selected, display the matches as well
    if show_matches.get():
        output_text.insert(tk.END, "DMEM matches found:\n\n")
        for (data_val, x_val, y_val) in matches:
            output_text.insert(tk.END, f"Data [{data_val}] from source router [{x_val}, {y_val}] is successfully passed to DMEM.\n\n")

# ------------------- GUI SETUP -------------------
root = tk.Tk()
root.title("CPU DMEM Log Comparator")

# Optionally set an initial window size; with grid configuration it will be resizable.
root.geometry("800x600")

# Make the root window resizable using grid weight configuration.
root.rowconfigure(0, weight=1)
root.columnconfigure(0, weight=1)

# Create the main frame.
frame = tk.Frame(root, padx=10, pady=10)
frame.grid(row=0, column=0, sticky="nsew")
frame.rowconfigure(4, weight=1)  # The scrolled text is in row 4
frame.columnconfigure(0, weight=1)
frame.columnconfigure(1, weight=1)
frame.columnconfigure(2, weight=1)

# Row 0: CPU Inject Log file selection
tk.Label(frame, text="Select cpu_inject_log file:").grid(row=0, column=0, sticky=tk.W, pady=5)
inject_file_entry = tk.Entry(frame)
inject_file_entry.grid(row=0, column=1, padx=5, sticky="ew")
tk.Button(frame, text="Browse...", command=select_inject_file).grid(row=0, column=2, padx=5)

# Row 1: CPU DMEM Log file selection
tk.Label(frame, text="Select cpu_x_y_dmem file:").grid(row=1, column=0, sticky=tk.W, pady=5)
dmem_file_entry = tk.Entry(frame)
dmem_file_entry.grid(row=1, column=1, padx=5, sticky="ew")
tk.Button(frame, text="Browse...", command=select_dmem_file).grid(row=1, column=2, padx=5)

# Row 2: "Run Comparison" button
tk.Button(frame, text="Run Comparison", command=run_comparison, padx=10, pady=5).grid(row=2, column=1, pady=10)

# Row 3: Checkbox for showing matches
show_matches = tk.BooleanVar()
show_matches.set(False)  # Default is unchecked
tk.Checkbutton(frame, text="Show Matches", variable=show_matches).grid(row=3, column=0, columnspan=3, sticky="w", padx=5, pady=5)

# Row 4: ScrolledText for output; this row expands with the window.
output_text = scrolledtext.ScrolledText(frame)
output_text.grid(row=4, column=0, columnspan=3, sticky="nsew", pady=5, padx=5)

root.mainloop()