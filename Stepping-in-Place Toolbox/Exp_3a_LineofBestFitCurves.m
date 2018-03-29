for TrialNum =1:30;
    load('Participant');
    if TrialNum<10;
        load(['Exp_3a_',Participant,'_0',num2str(TrialNum),'.mat']);
    elseif TrialNum>9
        load(['Exp_3a_',Participant,'_',num2str(TrialNum),'.mat']);
    end
    
    TF = strcmp(TrialCondition,'DummyTrial');
    
    if TF == 0;
        
        Gaze.Displacement = Head.Yaw.Displacement+EOG.Subsampled.Displacement.Filt30;
        X = [1:6000]';
        LineofFit = polyfit(X,Head.Yaw.Displacement,7);
        Head.Yaw.Trajectory = polyval(LineofFit,X);
        Head.Yaw.Velocity = (diff(Head.Yaw.Trajectory))*200;
        Head.Yaw.Acceleration = (diff(Head.Yaw.Velocity))*200;
        LineofFit = polyfit(X,Thorax.Yaw.Displacement,7);
        Thorax.Yaw.Trajectory = polyval(LineofFit,X);
        Thorax.Yaw.Velocity = (diff(Thorax.Yaw.Trajectory))*200;
        Thorax.Yaw.Acceleration = (diff(Thorax.Yaw.Velocity))*200;
        LineofFit = polyfit(X,Pelvis.Yaw.Displacement,7);
        Pelvis.Yaw.Trajectory = polyval(LineofFit,X);
        Pelvis.Yaw.Velocity = (diff(Pelvis.Yaw.Trajectory))*200;
        Pelvis.Yaw.Acceleration = (diff(Pelvis.Yaw.Velocity))*200;
        LineofFit = polyfit(X,LFoot.Yaw.Displacement,7);
        LFoot.Yaw.Trajectory = polyval(LineofFit,X);
        LFoot.Yaw.Velocity = (diff(LFoot.Yaw.Trajectory))*200;
        LFoot.Yaw.Acceleration = (diff(LFoot.Yaw.Velocity))*200;
        LineofFit = polyfit(X,RFoot.Yaw.Displacement,7);
        RFoot.Yaw.Trajectory = polyval(LineofFit,X);
        RFoot.Yaw.Trajectory = -RFoot.Yaw.Trajectory;
        RFoot.Yaw.Velocity = (diff(RFoot.Yaw.Trajectory))*200;
        RFoot.Yaw.Acceleration = (diff(RFoot.Yaw.Velocity))*200;
        
        plot(Gaze.Displacement,'k');
        hold
        plot(Head.Yaw.Trajectory,'b');
        plot(Thorax.Yaw.Trajectory,'g');
        plot(Pelvis.Yaw.Trajectory,'r');
        plot(LFoot.Yaw.Trajectory,':k');
        plot(RFoot.Yaw.Trajectory,'--k');
        pause
        hold off
        
LFoot.Steps = 0;

for N = 2:5999;
    if LFoot.Roll.Displacement(N-1)<LFoot.Roll.Displacement(N) && LFoot.Roll.Displacement(N+1)<LFoot.Roll.Displacement(N);
        LFoot.Steps = LFoot.Steps+1;
        LeftStepTimes(LFoot.Steps)= N; %#ok<*SAGROW>
    end
end

RFoot.Steps = 0;

for N = 2:5999;
    if RFoot.Roll.Displacement(N-1)<RFoot.Roll.Displacement(N) && RFoot.Roll.Displacement(N+1)<RFoot.Roll.Displacement(N);
        RFoot.Steps = RFoot.Steps+1;
        RightStepTimes(RFoot.Steps)= N; %#ok<*SAGROW>
    end
end
        
TotalSteps = LFoot.Steps+ RFoot.Steps;

SteppingFrequency = TotalSteps/30;

    else
    end
    
    clearvars -except Participant TrialNum TrialCondition Head Thorax Pelvis LFoot RFoot TotalSteps SteppingFrequency EOG FastPhases
    
    if TrialNum<10;
        save(['Exp_3a_',Participant,'_0',num2str(TrialNum),'.mat']);
    elseif TrialNum>9
        save(['Exp_3a_',Participant,'_',num2str(TrialNum),'.mat']);
    end
    clear
end

beep
h = msgbox('Dependent Variables Script Complete');
clear
clc