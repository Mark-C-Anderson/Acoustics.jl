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

using Revise # This package helps Julia recognize when you've made edits to your code.
             # It should be run at the start of every Julia session

# ---- THIS SECTION IS JUST SIMPLE SETUP, DOES NOT NEED TO BE RUN MORE THAN ONCE ---- #
# using Pkg

# # Installing a good python plotting backend (Qt5Agg)
# using Conda
# Conda.pip_interop(true)
# Conda.add("matplotlib")
# Conda.pip("install","PyQt5")

# # Setting up python plotting
# ENV["PYTHON"] = "" # Forces Julia to use its own python distribution (independent of any other
#                    # python distribution on your computer)
# ENV["MPLBACKEND"] = "Qt5Agg" # A good plotting backend for matplotlib in python
# Pkg.build("PyCall") # Ensures that your PyCall package is using the updated features
# Pkg.build("PyPlot") # Ensures that your PyPlot package is using the updated features

# ---- END OF SETUP SECTION. IT WAS INCLUDED HERE JUST TO HELP NEW USERS. ---- #

# ---- NOW WE CAN GET TO THE ACTUAL ACOUSTICS WORK ---- #

# Using the necessary packages for this demo.
import PyPlot: figure, clf
using Plots; plotly() # For plotting
import Acoustics: binfileload, autospec # Getting access to the binfileload function

#----- Loading in data
figure()
clf()
x = binfileload("/Users/markanderson/Desktop",11,2)
fs = 51.2e3;
dt = 1/fs;
t = 0:dt:length(x)*dt-dt;
p = Plots.plot(t,x,
        label = "Waveform",
        title = "Falcon 9 Landing",
        xlabel = "Time (s)",
        ylabel = "Pressure (Pa)")
#display(p)

figure()
clf()
x = binfileload("/Users/markanderson/Desktop",6,1)
fs = 51.2e3;
dt = 1/fs;
t = 0:dt:length(x)*dt-dt;
p = Plots.plot(t,x,
    label = "Waveform",
    title = "Falcon 9 Launch",
    xlabel = "Time (s)",
    ylabel = "Pressure (Pa)")
#display(p)

#----- Performing spectral analysis

Gxx, f, OASPL = autospec(x,fs)

spectrum = 10*log10.(Gxx./(20e-6)^2)

figure()
clf()
p = Plots.plot(f,spectrum,xaxis=:log,xlimit = (1,20e3))
display(p)