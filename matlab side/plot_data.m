function plot_data(bufftime, bufftemp, cont)
%This function plots a series of buffered data
if (cont>1)
    
    temporal_temp_buff=zeros(1,2);
    temporal_time_buff=zeros(1,2);

    temporal_temp_buff(1,1)=bufftemp(1,cont-1);
    temporal_temp_buff(1,2)=bufftemp(1,cont);

    temporal_time_buff(1,1)=bufftime(1,cont-1);
    temporal_time_buff(1,2)=bufftime(1,cont);

    plot(temporal_time_buff,temporal_temp_buff,'-.dk','color','r');
end
end

