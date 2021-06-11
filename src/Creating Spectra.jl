function autospec(x,fs)

    Gxx = fft(x) |> fftshift
    f = fftfreq(length(x),fs) |> fftshift

    OASPL = 0

    return Gxx, f, OASPL

end