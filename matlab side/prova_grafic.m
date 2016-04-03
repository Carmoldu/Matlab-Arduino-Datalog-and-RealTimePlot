%%Program for calibrating the thermometers. Data from the Arduino will be
%recieved and displayed into a Temperature vs time graph. All data will be
%recorded.

clc
clear all;

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
ylim([0 7]);
grid on;
hold on;
drawnow

%a button is created in order to finish the readings

%a buffer and index is created is created
maxbufsize=2;
bufftemp1=zeros(maxbufsize);
bufftemp2=zeros(maxbufsize);
bufftemp3=zeros(maxbufsize);
bufftemp4=zeros(maxbufsize);
bufftemp5=zeros(maxbufsize);
bufftemp6=zeros(maxbufsize);
bufftemp7=zeros(maxbufsize);
bufftime=zeros(maxbufsize);
cont=1;

for i=0:500,
  temp1=randn;
  temp2=randn;
  temp3=randn;
  temp4=randn;
  temp5=randn;
  temp6=randn;
  temp7=randn;
  time=i*2;
  
  bufftemp1(cont)=temp1;
  bufftemp2(cont)=temp2;
  bufftemp3(cont)=temp3;
  bufftemp4(cont)=temp4;
  bufftemp5(cont)=temp5;
  bufftemp6(cont)=temp6;
  bufftemp7(cont)=temp7;
  bufftime(cont)=time;
  
  xlim([time-30 time]);
  
 plot(bufftime,bufftemp1,'-.dk','color','r');
 plot(bufftime,bufftemp2,'-.dk','color','b');
 plot(bufftime,bufftemp3,'-.dk','color','g');
 plot(bufftime,bufftemp4,'-.dk','color','c');
 plot(bufftime,bufftemp5,'-.dk','color','m');
 plot(bufftime,bufftemp6,'-.dk','color','y');
plot(bufftime,bufftemp7,'-.dk','color','k');

fprintf(log,'%f',bufftime(cont));
fprintf(log,'\t');
fprintf(log,'%f',bufftemp1(cont));
fprintf(log,'\t');
fprintf(log,'%f',bufftemp2(cont));
fprintf(log,'\t');
fprintf(log,'%f',bufftemp3(cont));
fprintf(log,'\t');
fprintf(log,'%f',bufftemp4(cont));
fprintf(log,'\t');
fprintf(log,'%f',bufftemp5(cont));
fprintf(log,'\t');
fprintf(log,'%f',bufftemp6(cont));
fprintf(log,'\t');
fprintf(log,'%f',bufftemp7(cont));
fprintf(log,'\n');



  drawnow

  cont=cont+1;
  if (cont>maxbufsize)
      cont=1;
  end
  pause(0.5);
end


fclose all;