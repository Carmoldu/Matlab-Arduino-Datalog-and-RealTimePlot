function output = read(s, mode)
%Reads an inputt from the arduino
 

%send request for information read
fprintf(s,mode);

%read the value returned
output=fscanf(s,'%f');

end

