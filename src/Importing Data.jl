function binfileload(filename)
    
    io = open(filename,"r")
    
    fileLength = Int(length(read(io))/4)
    
    dataTypeInfo = Array{Float32,1}(undef,fileLength)
    
    # For some reason, I had to close and then re-open the file or it gave me
    # "End-of-file" warnings
    close(io)
    io = open(filename,"r")
    
    x = read!(io,dataTypeInfo)
    
    close(io)
    
    return x
    
end