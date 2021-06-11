import FFTW: fft, fftshift, fftfreq
import Statistics: mean
import LinearAlgebra: conj
using DSP

function autospec(x,fs)

    # Get the waveform length
    N = length(x)

    # Define a block size
    ns = Int(fs/2)

    # Calculate the number of blocks
    # numBlocks = Int(floor(2*N/ns - 1)) # For 50% overlap case
    numBlocks = Int(floor(length(x)/ns))

    # Enforce zero-mean
    x = x .- mean(x)

    # Create the frequency array
    f = fs*(0:ns/2-1)/ns
    df = f[2]

    # Create a hanning window
    ww = DSP.Windows.hanning(ns)
    W = mean(ww.*conj(ww))
    Scale = 2/ns/fs/W

    # Perform the fft for each block
    summedSpectrum = zeros(2*length(f))
    for i = 1:numBlocks

        # Divide the waveform x into equally-sized blocks of length ns
        block = x[(i-1)*ns+1 : i*ns] # FIXME: We should do a 50% overlap

        # Windoow each block
        windowedBlock = ww.*block

        # Calculate the magnitude squared of the Fourier transform of each block
        # and average over the blocks
        spectrum = fft(windowedBlock)
        spectrum = conj(spectrum).*spectrum

        summedSpectrum = summedSpectrum .+ spectrum

    end

    # Averaging the spectrum
    averageSpectrum = summedSpectrum ./ numBlocks

    # Taking only the positive components
    spectrum = averageSpectrum[1:Int(length(averageSpectrum)/2)]

    Gxx = Real.(spectrum .* Scale) # Julia says this is complex, but 
                                # the imaginary parts are all zero

    OASPL = 0

    return Gxx, f, OASPL

end