function pause_call_calibration( hObject,eventdata,handles )

button_state=get(hObject,'Value');

while button_state == 'Max'
    uiwait
    
    disp('Im paused')
    pause(0.5)
end


end

