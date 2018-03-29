%ProgressionPlot
hold on
axis off
set(gca, 'XLim', [-600 600], 'YLim', [0 1500]);
Question = input('Process:\n(1)All trials\n(2)Multiple trials\n(3)One trial\n');
if Question==1;
    TS = 1;
    load('ExpInfo');
elseif Question==2;
    TS = input('Which trial to start with?\n');
    NumTrials = input('Which trial to end with?\n');
elseif Question==3
    TS = input('Which trial to process?\n');
    NumTrials = TS;
end
for TrialNum = TS:NumTrials;
    load('ParticipantID');
    load('ExpInfo');
    if TrialNum<=9
        load(char(strcat(ExpName,{' '},ParticipantID,{' 0'},num2str(TrialNum),'.mat')));
    elseif TrialNum>9
        load(char(strcat(ExpName,{' '},ParticipantID,{' '},num2str(TrialNum),'.mat')));
    end
    
    TF = strcmp(TrialCondition,'Dummy Trial');
    
    if TF == 0;
        
        TF = strcmp(TrialCondition(1,1),'Stepping');
        
        if TF == 1
            
            TF = strcmp(TrialCondition(2,1),'Control');
            
            if TF == 1;
                line([0,Stepping.Progression.ML],[0,Stepping.Progression.AP],'Color','k','LineWidth',1.2);
            elseif TF == 0;
                TF = strcmp(TrialCondition(2,1),'Right');
                if TF == 1;
                    line([0,Stepping.Progression.ML],[0,Stepping.Progression.AP],'Color','r','LineWidth',1.2);
                elseif TF == 0
                    line([0,Stepping.Progression.ML],[0,Stepping.Progression.AP],'Color','b','LineWidth',1.2);
                end
            end
        end
    elseif TF == 1;
    end
    clearvars -except Participant
end
set(gcf,'visible','off')
rez=1200; %resolution (dpi) of final graphic
f=gcf; %f is the handle of the figure you want to export
figpos=getpixelposition(f); %dont need to change anything here
resolution=get(0,'ScreenPixelsPerInch'); %dont need to change anything here
set(f,'paperunits','inches','papersize',figpos(3:4)/resolution,'paperposition',[0 0 figpos(3:4)/resolution]); %dont need to change anything here
path= pwd; %the folder where you want to put the file
name = strcat(Participant,'_ProgressionPlots','.png');
print(f,fullfile(path,name),'-dpng','-r0','-opengl'); %save file
hold off
close all

        rez=1200; %resolution (dpi) of final graphic
        f=gcf; %f is the handle of the figure you want to export
        figpos=getpixelposition(f); %dont need to change anything here
        resolution=get(0,'ScreenPixelsPerInch'); %dont need to change anything here
        set(f,'paperunits','inches','papersize',figpos(3:4)/resolution,'paperposition',[0 0 figpos(3:4)/resolution]); %dont need to change anything here
        path= pwd; %the folder where you want to put the file
        
        if TrialNum<=9
            name = strcat(ExpName,{' '},ParticipantID,{' 0'},num2str(TrialNum),'Axial Segment Displacement','.tiff');
        elseif TrialNum>9
            name = strcat(ExpName,{' '},ParticipantID,{' '},num2str(TrialNum),'Axial Segment Displacement','.tiff');
        end %what you want the file to be called
        print(f,fullfile(path,name),'-dtiff','-r0','-zbuffer'); %save file
        close all
    else
    end
end

beep
msgbox('Progression Plot Complete');
clear
clc

Source = pwd;
Destination = strrep(Source,'MATLAB','Figures');
movefile(strcat(Source,'/*.png'),Destination);