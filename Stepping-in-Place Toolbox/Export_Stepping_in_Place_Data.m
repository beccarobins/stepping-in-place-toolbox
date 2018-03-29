Exp = {'Participant'};
load('ExpInfo');
[j,k] = size(ExpConditions);
for c = 1:j
    Exp = horzcat(Exp,ExpConditions(c,1)); %#ok<*AGROW>
end
Exp = horzcat(Exp,'Trial Number');
Heading = {};
HeadingsExport  = horzcat(HeadingsExport,'Head on Trunk Max');
HeadingsExport  = horzcat(HeadingsExport,'End ML Position');
HeadingsExport  = horzcat(HeadingsExport,'End AP Position');
HeadingsExport  = horzcat(HeadingsExport,'Length of Progression');
HeadingsExport  = horzcat(HeadingsExport,'Direction of Progression');
HeadingsExport  = horzcat(HeadingsExport,'Absolute Deviation');
HeadingsExport  = horzcat(HeadingsExport,'Stepping Frequency');

HeadingExport = horzcat(Exp,Heading);

load('ParticipantID');
load('ExpInfo');

Filename = sprintf(char(strcat(ExpName,{' '},ParticipantID,{' '},'Axial Segment Data.xlsx')));
warning('off','all');
xlswrite(Filename,HeadingExport,'Trial Data','A1');
xlswrite(Filename,HeadingExport,'Mean Data','A1');
TF = strcmp(ExpConditions(1,1),'Direction');
if TF==1
    xlswrite(Filename,HeadingExport,'Collapsed Mean Data','A1');
end

excelFilePath = pwd; % Current working directory.
sheetName = 'Sheet'; % EN: Sheet, DE: Tabelle, etc. (Lang. dependent)
% Open Excel file.
objExcel = actxserver('Excel.Application');
objExcel.Workbooks.Open(fullfile(excelFilePath, Filename)); % Full path is necessary!
% Delete sheets.
try
    % Throws an error if the sheets do not exist.
    objExcel.ActiveWorkbook.Worksheets.Item([sheetName '1']).Delete;
    objExcel.ActiveWorkbook.Worksheets.Item([sheetName '2']).Delete;
    objExcel.ActiveWorkbook.Worksheets.Item([sheetName '3']).Delete;
catch
    % Do nothing.
end
% Save, close and clean up.
objExcel.ActiveWorkbook.Save;
objExcel.ActiveWorkbook.Close;
objExcel.Quit;
objExcel.delete;
%xlswrite(Filename,Heading,'Sheet1','CV1');
for k = 1:NumTrials
    ParticipantNum(k,:) = {ParticipantID}; %#ok<*SAGROW>
    TrialNumbers(k,:) = num2cell(k);
    Conditions(k,:) = {ParticipantID};
end
Conditions = horzcat(Conditions,TrialList,TrialNumbers);
for TrialNum = 1:NumTrials;
    load('ParticipantID');
    load('ExpInfo');
    if TrialNum<=9
        load(char(strcat(ExpName,{' '},ParticipantID,{' 0'},num2str(TrialNum),'.mat')));
    elseif TrialNum>9
        load(char(strcat(ExpName,{' '},ParticipantID,{' '},num2str(TrialNum),'.mat')));
    end
    
    TF = strcmp(TrialCondition,'Dummy Trial');
    
    if TF == 0;
        DataExport = {};
        for j = 1:3
            if j == 1;
                Direction = 'Yaw';
            elseif j == 2
                Direction = 'Roll';
            elseif j == 3
                Direction = 'Pitch';
            end
            DataExport = horzcat(DataExport,eval(strcat('Head.',Direction,'.DisplacementVariables.OnsetLatency_sec')));
            DataExport = horzcat(DataExport,eval(strcat('Thorax.',Direction,'.DisplacementVariables.OnsetLatency_sec')));
            DataExport = horzcat(DataExport,eval(strcat('Pelvis.',Direction,'.DisplacementVariables.OnsetLatency_sec')));
            DataExport = horzcat(DataExport,eval(strcat('Head.',Direction,'.DisplacementVariables.EndTime_sec')));
            DataExport = horzcat(DataExport,eval(strcat('Thorax.',Direction,'.DisplacementVariables.EndTime_sec')));
            DataExport = horzcat(DataExport,eval(strcat('Pelvis.',Direction,'.DisplacementVariables.EndTime_sec')));
            DataExport = horzcat(DataExport,eval(strcat('Head.',Direction,'.DisplacementVariables.Direction')));
            DataExport = horzcat(DataExport,eval(strcat('Thorax.',Direction,'.DisplacementVariables.Direction')));
            DataExport = horzcat(DataExport,eval(strcat('Pelvis.',Direction,'.DisplacementVariables.Direction')));
            DataExport = horzcat(DataExport,eval(strcat('Head.',Direction,'.DisplacementVariables.Max')));
            DataExport = horzcat(DataExport,eval(strcat('Thorax.',Direction,'.DisplacementVariables.Max')));
            DataExport = horzcat(DataExport,eval(strcat('Pelvis.',Direction,'.DisplacementVariables.Max')));
            DataExport = horzcat(DataExport,eval(strcat('Head.',Direction,'.DisplacementVariables.MaxTime')));
            DataExport = horzcat(DataExport,eval(strcat('Thorax.',Direction,'.DisplacementVariables.MaxTime')));
            DataExport = horzcat(DataExport,eval(strcat('Pelvis.',Direction,'.DisplacementVariables.MaxTime')));
            DataExport = horzcat(DataExport,eval(strcat('Head.',Direction,'.DisplacementVariables.Range')));
            DataExport = horzcat(DataExport,eval(strcat('Thorax.',Direction,'.DisplacementVariables.Range')));
            DataExport = horzcat(DataExport,eval(strcat('Pelvis.',Direction,'.DisplacementVariables.Range')));
            DataExport = horzcat(DataExport,eval(strcat('Head.',Direction,'.DisplacementVariables.SD')));
            DataExport = horzcat(DataExport,eval(strcat('Thorax.',Direction,'.DisplacementVariables.SD')));
            DataExport = horzcat(DataExport,eval(strcat('Pelvis.',Direction,'.DisplacementVariables.SD')));
            DataExport = horzcat(DataExport,eval(strcat('Head.',Direction,'.DisplacementVariables.RMS')));
            DataExport = horzcat(DataExport,eval(strcat('Thorax.',Direction,'.DisplacementVariables.RMS')));
            DataExport = horzcat(DataExport,eval(strcat('Pelvis.',Direction,'.DisplacementVariables.RMS')));
            DataExport = horzcat(DataExport,eval(strcat('Head.',Direction,'.VelocityVariables.Max')));
            DataExport = horzcat(DataExport,eval(strcat('Thorax.',Direction,'.VelocityVariables.Max')));
            DataExport = horzcat(DataExport,eval(strcat('Pelvis.',Direction,'.VelocityVariables.Max')));
            DataExport = horzcat(DataExport,eval(strcat('Head.',Direction,'.VelocityVariables.MaxTime')));
            DataExport = horzcat(DataExport,eval(strcat('Thorax.',Direction,'.VelocityVariables.MaxTime')));
            DataExport = horzcat(DataExport,eval(strcat('Pelvis.',Direction,'.VelocityVariables.MaxTime')));
            DataExport = horzcat(DataExport,eval(strcat('Head.',Direction,'.VelocityVariables.SD')));
            DataExport = horzcat(DataExport,eval(strcat('Thorax.',Direction,'.VelocityVariables.SD')));
            DataExport = horzcat(DataExport,eval(strcat('Pelvis.',Direction,'.VelocityVariables.SD')));
            DataExport = horzcat(DataExport,eval(strcat('Head.',Direction,'.VelocityVariables.RMS')));
            DataExport = horzcat(DataExport,eval(strcat('Thorax.',Direction,'.VelocityVariables.RMS')));
            DataExport = horzcat(DataExport,eval(strcat('Pelvis.',Direction,'.VelocityVariables.RMS')));
            DataExport = horzcat(DataExport,eval(strcat('Head.',Direction,'.AccelerationVariables.Max')));
            DataExport = horzcat(DataExport,eval(strcat('Thorax.',Direction,'.AccelerationVariables.Max')));
            DataExport = horzcat(DataExport,eval(strcat('Pelvis.',Direction,'.AccelerationVariables.Max')));
            DataExport = horzcat(DataExport,eval(strcat('Head.',Direction,'.AccelerationVariables.MaxTime')));
            DataExport = horzcat(DataExport,eval(strcat('Thorax.',Direction,'.AccelerationVariables.MaxTime')));
            DataExport = horzcat(DataExport,eval(strcat('Pelvis.',Direction,'.AccelerationVariables.MaxTime')));
            DataExport = horzcat(DataExport,eval(strcat('Head.',Direction,'.AccelerationVariables.SD')));
            DataExport = horzcat(DataExport,eval(strcat('Thorax.',Direction,'.AccelerationVariables.SD')));
            DataExport = horzcat(DataExport,eval(strcat('Pelvis.',Direction,'.AccelerationVariables.SD')));
            DataExport = horzcat(DataExport,eval(strcat('Head.',Direction,'.AccelerationVariables.RMS')));
            DataExport = horzcat(DataExport,eval(strcat('Thorax.',Direction,'.AccelerationVariables.RMS')));
            DataExport = horzcat(DataExport,eval(strcat('Pelvis.',Direction,'.AccelerationVariables.RMS')));
        end
        %Intersegmental
        for j = 1:3
            if j == 1;
                Direction = 'Yaw';
            elseif j == 2
                Direction = 'Roll';
            elseif j == 3
                Direction = 'Pitch';
            end
            for k = 1:3
                if k == 1;
                    Relationship = 'HeadonThorax';
                elseif k == 2
                    Relationship = 'HeadonPelvis';
                elseif k == 3
                    Relationship = 'ThoraxonPelvis';
                end
                DataExport = horzcat(DataExport,eval(strcat('NormalizedData.TimeNormalized.',Relationship,'.',Direction,'.DisplacementVariables.Max')));
                DataExport = horzcat(DataExport,eval(strcat('NormalizedData.TimeNormalized.',Relationship,'.',Direction,'.DisplacementVariables.MaxTime')));
                DataExport = horzcat(DataExport,eval(strcat('NormalizedData.TimeNormalized.',Relationship,'.',Direction,'.DisplacementVariables.AI')));
                DataExport = horzcat(DataExport,eval(strcat('NormalizedData.TimeNormalized.',Relationship,'.',Direction,'.DisplacementVariables.CCCoeff_r')));
                DataExport = horzcat(DataExport,eval(strcat('NormalizedData.TimeNormalized.',Relationship,'.',Direction,'.DisplacementVariables.TimeLag')));
                DataExport = horzcat(DataExport,eval(strcat('NormalizedData.TimeNormalized.',Relationship,'.',Direction,'.DisplacementVariables.AreaUnderCurve')));
            end
        end
        Data(TrialNum,:) = DataExport;
    else
        [j,k] = size(ExpConditions);
        DataExport = num2cell(nan(1,length(Heading)));
        Data(TrialNum,:) = DataExport;
    end
    clearvars -except Data Conditions Exp Heading HeadingExport 
end

AllData = horzcat(Conditions,Data);
load('ParticipantID');
load('ExpInfo');
Filename = sprintf(char(strcat(ExpName,{' '},ParticipantID,{' '},'Axial Segment Data.xlsx')));
xlswrite(Filename,AllData,'Trial Data','A2');

[a,b,c] = xlsread(char(strcat(ExpName,{' '},ParticipantID,{' '},'Axial Segment Data.xlsx'))); %#ok<*ASGLU>

[row,col] = size(ExpConditions);

Condition1AOrdered = {};Condition1BOrdered = {};Condition1COrdered = {};Condition1DOrdered = {};

Condition1A_2AOrdered = {};Condition1B_2AOrdered = {};Condition1C_2AOrdered = {};Condition1D_2AOrdered = {};
Condition1A_2BOrdered = {};Condition1B_2BOrdered = {};Condition1C_2BOrdered = {};Condition1D_2BOrdered = {};
Condition1A_2COrdered = {};Condition1B_2COrdered = {};Condition1C_2COrdered = {};Condition1D_2COrdered = {};
Condition1A_2DOrdered = {};Condition1B_2DOrdered = {};Condition1C_2DOrdered = {};Condition1D_2DOrdered = {};

Condition1A_2A_3AOrdered = {};Condition1B_2A_3AOrdered = {};Condition1C_2A_3AOrdered = {};Condition1D_2A_3AOrdered = {};
Condition1A_2B_3AOrdered = {};Condition1B_2B_3AOrdered = {};Condition1C_2B_3AOrdered = {};Condition1D_2B_3AOrdered = {};
Condition1A_2C_3AOrdered = {};Condition1B_2C_3AOrdered = {};Condition1C_2C_3AOrdered = {};Condition1D_2C_3AOrdered = {};
Condition1A_2D_3AOrdered = {};Condition1B_2D_3AOrdered = {};Condition1C_2D_3AOrdered = {};Condition1D_2D_3AOrdered = {};
Condition1A_2A_3BOrdered = {};Condition1B_2A_3BOrdered = {};Condition1C_2A_3BOrdered = {};Condition1D_2A_3BOrdered = {};
Condition1A_2B_3BOrdered = {};Condition1B_2B_3BOrdered = {};Condition1C_2B_3BOrdered = {};Condition1D_2B_3BOrdered = {};
Condition1A_2C_3BOrdered = {};Condition1B_2C_3BOrdered = {};Condition1C_2C_3BOrdered = {};Condition1D_2C_3BOrdered = {};
Condition1A_2D_3BOrdered = {};Condition1B_2D_3BOrdered = {};Condition1C_2D_3BOrdered = {};Condition1D_2D_3BOrdered = {};
Condition1A_2A_3COrdered = {};Condition1B_2A_3COrdered = {};Condition1C_2A_3COrdered = {};Condition1D_2A_3COrdered = {};
Condition1A_2B_3COrdered = {};Condition1B_2B_3COrdered = {};Condition1C_2B_3COrdered = {};Condition1D_2B_3COrdered = {};
Condition1A_2C_3COrdered = {};Condition1B_2C_3COrdered = {};Condition1C_2C_3COrdered = {};Condition1D_2C_3COrdered = {};
Condition1A_2D_3COrdered = {};Condition1B_2D_3COrdered = {};Condition1C_2D_3COrdered = {};Condition1D_2D_3COrdered = {};
Condition1A_2A_3DOrdered = {};Condition1B_2A_3DOrdered = {};Condition1C_2A_3DOrdered = {};Condition1D_2A_3DOrdered = {};
Condition1A_2B_3DOrdered = {};Condition1B_2B_3DOrdered = {};Condition1C_2B_3DOrdered = {};Condition1D_2B_3DOrdered = {};
Condition1A_2C_3DOrdered = {};Condition1B_2C_3DOrdered = {};Condition1C_2C_3DOrdered = {};Condition1D_2C_3DOrdered = {};
Condition1A_2D_3DOrdered = {};Condition1B_2D_3DOrdered = {};Condition1C_2D_3DOrdered = {};Condition1D_2D_3DOrdered = {};

if cell2mat(ExpConditions(1,2))>=2
    Condition1A = find(strcmp(ExpConditions(1,3), c(:,2)));
    Condition1B = find(strcmp(ExpConditions(1,4), c(:,2)));
    
    for n = 1:length(Condition1A);
        B = Condition1A(n,1);
        Condition1AOrdered(n,:) = c(B,:);
    end
    
    for n = 1:length(Condition1B);
        B = Condition1B(n,1);
        Condition1BOrdered(n,:) = c(B,:);
    end
end
if cell2mat(ExpConditions(1,2))>=3
    Condition1C = find(strcmp(ExpConditions(1,5), c(:,2)));
    for n = 1:length(Condition1C);
        B = Condition1C(n,1);
        Condition1COrdered(n,:) = c(B,:);
    end
end
if cell2mat(ExpConditions(1,2))==4
    Condition1D = find(strcmp(ExpConditions(1,6), c(:,2)));
    for n = 1:length(Condition1D);
        B = Condition1D(n,1);
        Condition1DOrdered(n,:) = c(B,:);
    end
end

if row>1 && cell2mat(ExpConditions(1,2))>=2&&cell2mat(ExpConditions(2,2))>=2
    Condition1A_2A= find(strcmp(ExpConditions(2,3), Condition1AOrdered(:,3)));
    Condition1A_2B = find(strcmp(ExpConditions(2,4), Condition1AOrdered(:,3)));
    Condition1B_2A= find(strcmp(ExpConditions(2,3), Condition1BOrdered(:,3)));
    Condition1B_2B = find(strcmp(ExpConditions(2,4), Condition1BOrdered(:,3)));
    for n = 1:length(Condition1A_2A);
        B = Condition1A_2A(n,1);
        Condition1A_2AOrdered(n,:) = Condition1AOrdered(B,:);
    end
    for n = 1:length(Condition1A_2B);
        B = Condition1A_2B(n,1);
        Condition1A_2BOrdered(n,:) = Condition1AOrdered(B,:);
    end
    for n = 1:length(Condition1B_2A);
        B = Condition1B_2A(n,1);
        Condition1B_2AOrdered(n,:) = Condition1BOrdered(B,:);
    end
    for n = 1:length(Condition1B_2B);
        B = Condition1B_2B(n,1);
        Condition1B_2BOrdered(n,:) = Condition1BOrdered(B,:);
    end
    if cell2mat(ExpConditions(1,2))>=2&&cell2mat(ExpConditions(2,2))>=3
        Condition1A_2C = find(strcmp(ExpConditions(2,5), Condition1AOrdered(:,3)));
        Condition1B_2C = find(strcmp(ExpConditions(2,5), Condition1BOrdered(:,3)));
        for n = 1:length(Condition1A_2C);
            B = Condition1A_2C(n,1);
            Condition1A_2COrdered(n,:) = Condition1AOrdered(B,:);
        end
        for n = 1:length(Condition1B_2C);
            B = Condition1B_2C(n,1);
            Condition1B_2COrdered(n,:) = Condition1BOrdered(B,:);
        end
    end
    if cell2mat(ExpConditions(1,2))>=2&&cell2mat(ExpConditions(2,2))>=4
        Condition1A_2D = find(strcmp(ExpConditions(2,6), Condition1AOrdered(:,3)));
        Condition1B_2D = find(strcmp(ExpConditions(2,6), Condition1BOrdered(:,3)));
        for n = 1:length(Condition1A_2D);
            B = Condition1A_2D(n,1);
            Condition1A_2DOrdered(n,:) = Condition1AOrdered(B,:);
        end
        
        for n = 1:length(Condition1B_2D);
            B = Condition1B_2D(n,1);
            Condition1B_2DOrdered(n,:) = Condition1BOrdered(B,:);
        end
    end
end

if row>1 && cell2mat(ExpConditions(1,2))>=3&&cell2mat(ExpConditions(2,2))>=2
    Condition1C_2A= find(strcmp(ExpConditions(2,3), Condition1COrdered(:,3)));
    Condition1C_2B = find(strcmp(ExpConditions(2,4), Condition1COrdered(:,3)));
    for n = 1:length(Condition1C_2A);
        B = Condition1C_2A(n,1);
        Condition1C_2AOrdered(n,:) = Condition1COrdered(B,:);
    end
    for n = 1:length(Condition1C_2B);
        B = Condition1C_2B(n,1);
        Condition1C_2BOrdered(n,:) = Condition1COrdered(B,:);
    end
    if cell2mat(ExpConditions(1,2))>=3&&cell2mat(ExpConditions(2,2))>=3
        Condition1C_2C = find(strcmp(ExpConditions(2,6), Condition1COrdered(:,3)));
        for n = 1:length(Condition1C_2C);
            B = Condition1C_2C(n,1);
            Condition1C_2COrdered(n,:) = Condition1COrdered(B,:);
        end
    end
    if cell2mat(ExpConditions(1,2))==3&&cell2mat(ExpConditions(2,2))==4
        Condition1C_2D = find(strcmp(ExpConditions(2,6), Condition1COrdered(:,3)));
        for n = 1:length(Condition1C_2D);
            B = Condition1C_2D(n,1);
            Condition1C_2DOrdered(n,:) = Condition1COrdered(B,:);
        end
    end
end

if row>1 && cell2mat(ExpConditions(1,2))==4&&cell2mat(ExpConditions(2,2))>=2
    Condition1D_2A= find(strcmp(ExpConditions(2,3), Condition1DOrdered(:,3)));
    Condition1D_2B = find(strcmp(ExpConditions(2,4), Condition1DOrdered(:,3)));
    for n = 1:length(Condition1D_2A);
        B = Condition1D_2A(n,1);
        Condition1D_2AOrdered(n,:) = Condition1DOrdered(B,:);
    end
    for n = 1:length(Condition1D_2B);
        B = Condition1D_2B(n,1);
        Condition1D_2BOrdered(n,:) = Condition1DOrdered(B,:);
    end
    if cell2mat(ExpConditions(1,2))==4&&cell2mat(ExpConditions(2,2))>=3
        Condition1D_2C = find(strcmp(ExpConditions(2,5), Condition1DOrdered(:,3)));
        for n = 1:length(Condition1D_2C);
            B = Condition1D_2C(n,1);
            Condition1D_2COrdered(n,:) = Condition1DOrdered(B,:);
        end
    end
    if cell2mat(ExpConditions(1,2))==4&&cell2mat(ExpConditions(2,2))==4
        Condition1D_2D = find(strcmp(ExpConditions(2,6), Condition1DOrdered(:,3)));
        for n = 1:length(Condition1D_2D);
            B = Condition1D_2D(n,1);
            Condition1D_2DOrdered(n,:) = Condition1DOrdered(B,:);
        end
    end
end

if row==1
    AllDataOrdered = vertcat(Condition1AOrdered,Condition1BOrdered,Condition1COrdered,Condition1DOrdered);
elseif row==2
    AllDataOrdered = vertcat(Condition1A_2AOrdered,Condition1B_2AOrdered,Condition1C_2AOrdered,Condition1D_2AOrdered,...
        Condition1A_2BOrdered,Condition1B_2BOrdered,Condition1C_2BOrdered,Condition1D_2BOrdered,...
        Condition1A_2COrdered,Condition1B_2COrdered,Condition1C_2COrdered,Condition1D_2COrdered,...
        Condition1A_2DOrdered,Condition1B_2DOrdered,Condition1C_2DOrdered,Condition1D_2DOrdered);
elseif row==3
    AllDataOrdered = vertcat(Condition1A_2A_3AOrdered,Condition1B_2A_3AOrdered,Condition1C_2A_3AOrdered,Condition1D_2A_3AOrdered,...
        Condition1A_2B_3AOrdered,Condition1B_2B_3AOrdered,Condition1C_2B_3AOrdered,Condition1D_2B_3AOrdered,...
        Condition1A_2C_3AOrdered,Condition1B_2C_3AOrdered,Condition1C_2C_3AOrdered,Condition1D_2C_3AOrdered,...
        Condition1A_2D_3AOrdered,Condition1B_2D_3AOrdered,Condition1C_2D_3AOrdered,Condition1D_2D_3AOrdered,...
        Condition1A_2A_3BOrdered,Condition1B_2A_3BOrdered,Condition1C_2A_3BOrdered,Condition1D_2A_3BOrdered,...
        Condition1A_2B_3BOrdered,Condition1B_2B_3BOrdered,Condition1C_2B_3BOrdered,Condition1D_2B_3BOrdered,...
        Condition1A_2C_3BOrdered,Condition1B_2C_3BOrdered,Condition1C_2C_3BOrdered,Condition1D_2C_3BOrdered,...
        Condition1A_2D_3BOrdered,Condition1B_2D_3BOrdered,Condition1C_2D_3BOrdered,Condition1D_2D_3BOrdered,...
        Condition1A_2A_3COrdered,Condition1B_2A_3COrdered,Condition1C_2A_3COrdered,Condition1D_2A_3COrdered,...
        Condition1A_2B_3COrdered,Condition1B_2B_3COrdered,Condition1C_2B_3COrdered,Condition1D_2B_3COrdered,...
        Condition1A_2C_3COrdered,Condition1B_2C_3COrdered,Condition1C_2C_3COrdered,Condition1D_2C_3COrdered,...
        Condition1A_2D_3COrdered,Condition1B_2D_3COrdered,Condition1C_2D_3COrdered,Condition1D_2D_3COrdered,...
        Condition1A_2A_3DOrdered,Condition1B_2A_3DOrdered,Condition1C_2A_3DOrdered,Condition1D_2A_3DOrdered,...
        Condition1A_2B_3DOrdered,Condition1B_2B_3DOrdered,Condition1C_2B_3DOrdered,Condition1D_2B_3DOrdered,...
        Condition1A_2C_3DOrdered,Condition1B_2C_3DOrdered,Condition1C_2C_3DOrdered,Condition1D_2C_3DOrdered,...
        Condition1A_2D_3DOrdered,Condition1B_2D_3DOrdered,Condition1C_2D_3DOrdered,Condition1D_2D_3DOrdered);
end

Filename = sprintf(char(strcat(ExpName,{' '},ParticipantID,{' '},'Axial Segment Data.xlsx')));
xlswrite(Filename,AllDataOrdered,'Trial Data','A2');

NumConditions = prod(cell2mat(ExpConditions(:,2)));
TrialsPerCondition = NumTrials/NumConditions;
[row,col] = size(ExpConditions);
for j = 1:NumConditions
    MeanHeadings((j*3)-2,1) =  {ParticipantID};
    MeanHeadings((j*3)-2,row+2) = {'Mean'};
    MeanHeadings((j*3)-1,row+2) = {'SD'};
end

[a,b,c] = xlsread(char(strcat(ExpName,{' '},ParticipantID,{' '},'Axial Segment Data.xlsx')));
b = b(2:end,:);

for j = 1:NumConditions
    k = (TrialsPerCondition*j)-(TrialsPerCondition-1);
    MeanHeadings((j*3)-2,2:row+1) = b(k,2:row+1);
end

xlswrite(Filename,MeanHeadings,'Mean Data','A2');

b = (length(a)-(length(HeadingExport)-length(Exp)))+1;
c = length(Exp)+1;
a = a(:,b:end);

TrialsPerCondition = NumTrials/NumConditions;

MeanCondition = [];
SDCondition = [];

for k = 1:NumConditions
    j = (TrialsPerCondition*k)-(TrialsPerCondition-1);
    i = TrialsPerCondition*k;
    u = genvarname('MeanCondition', who);
    v = genvarname('SDCondition', who);
    evalc([u ' = nanmean(a(j:i,:))']);
    evalc([v ' = nanstd(a(j:i,:))']);
end

for k = NumConditions+1:16;
    u = genvarname('MeanCondition', who);
    v = genvarname('SDCondition', who);
    evalc([u ' = nan(1,length(MeanCondition1))']);
    evalc([v ' = nan(1,length(MeanCondition1))']);
end

AllMeansSDs = [];
Blank = nan(1,length(MeanCondition1));

AllMeansSDs = vertcat(AllMeansSDs,MeanCondition1,SDCondition1,Blank,MeanCondition2,SDCondition2,Blank,...
    MeanCondition3,SDCondition3,Blank,MeanCondition4,SDCondition4,Blank,MeanCondition5,SDCondition5,Blank,...
    MeanCondition6,SDCondition6,Blank,MeanCondition7,SDCondition7,Blank,MeanCondition8,SDCondition8,Blank,...
    MeanCondition9,SDCondition9,Blank,MeanCondition10,SDCondition10,Blank,MeanCondition11,SDCondition11,Blank,...
    MeanCondition12,SDCondition12,Blank,MeanCondition13,SDCondition13,Blank,MeanCondition14,SDCondition14,Blank,...
    MeanCondition15,SDCondition15,Blank,MeanCondition16,SDCondition16,Blank);

Filename = sprintf(char(strcat(ExpName,{' '},ParticipantID,{' '},'Axial Segment Data.xlsx')));
if row==1
    Cell = 'D2';
elseif row==2
    Cell = 'E2';
elseif row==3
    Cell = 'F2';
end

xlswrite(Filename,AllMeansSDs,'Mean Data',Cell);

[a,b,c] = xlsread(char(strcat(ExpName,{' '},ParticipantID,{' '},'Axial Segment Data.xlsx')));
b = b(2:end,:);
c = c(2:end,(length(Exp)+1):length(c));
clearvars Conditions
Trials = [];

for j = 1:NumConditions
    k = (TrialsPerCondition*j)-(TrialsPerCondition-1);
    Conditions(j,:) = b(k,2:row+1);
    u = genvarname('Trials', who);
    evalc([u ' = c(k:k+(TrialsPerCondition-1),:)']);
end

for k = NumConditions+1:16;
    w = genvarname('Trials', who);
    evalc([w ' = nan(1,length(MeanCondition1))']);
end

Condition = [];

for k = 1:NumConditions;
    u = genvarname('Condition', who);
    evalc([u ' = Conditions(k,:)']);
    evalc([v ' = []']);
end

clearvars -except AllDataOrdered Condition1 Condition2 Condition3 Condition4 Condition5 Condition6...
    Condition7 Condition8 Condition9 Condition10 Condition11 Condition12 Condition13...
    Condition14 Condition15 Condition16 MeanCondition1 SDCondition1 MeanCondition2 SDCondition2...
    MeanCondition3 SDCondition3 MeanCondition4 SDCondition4 MeanCondition5 SDCondition5 ...
    MeanCondition6 SDCondition6 MeanCondition7 SDCondition7 MeanCondition8 SDCondition8 ...
    MeanCondition9 SDCondition9 MeanCondition10 SDCondition10 MeanCondition11 SDCondition11 ...
    MeanCondition12 SDCondition12 MeanCondition13 SDCondition13 MeanCondition14 SDCondition14 ...
    MeanCondition15 SDCondition15 MeanCondition16 SDCondition16 ParticipantID ExpName MainFolder...
    Trials1 Trials2 Trials3 Trials4 Trials5 Trials6 Trials7 Trials8 Trials9 Trials10...
    Trials11 Trials12 Trials13 Trials14 Trials15 Trials16

save(char(strcat(ExpName,{' '},ParticipantID,{' '},'Axial Segment Data.mat')));
movefile(char(strcat(ExpName,{' '},ParticipantID,{' '},'Axial Segment Data.mat')),MainFolder);

beep
h = msgbox('Export Axial Segment Data Script Complete');
clear
clc