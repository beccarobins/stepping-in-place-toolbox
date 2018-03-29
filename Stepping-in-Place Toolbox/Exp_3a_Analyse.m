for TrialNum =1:30;
    load('Participant');
    if TrialNum<10;
        load(['Exp_3a_',Participant,'_0',num2str(TrialNum),'.mat']);
    elseif TrialNum>9
        load(['Exp_3a_',Participant,'_',num2str(TrialNum),'.mat']);
    end
    
    TF = strcmp(TrialCondition,'DummyTrial');
    
    if TF == 0;
        TF = strcmp(TrialCondition(1,1),'Standing');
        if TF == 1;
            [Pelvis.ML.DisplacementVariables.Min,Pelvis.ML.DisplacementVariables.MinTime] = min(Pelvis.ML.Displacement);
            [Pelvis.ML.DisplacementVariables.Max,Pelvis.ML.DisplacementVariables.MaxTime] = max(Pelvis.ML.Displacement);
            Pelvis.ML.DisplacementVariables.Range = Pelvis.ML.DisplacementVariables.Max-Pelvis.ML.DisplacementVariables.Min;
            Pelvis.ML.DisplacementVariables.Mean = mean(Pelvis.ML.Displacement);
            Pelvis.ML.DisplacementVariables.SD = std(Pelvis.ML.Displacement);
            [Pelvis.AP.DisplacementVariables.Min,Pelvis.AP.DisplacementVariables.MinTime] = min(Pelvis.AP.Displacement);
            [Pelvis.AP.DisplacementVariables.Max,Pelvis.AP.DisplacementVariables.MaxTime] = max(Pelvis.AP.Displacement);
            Pelvis.AP.DisplacementVariables.Range = Pelvis.AP.DisplacementVariables.Max-Pelvis.AP.DisplacementVariables.Min;
            Pelvis.AP.DisplacementVariables.Mean = mean(Pelvis.AP.Displacement);
            Pelvis.AP.DisplacementVariables.SD = std(Pelvis.AP.Displacement);
            Pelvis.ML.Velocity = (diff(Pelvis.ML.Displacement))*200;
            Pelvis.AP.Velocity = (diff(Pelvis.AP.Displacement))*200;
            
            [Pelvis.ML.VelocityVariables.Min,Pelvis.ML.VelocityVariables.MinTime] = min(Pelvis.ML.Velocity);
            [Pelvis.ML.VelocityVariables.Max,Pelvis.ML.VelocityVariables.MaxTime] = max(Pelvis.ML.Velocity);
            Pelvis.ML.VelocityVariables.Range = Pelvis.ML.VelocityVariables.Max-Pelvis.ML.VelocityVariables.Min;
            Pelvis.ML.VelocityVariables.SD = std(Pelvis.ML.Velocity);
            [Pelvis.AP.VelocityVariables.Min,Pelvis.AP.VelocityVariables.MinTime] = min(Pelvis.AP.Velocity);
            [Pelvis.AP.VelocityVariables.Max,Pelvis.AP.VelocityVariables.MaxTime] = max(Pelvis.AP.Velocity);
            Pelvis.AP.VelocityVariables.Range = Pelvis.AP.VelocityVariables.Max-Pelvis.AP.VelocityVariables.Min;
            Pelvis.AP.VelocityVariables.SD = std(Pelvis.AP.Velocity);
            
            HeadonThorax.Yaw.Displacement = Head.Yaw.Displacement-Thorax.Yaw.Displacement;
            HeadonThorax.Yaw.DisplacementVariables.Max = max(HeadonThorax.Yaw.Displacement);
            HeadonThorax.Yaw.DisplacementVariables.SD = std(HeadonThorax.Yaw.Displacement);
            
        elseif TF ==0;
            
            LToe.ML.DisplacementVariables.End = -1*(LToe.ML.Displacement(6000,1));
            RToe.ML.DisplacementVariables.End = -1*(RToe.ML.Displacement(6000,1));
            LToe.AP.DisplacementVariables.End = abs(LToe.AP.Displacement(6000,1));
            RToe.AP.DisplacementVariables.End = abs(RToe.AP.Displacement(6000,1));
            Stepping.Progression.ML = (LToe.ML.DisplacementVariables.End+RToe.ML.DisplacementVariables.End)/2;
            Stepping.Progression.AP = (LToe.AP.DisplacementVariables.End+RToe.AP.DisplacementVariables.End)/2;
            %Pythagorean theorem
            Stepping.Progression.Length = sqrt(Stepping.Progression.ML^2+Stepping.Progression.AP ^2);
            %angle = inverse sine(adjacent/hypotenuse);
            Angle = asind(abs(Stepping.Progression.ML)/Stepping.Progression.Length);
            if Stepping.Progression.ML>0
                Stepping.Progression.Direction = 90-Angle;
            else
                Stepping.Progression.Direction = 90+Angle;
            end
            Stepping.Progression.AbsDeviation = abs(90-Stepping.Progression.Direction);
            LToe.SI.Velocity = 200*(diff(LToe.SI.Displacement));
            RToe.SI.Velocity = 200*(diff(RToe.SI.Displacement));
            HeadonThorax.Yaw.Displacement = Head.Yaw.Displacement-Thorax.Yaw.Displacement;
            HeadonThorax.Yaw.DisplacementVariables.Max = max(HeadonThorax.Yaw.Displacement);
            HeadonThorax.Yaw.DisplacementVariables.SD = std(HeadonThorax.Yaw.Displacement);
            
            LeftSteps = 0;
            
            for N = 2:5998;
                if LToe.SI.Velocity(N-1)<LToe.SI.Velocity(N) && LToe.SI.Velocity(N+1)<LToe.SI.Velocity(N)&& LToe.SI.Velocity(N)>=100;
                    LeftSteps = LeftSteps+1;
                end
            end
            
            RightSteps = 0;
            
            for N = 2:5998;
                if RToe.SI.Velocity(N-1)<RToe.SI.Velocity(N) && RToe.SI.Velocity(N+1)<RToe.SI.Velocity(N)&& RToe.SI.Velocity(N)>=100;
                    RightSteps = RightSteps+1;
                end
            end
            
            Stepping.TotalSteps = LeftSteps+RightSteps;
            Stepping.Frequency = Stepping.TotalSteps/30;
            
            %Stepping progress results adjusted to right hand reference
            %system
            
            clearvars -except EOG FilteredKinematics Head HeadonThorax LFoot LToe Participant Pelvis RFoot RToe RawEOG RawKinematics Stepping Thorax TrialCondition TrialNum
            
        end
        if TrialNum<10;
            save(['Exp_3a_',Participant,'_0',num2str(TrialNum),'.mat']);
        elseif TrialNum>9
            save(['Exp_3a_',Participant,'_',num2str(TrialNum),'.mat']);
        end
    else
    end
    close all
    clear
end

beep
msgbox('Analyse Script Complete');
clear
clc