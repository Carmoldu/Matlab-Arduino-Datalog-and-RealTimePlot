function t = logFile
%This function initialises a text file used as a log and sets the name of
%the parameters

nom_existent=2;
overwrite=0;

%a name for the log file is requested
while nom_existent~=0 && overwrite==0
    
    prompt = {'Enter name for the log file'};
    dgl_title = 'Creating log file';
    logfile_nameaux = inputdlg(prompt,dgl_title)
    logfile_name= logfile_nameaux{1};
    
    nom_existent=exist(logfile_name,'file');
   
    
    if nom_existent==2                      %this checks if a file with the same name exists
        question=questdlg('A file already ahs the name chose, do you want to overwrite it?','Overwrite','yes','no','no');       %if it exists, it is asked to the user if he wants to overwrite it or choose a new name

        switch question
            case 'yes'
                overwrite=1;
            case 'no'
                mbox=msgbox('Enter a new file name.');uiwait(mbox);
        end
    end
end

t=fopen(logfile_name,'wt');         %the text file is created and assigned to the object t, which will be the returned variable


%the first raw, which consists of the variable names, is created
fprintf(t,'Time\t');
fprintf(t,'Dallas1\t');
fprintf(t,'Dallas2\t');
fprintf(t,'Thermocouple1\t');
fprintf(t,'Thermocouple2\t');
fprintf(t,'Thermocouple3\t');
fprintf(t,'Thermistor1\t');
fprintf(t,'Thermistor2\n');


end

