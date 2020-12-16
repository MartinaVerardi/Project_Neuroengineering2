for i = 1:8
    figure(i)
    subplot(221),[~,~,hLine2] = plotyy(linspace(0,1,length(NormativeProfile_Scale(2,:))),...
        NormativeProfile_Scale(i,:),linspace(0,1,length(NormativeProfile_Scale(1,:))),Activation_sano(i,:));
    hLine2.Color = 'g';
    title('Attivazione Soleo Normative')
    xlim([0 1])
    ylim([0 1.2])
    
    subplot(222),[~,~,hLine2] = plotyy(linspace(0,1,length(NormativeProfile_Scale(2,:))),...
        NormativeProfile_Scale(i,:),linspace(0,1,length(NormativeProfile_Scale(1,:))),Disactivation_sano(i,:));
    hLine2.Color = 'r';
    title('Disattivazione Soleo Normative')
    xlim([0 1])
    ylim([0 1.2])
    
    subplot(223),[~,~,hLine2] = plotyy(linspace(0,1,length(NormativeProfile_Scale(2,:))),...
        TKEO_mean(i,:),linspace(0,1,length(NormativeProfile_Scale(1,:))),Activation(i,:));
    hLine2.Color = 'g';
    title('Attivazione Soleo Paziente')
    xlabel('Percentage Gait Cycle [%]')
    xlim([0 1])
    ylim([0 1.2])
    
    subplot(224),[~,~,hLine2] = plotyy(linspace(0,1,length(NormativeProfile_Scale(2,:))),...
        TKEO_mean(i,:),linspace(0,1,length(NormativeProfile_Scale(1,:))),Disactivation(i,:));
    hLine2.Color = 'r';
    title('Disttivazione Soleo Paziente')
    xlabel('Percentage Gait Cycle [%]')
    xlim([0 1])
    ylim([0 1.2])
end 