function binfileload(path::String,IDnum::Int,CHnum::Int)
    
    # Zero-padding the ID and CH numbers
    IDnum = lpad(IDnum,3,"0")
    CHnum = lpad(CHnum,3,"0")
    IDname = "ID"
    CHname = ""

    filename = string(path,"/",IDname,IDnum,"_",CHname,CHnum,".bin")

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