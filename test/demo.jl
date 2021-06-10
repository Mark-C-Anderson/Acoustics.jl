using Pkg
using Plots
using Revise
import Acoustics: binfileload

x = binfileload("/Users/markanderson/Desktop",11,2)
fs = 51.2e3;
dt = 1/fs;
t = 0:dt:length(x)*dt-dt;
plot(t,x,
    label = "Waveform",
    title = "Falcon 9 Landing",
    xlabel = "Time (s)",
    ylabel = "Pressure (Pa)")