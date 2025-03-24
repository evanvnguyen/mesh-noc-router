# Description: A PowerShell script to compile and run Verilog simulations using Icarus Verilog.
# Usage: ./sim.ps1 [-compileOnly] [-waveform]
# -compileOnly: Only compile the Verilog files without running the simulation.
# -waveform: Open the waveform viewer (GTKWave) after running the simulation.
# Note: Make sure to install Icarus Verilog and GTKWave before running this script.
#       You can download Icarus Verilog from http://iverilog.icarus.com/ and GTKWave from http://gtkwave.sourceforge.net/
#       This script assumes the Verilog files are located in the 'design' and 'tb' directories.
#       The compiled output will be stored in the 'iverilog-out' directory.
#       The VCD dump file will be stored in the 'iverilog-out' directory.
#
#       You need to add the $dumpfile() and $dumpvars() functions in your testbench to generate the VCD file.
#       Example:
#       initial begin
#           $dumpfile("iverilog-out/dump.vcd");
#           $dumpvars(0, testbench);
#       end
#       This will create a VCD file named 'dump.vcd' with the signals from the 'testbench' module.
param (
    [switch]$compileOnly = $false,
    [switch]$waveform = $false,
    [String]$tbModule = ""
)

# Set directories
$designDir = "src"
$tbDir = "tb"
$outputFile = ".\iverilog-out\sim.out"
$vcdFile = ".\iverilog-out\dump.vcd"
$ignoreFiles = @("dummy_cpu.v",
    "mesh_top.v",
    "mesh_top_dont_use.v",
    #"mesh_top_flat.v", 
    "mesh_top_flat_2x2.v"
    #"mesh_top_row_0.v", 
    #"mesh_top_row_1.v", 
    #"mesh_top_row_2.v", 
    #"mesh_top_row_3.v", 
    #"tb_mesh_top_flat.v"
)

# Find all Verilog files
if ($tbModule -eq "") {
    $verilogFiles = Get-ChildItem -Path $designDir, $tbDir -Filter "*.v" -Recurse | ForEach-Object { $_.FullName }
}
else {
    $verilogFiles = Get-ChildItem -Path $designDir -Filter "*.v" -Recurse | ForEach-Object { $_.FullName }
    $verilogFiles += Get-Item -Path "$tbDir\$tbModule" | ForEach-Object { $_.FullName }
}

# Exclude ignored files
$verilogFiles = $verilogFiles | Where-Object { $ignoreFiles -notcontains [System.IO.Path]::GetFileName($_) }

# Compile the Verilog files
Write-Host "Compiling Verilog files..."
$compileCmd = "iverilog -o $outputFile $($verilogFiles -join ' ')"
Invoke-Expression $compileCmd

# Check if compilation was successful
if ($?) {
    Write-Host "Compilation successful."

    if ($compileOnly -eq $false) {
        # Run the simulation
        Write-Host "Running simulation..."
        $simulateCmd = "vvp $outputFile"
        Invoke-Expression $simulateCmd

        if ($waveform) {
            # Check if simulation created the VCD file
            if (Test-Path $vcdFile) {
                Write-Host "Simulation complete. Launching GTKWave..."
                Start-Process "gtkwave" -ArgumentList $vcdFile
            }
            else {
                Write-Host "Error: $vcdFile not found. Make sure your testbench includes dumping."
            }
        }
    }
}
else {
    Write-Host "Compilation failed. Check your Verilog code for errors."
}
