using Pkg
using Plots
import Acoustics: binfileload

x = binfileload("/Users/markanderson/Desktop/ID011_002.bin")
fs = 51.2e3;
dt = 1/fs;
t = 0:dt:length(x)*dt-dt;
plot(t,x)