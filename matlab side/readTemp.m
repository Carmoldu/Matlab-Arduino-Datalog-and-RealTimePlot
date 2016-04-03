function [output1,output2,output3,output4,output5,output6,output7] = readTemp(s)
%Reads an input from the arduino, sending first a message to let the
%arduino know that the temperature is the info requested

%send request for information read
fprintf(s,'T');

%recieve the data requested
output1=fscanf(s,'%f');
output2=fscanf(s,'%f');
output3=fscanf(s,'%f');
output4=fscanf(s,'%f');
output5=fscanf(s,'%f');
output6=fscanf(s,'%f');
output7=fscanf(s,'%f');

end

