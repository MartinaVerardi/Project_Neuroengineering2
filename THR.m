 % Thresholding of EMG signal with a moving window with adaptive threshold
 % to identify ON and OFF phase of the gait cycle
 

function [SignalLevel,NoiseLevel,Threshold,Activation]= THR(EMG_o,wl)

% Subtraction of the mean to obtain a 0 mean signal
EMG = EMG_o - mean(EMG_o); 
% Normalization
EMG = EMG / max (EMG);    

% Inizialization of threshold, activation and noise_level to 0
Threshold = zeros(1,length(EMG));
Activation = zeros(1,length(EMG)); 
SignalLevel = [];
NoiseLevel = ones(1,length(EMG)) ;

NoiseLevel = NoiseLevel.*(mean(EMG)/3);

% Activation profile identification with mobile window and adaptive threshold
 for i = 1:length(EMG)- wl
    if  EMG(i:i+wl) > Threshold(i)
        Activation(i)=1;       
        SignalLevel(i)= 0.2 * mean(EMG(i:i+wl));
        
        if i==1
            NoiseLevel(i)=0;
        else NoiseLevel(i) = NoiseLevel(i-1);
        
        end
     
    else Activation(i)=0;
        if ~isempty(SignalLevel)
        SignalLevel(i)= SignalLevel(i-1);
        else SignalLevel(i)=0;
        end
        if mean (EMG(i:i+wl)) > Threshold(i)
                    if isempty(NoiseLevel)
                        NoiseLevel(i)=0;
                    else
           NoiseLevel (i)= mean(NoiseLevel); %% mean (noiselevelhistory)
                    end
                    
        else NoiseLevel (i)= mean (EMG(i:i+wl));
        end 
    end
    
    Threshold(i) = NoiseLevel(i) +  0.5 * (abs(SignalLevel(i)-NoiseLevel(i)));
        
 end
 
Threshold = Threshold + mean(EMG_o);
SignalLevel = SignalLevel + mean(EMG_o);
NoiseLevel = NoiseLevel + mean(EMG_o);

end