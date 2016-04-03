%Program for calibrating the thermometers. Data from the Arduino will be
%recieved and displayed into a Temperature vs time graph. All data will be
%recorded.

clc
clear all;

%%Serial connection is established with the arduino

%Serial port used is requested to the user via a text box

prompt = {'Enter serial port'};
dgl_title = 'Welcome';
comPort= inputdlg(prompt,dgl_title)

%the arduino is set up
[s, flag]= setupSerial(comPort);

%the arduino runs its set up
disp('Setting up devices...')
setupCheck='b';
while (setupCheck ~='a')
    setupCheck=fread(s,1,'uchar');    %reads from the serial port a single binary element in 8bit precision unsigned charecter format until 'a' is read
end

time=0;

disp('Set up complete!')

%%Creating a log file where to log the data
log=logFile;

%%A figure is generated where the data will be printed

%initialize the figure that we will plot as well as the axes and labels
if(~exist('h','var')||~ishandle(h))
    h=figure(1);
end

set(gcf,'color','white');
title('Real-time temperature data');
xlabel('time');
ylabel('temperature');
ylim([20 45]);
legend('dall1','dall2','coupl1','coupl2','coupl3','therm1','therm2');
grid on;
hold on;
drawnow

%a buffer and index is created
maxbufsize=2;       %only 2 data will be taken in order to be able to draw properly the lines between one point and the next. This shouldn't be a problem as the data is recorded into a separate file anyway.
bufftemp1=zeros(maxbufsize);
bufftemp2=zeros(maxbufsize);
bufftemp3=zeros(maxbufsize);
bufftemp4=zeros(maxbufsize);
bufftemp5=zeros(maxbufsize);
bufftemp6=zeros(maxbufsize);
bufftemp7=zeros(maxbufsize);
bufftime=zeros(maxbufsize);
cont=1;

disp('Ready to record data!')

  
i=1;    %for simplicity sake, a no-end loop will be called in order to do the readings. To stop them the loop will be broken manually with the ctrl+c command
while i>0,
          %Temperature information is requested to the arduino (designated by the parameter 1)
  
  time=read(s,'M')/1000;
  
  [temp1,temp2,temp3,temp4,temp5,temp6,temp7]=readTemp(s);        %Time information is requested to the arduino (designated by the parameter 2)

  
  %%Displaying in realtime
  
  %save into buffer
  bufftemp1(cont)=temp1;
  bufftemp2(cont)=temp2;
  bufftemp3(cont)=temp3;
  bufftemp4(cont)=temp4;
  bufftemp5(cont)=temp5;
  bufftemp6(cont)=temp6*4/100;
  bufftemp7(cont)=temp7*4/100;
  bufftime(cont)=time;
  
  %set dynamic x limits too show the last 30s
  xlim([time-30 time]);
  
  %plotting all buffered temperatures wrt time
  plot(bufftime,bufftemp1,'-.dk','color','r');
  plot(bufftime,bufftemp2,'-.dk','color','b');
  plot(bufftime,bufftemp3,'-.dk','color','g');
  plot(bufftime,bufftemp4,'-.dk','color','c');
  plot(bufftime,bufftemp5,'-.dk','color','m');
  plot(bufftime,bufftemp6,'-.dk','color','y');
  plot(bufftime,bufftemp7,'-.dk','color','k');
  
  %copiing all the data taken in this iteration to the log file
  fprintf(log,'%f',time);
  fprintf(log,'\t');
  fprintf(log,'%f',temp1);
  fprintf(log,'\t');
  fprintf(log,'%f',temp2);
  fprintf(log,'\t');
  fprintf(log,'%f',temp3);
  fprintf(log,'\t');
  fprintf(log,'%f',temp4);
  fprintf(log,'\t');
  fprintf(log,'%f',temp5);
  fprintf(log,'\t');
  fprintf(log,'%f',temp6);
  fprintf(log,'\t');
  fprintf(log,'%f',temp7);
  fprintf(log,'\n');

  drawnow

  cont=cont+1;
  if (cont>maxbufsize)
      cont=1;
  end
  

end


fclose(s);