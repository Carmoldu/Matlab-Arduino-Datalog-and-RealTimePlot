function [ s,flag ] = setupSerial( comPort )
%setupSerial sets up the comunication with the port comPort and checks if
%the devices (commputer-arduino) are actually comunicating. If the setup was successful, the
%value of setup is returned as 1

disp('Setting up communication with the arduino...');

flag=1;

instrreset  %it resets all open ports. It is useful if the code has broken before getting to an fclose)

%a serial port object is created which is assigned to "s" and the fields of
%"s" are set as the ones from the arduino
s=serial(comPort,'BaudRate',9600,'Parity','none','DataBits',8,'StopBits',1, 'terminator',' ');      


fopen(s);   %this function connects the matlab with the arduino connected at comPort
pause(2);   %Arduino resets when the comunication is opened, so it has to be given time


%Checking communication from the arduino. A character sent from the arduino
%must be read in order to continue

serialCheck='b';
disp('Checking serial read...')
while (serialCheck ~='a')
    serialCheck=fread(s,1,'uchar');    %reads from the serial port a single binary element in 8bit precision unsigned charecter format until 'a' is read
end

if (serialCheck == 'a')
    disp('              Checked!');
end

%checking communication to the arduino. A charackter is sent to the arduino
%to see if it recieves it

disp('Checking serial write...')
fwrite(s,'a','uchar'); % 'a' in character format is sent to the serial port "s"

serialCheck='b';

while (serialCheck ~='a')
    serialCheck=fread(s,1,'uchar');    %this loop will check for an echo of the data sent to the arduino in order to confirm it was recieved
end

if (serialCheck == 'a')
    disp('              Checked!');
end

mbox=msgbox('Serial communicationn has been set up correctly.'); uiwait(mbox);  %a message box will pop when comunication is set and confirmed in both directions. program will stop until msgbox is closed.




end

