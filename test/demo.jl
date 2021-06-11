# Instructions for running:
# 1. You must be inside the Acoustics folder
# 2. Open the Julia terminal (whether in your IDE or command line application)
# 3. Press the ] key to activate the package manager
# 4. Type "activate ." to activate the Acoustics virtual environment
# 5. Type "instantiate" to tell Julia to checkout the proper versions of each dependency
#    as specified in the Manifest file. If this is your first time, this will take a while
#    because Julia needs to download all the right packages, a one-time occurence.
# 6. Press the backspace/delete key on your keyboard to exit the package manager
# 7. Use the include() command to run this code (the path will be different depending
#    on where you are in your folder structure):
#
#       julia> include("test/demo.jl")
#
#    And there you go! Just use that include() command each time you want to run the code!

# Using the necessary packages for this demo
using Revise # This package helps Julia recognize when you've made edits to your code
using Plots # For plotting
import Acoustics: binfileload # Getting access to the binfileload function

# Choosing a nice plotting backend
plotlyjs() # This makes plots that are maneuverable, similar to MATLAB
# Plots.PlotlyJSBackend()

#----- Loading in data
x = binfileload("/Users/markanderson/Desktop",11,2)
fs = 51.2e3;
dt = 1/fs;
t = 0:dt:length(x)*dt-dt;
plot(t,x,
    label = "Waveform",
    title = "Falcon 9 Landing",
    xlabel = "Time (s)",
    ylabel = "Pressure (Pa)")
gui()