clear all
close all
clc

mDir = pwd;

cd '..'
WorkDir = pwd;
%% LOAD DATA

IDchoices = {'','p01','p02','p03','p04','p05','p06','p07','p08','p09',...
        'p10','p11','p12','p14','p15','p16','p18','p19','p20',...
        'p21','p22','p23','p24','p25','p26','p27','p28','p29','p30'};
    
Tchoices = {'','t0','t1'};

[id] = listdlg('PromptString','Select a Patient:','SelectionMode','single',...
        'ListString',IDchoices);
ID = IDchoices{id};
    
[trial] = listdlg('PromptString','Select a Trial:','SelectionMode','single',...
        'ListString',Tchoices);
Trial = Tchoices{trial};   

% adding a flag that refers to the group of treatment (Ekso->1, Control->0)
if (strcmp(ID,'p01') || strcmp(ID,'p02')|| strcmp(ID,'p03')|| strcmp(ID,'p05')...
        || strcmp(ID,'p09')|| strcmp(ID,'p10')|| strcmp(ID,'p14')|| strcmp(ID,'p18')...
        || strcmp(ID,'p20')|| strcmp(ID,'p22')|| strcmp(ID,'p23')|| strcmp(ID,'p24')...
        || strcmp(ID,'p25')|| strcmp(ID,'p26'))
    EXO_Flag = 1;
else
    EXO_Flag = 0;
end

cd('Data')    
load(strcat(ID,'_',Trial,'.mat'));
load('NormativeProfile_Mean.mat');
load('NormativeProfile_Std.mat');
clear id trial

cd(mDir)
%% EMG DATA

% EMG data are designed as follows:
% - 8 rows: the first 4 rows refer to Non Paretic Limb and the last 4 to the Paretic Limb.
% - The sequence of muscles for both Non Paretic and Paretic Limb is: 
% Tibialis Anterior (TA), Soleus (S), Rectus Femoris (RF), Semitendinosus (ST).

muscles = {'TA nParetic','S nParetic','RF nParetic','ST nParetic',...
    'TA Paretic','S Paretic','RF Paretic','ST Paretic'};

%% PRE PROCESSING

% 1. High pass filter: butterworth 6 order at 20 Hz [from Gandolla et al.]
% 2. Rectification
% 3. Moving Average: 100 ms window width [from Nolan et al.]

fc = 1000;
NyqFreq = fc/2;

Highpass = 20;
Wo = Highpass/NyqFreq;
[D,C] = butter (6,Wo,'high');

% % Lowpass filter 4 Hz
% Lowpass = 6;
% Wn = Lowpass/NyqFreq;
% [B,A] = butter (6,Wn,'low');

window = 100; 

for i = 1:8
    EMG_high(i,:) = filtfilt(D,C,no_filter(i,:)); % high pass filter

    EMG_high_abs(i,:) = abs(EMG_high(i,:)); % rectification
    
    %     EMG_filtered(i,:) = filtfilt(B,A,EMG_high_abs(i,:));
    
    EMG_filtered(i,:) = movmean(EMG_high_abs(i,:),window); % moving average

end

% plotting EMG after rectification and EMG envelop of each muscle, Paretic and NonParetic 

Time_EMG = linspace(0,size(no_filter,2)/fc,size(no_filter,2));
figure()
for i = 1:8
    subplot(4,2,i), plot(Time_EMG, EMG_high_abs(i,:))
    hold on
    plot(Time_EMG, EMG_filtered(i,:),'r')
    title(muscles{i})
    
    if mod(i,2)
        ylabel('Voltage')
    end
    if (i == 7) | (i ==8)
        xlabel('Time [s]')
    end 
    xlim([0 size(no_filter,2)/fc])
end
legend('EMG Rectified','EMG Envelop')

%% SEGMENTATION

% Soleus EMG signal used as input for the segmentation is further preprocessed 
% to limit the bandwidth to frequencies where step cadence is located 
% -> "step" preprocessing

% highpass filter 2 Hz
Highpass_soleus = 2;
Wh_sol = Highpass_soleus/NyqFreq;
[B_h,A_h] = butter (6, Wh_sol,'high');

Soleus_EMG_high = filtfilt(B_h,A_h,no_filter(2,:));

% rectification
Soleus_EMG_rect = abs(Soleus_EMG_high);

% Lowpass filter 1 Hz 
Lowpass_soleus = 1;
Wl_sol = Lowpass_soleus/NyqFreq;
[B_l,A_l] = butter (6, Wl_sol,'low');

Soleus_EMG = filtfilt(B_l,A_l,Soleus_EMG_rect); % Soleus signal used as input of the FindStep function 

% Plotting Soleus EMG after first preprocessing
figure()
subplot(211), plot(Time_EMG, EMG_high_abs(2,:))
hold on
plot(Time_EMG, EMG_filtered(2,:),'r')
title('Soleus EMG: first preprocessing')


% Plotting Soleus EMG after "step" preprocessing
subplot(212), plot(Time_EMG, EMG_high_abs(2,:)) 
hold on
plot(Time_EMG, Soleus_EMG,'r')
title('Soleus EMG: step preprocessing')

% FindStep Function
[StepLengthMean,StepStart,StepsNumber]=FindStep(Soleus_EMG, 20); % w1=20  [from Gandolla et al.]

StepsNumber = StepsNumber - 1;
StepEnd = StepStart(1,2:(end-1)) -1;
StepStart = StepStart(1,1:(end-1));
StepEnd = [StepEnd, length(Soleus_EMG)];

% Segmentation + Scaling for each muscle 
% On the columns I have the number of steps

% TA nonParetic
for s = 1 : StepsNumber
    
    Yi = ScaleTime(EMG_filtered(1,:),StepStart(s),StepEnd(s),StepLengthMean);
    EMG_scaled_TA_nP(:,s) = Yi';
    
end

% S nonParetic
for s = 1 : StepsNumber
    
    Yi = ScaleTime(EMG_filtered(2,:),StepStart(s),StepEnd(s),StepLengthMean);
    EMG_scaled_S_nP(:,s) = Yi';
    
end

% RF nonParetic
for s = 1 : StepsNumber
    
    Yi = ScaleTime(EMG_filtered(3,:),StepStart(s),StepEnd(s),StepLengthMean);
    EMG_scaled_RF_nP(:,s) = Yi';
    
end

% ST nonParetic
for s = 1 : StepsNumber
    
    Yi = ScaleTime(EMG_filtered(4,:),StepStart(s),StepEnd(s),StepLengthMean);
    EMG_scaled_ST_nP(:,s) = Yi';
    
end

% TA Paretic
for s = 1 : StepsNumber
    
    Yi = ScaleTime(EMG_filtered(5,:),StepStart(s),StepEnd(s),StepLengthMean);
    EMG_scaled_TA_P(:,s) = Yi';
    
end

% S Paretic
for s = 1 : StepsNumber
    
    Yi = ScaleTime(EMG_filtered(6,:),StepStart(s),StepEnd(s),StepLengthMean);
    EMG_scaled_S_P(:,s) = Yi';
    
end

% RF Paretic
for s = 1 : StepsNumber
    
    Yi = ScaleTime(EMG_filtered(7,:),StepStart(s),StepEnd(s),StepLengthMean);
    EMG_scaled_RF_P(:,s) = Yi';
    
end

% ST Paretic
for s = 1 : StepsNumber
    
    Yi = ScaleTime(EMG_filtered(8,:),StepStart(s),StepEnd(s),StepLengthMean);
    EMG_scaled_ST_P(:,s) = Yi';
    
end
Length_scale = size(EMG_scaled_ST_P,1);

%% NORMALIZATION (rms)

rms_EMG = zeros(8,1);

for m = 1:8
    
    rms_EMG(m,1) = rms(EMG_filtered(m,StepStart(1):end));
    
end

EMG_norm_TA_nP = EMG_scaled_TA_nP / rms_EMG(1,1);
EMG_norm_S_nP = EMG_scaled_S_nP / rms_EMG(2,1);
EMG_norm_RF_nP = EMG_scaled_RF_nP / rms_EMG(3,1);
EMG_norm_ST_nP = EMG_scaled_ST_nP / rms_EMG(4,1);

EMG_norm_TA_P = EMG_scaled_TA_P / rms_EMG(5,1);
EMG_norm_S_P = EMG_scaled_S_P / rms_EMG(6,1);
EMG_norm_RF_P = EMG_scaled_RF_P / rms_EMG(7,1);
EMG_norm_ST_P = EMG_scaled_ST_P / rms_EMG(8,1);

EMG_norm = struct('TA_nP',EMG_norm_TA_nP,'S_nP',EMG_norm_S_nP,'RF_nP',EMG_norm_RF_nP,...
    'ST_nP',EMG_norm_ST_nP,'TA_P', EMG_scaled_TA_P,'S_P', EMG_scaled_S_P,...
    'RF_P', EMG_scaled_RF_P,'ST_P', EMG_scaled_ST_P);

fields = {'TA_nP','S_nP','RF_nP','ST_nP','TA_P','S_P','RF_P','ST_P'};

%% iEMG INDEX 

% creating a iEMG matrix: each row represents a different muscle and on
% columns there are the different steps

iEMG = zeros(8,StepsNumber);

iEMG(1,:) = trapz(2*size(EMG_norm_TA_nP,1),EMG_norm_TA_nP);

for m = 1:8
    
    field = fields(m);
    dato = getfield(EMG_norm,field{1});
    iEMG(m,:) = trapz(dato);
    
end 

iEMG_mean = mean(iEMG,2); % mean of iEMG of all steps

%% BDSI INDEX

% Before to compute the BDSI index, the mean of EMG data of all steps is needed

TKEO_sig = zeros(8,length(EMG_high));
window_tkeo = 70; % window width of the moving average  

for i = 1:8
    TKEO_sig(i,:) = TKEO_fun(EMG_high(i,:),window_tkeo);
end

TKEO_seg = struct('TKEO_seg_TA_nP',[],'TKEO_seg_S_nP',[],'TKEO_seg_RF_nP',[],'TKEO_seg_ST_nP',[],...
    'TKEO_seg_TA_P',[],'TKEO_seg_S_P',[],'TKEO_seg_RF_P',[],'TKEO_seg_ST_P',[]);

TKEO_fields = {'TKEO_seg_TA_nP','TKEO_seg_S_nP','TKEO_seg_RF_nP','TKEO_seg_ST_nP',...
    'TKEO_seg_TA_P','TKEO_seg_S_P','TKEO_seg_RF_P','TKEO_seg_ST_P'};

% Scaling on time also the normative profile EMG, necessary for the timing_on/timing_off
NormativeProfile_Scale = zeros(8,Length_scale); 

for m = 1:8
    
    field = TKEO_fields(m);
    
    for s = 1 : StepsNumber
    
        Yi = ScaleTime(TKEO_sig(m,:),StepStart(s),StepEnd(s),StepLengthMean);
        dato(:,s) = Yi';
        
    end
    dato = dato/max(max(dato));
    TKEO_seg = setfield(TKEO_seg, field{1},dato);
    NormativeProfile_Scale(m,:) = ScaleTime(NormativeProfile_Mean(m,:),1,size(NormativeProfile_Mean,2),StepLengthMean);
end 

% computing the MEAN and STD of TKEO_seg of all steps per muscle 
TKEO_mean = zeros(8:length(StepLengthMean));
TKEO_std = zeros(8:length(StepLengthMean));
for m = 1:8
    field = TKEO_fields(m);
    dato = getfield(TKEO_seg,field{1});
    TKEO_mean(m,:) = mean(dato,2)';
    TKEO_std(m,:) = std(dato,0,2)';
end 

TKEO_mean = TKEO_mean ./ max(TKEO_mean,[],2); % Normalization of TEKO_mean before applying the Thresholding function
[Activation , Deactivation] = Thresholding(TKEO_mean,0.1);
[Activation_NormativeProfile , Deactivation_NormativeProfile] = Thresholding(NormativeProfile_Scale,0.1);

% Activation/Deactivation Plotting

figure()
subplot(221),[~,~,hLine2] = plotyy(linspace(0,1,length(NormativeProfile_Scale(2,:))),...
    NormativeProfile_Scale(2,:),linspace(0,1,length(NormativeProfile_Scale(1,:))),Activation_NormativeProfile(2,:));
hLine2.Color = 'g';
title('Normative Profile Solues Activation')
xlim([0 1])
ylim([0 1.2])

subplot(222),[~,~,hLine2] = plotyy(linspace(0,1,length(NormativeProfile_Scale(2,:))),...
    NormativeProfile_Scale(2,:),linspace(0,1,length(NormativeProfile_Scale(1,:))),Deactivation_NormativeProfile(2,:));
hLine2.Color = 'r';
title('Normative Profile Soleus Deactivation')
xlim([0 1])
ylim([0 1.2])

subplot(223),[~,~,hLine2] = plotyy(linspace(0,1,length(NormativeProfile_Scale(2,:))),...
     TKEO_mean(2,:),linspace(0,1,length(NormativeProfile_Scale(1,:))),Activation(2,:));
hLine2.Color = 'g';
title('Patient Soleus Activation')
xlabel('Percentage Gait Cycle [%]')
xlim([0 1])
ylim([0 1.2])

subplot(224),[~,~,hLine2] = plotyy(linspace(0,1,length(NormativeProfile_Scale(2,:))),...
    TKEO_mean(2,:),linspace(0,1,length(NormativeProfile_Scale(1,:))),Deactivation(2,:));
hLine2.Color = 'r';
title('Patient Soleus Deactivation')
xlabel('Percentage Gait Cycle [%]')
xlim([0 1])
ylim([0 1.2])

% ON_timing and OFF_timing matrix
ON_timing = Activation & Activation_NormativeProfile;
OFF_timing = Deactivation & Deactivation_NormativeProfile;

BDSI = (sum(ON_timing,2) + sum(OFF_timing,2))*100 /(Length_scale);

%% SAVE DATA IN A DATABASE

%cd ..
%cd('Outputs') 

%name =  strcat('Struct_',ID,'_',Trial);
%Database = struct('iEMG',iEMG_mean,'BDSI',BDSI,'EMG_seg',EMG_norm,'TKEO_mean',TKEO_mean,...
%   'TKEO_std',TKEO_std,'EXO_Flag',EXO_Flag,'StepNumber',StepsNumber);

%save(name,'Database')

%cd(mDir)