clear all
close all
clc

%%
load ('StatTable.mat');

mean_EXO_0 = mean(Table4Stat.iEMG_mean(Table4Stat.EXO == 1 & Table4Stat.Trial == 0 ,:));
std_EXO_0  = std(Table4Stat.iEMG_mean(Table4Stat.EXO == 1 & Table4Stat.Trial == 0 ,:));

mean_EXO_1 = mean(Table4Stat.iEMG_mean(Table4Stat.EXO == 1 & Table4Stat.Trial == 1 ,:));
std_EXO_1  = std(Table4Stat.iEMG_mean(Table4Stat.EXO == 1 & Table4Stat.Trial == 1 ,:));

mean_noEXO_0 = mean(Table4Stat.iEMG_mean(Table4Stat.EXO == 0 & Table4Stat.Trial == 0 ,:));
std_noEXO_0  = std(Table4Stat.iEMG_mean(Table4Stat.EXO == 0 & Table4Stat.Trial == 0 ,:));

mean_noEXO_1 = mean(Table4Stat.iEMG_mean(Table4Stat.EXO == 0 & Table4Stat.Trial == 1 ,:));
std_noEXO_1  = std(Table4Stat.iEMG_mean(Table4Stat.EXO == 0 & Table4Stat.Trial == 1 ,:));

gruppo = {'EXO','NonEXO'};

figure()
% plot del gruppo EXO
errorbar([0.9 4.9],[mean_EXO_0,mean_EXO_1],[std_EXO_0,std_EXO_1],'-^','LineWidth',1);
hold on
% plot del gruppo nonEXO
errorbar([1.1 5.1],[mean_noEXO_0,mean_noEXO_1],[std_noEXO_0,std_noEXO_1],'-*','LineWidth',1);
xticks([1 5]);
xticklabels({'Trial 0','Trial 1'});
legend('group EXO','group noEXO');
title('iEMG mean')
 
%%
meanBDSI_EXO_0 = mean(Table4Stat.BDSI_mean(Table4Stat.EXO == 1 & Table4Stat.Trial == 0 ,:));
stdBDSI_EXO_0  = std(Table4Stat.BDSI_mean(Table4Stat.EXO == 1 & Table4Stat.Trial == 0 ,:));

meanBDSI_EXO_1 = mean(Table4Stat.BDSI_mean(Table4Stat.EXO == 1 & Table4Stat.Trial == 1 ,:));
stdBDSI_EXO_1  = std(Table4Stat.BDSI_mean(Table4Stat.EXO == 1 & Table4Stat.Trial == 1 ,:));

meanBDSI_noEXO_0 = mean(Table4Stat.BDSI_mean(Table4Stat.EXO == 0 & Table4Stat.Trial == 0 ,:));
stdBDSI_noEXO_0  = std(Table4Stat.BDSI_mean(Table4Stat.EXO == 0 & Table4Stat.Trial == 0 ,:));

meanBDSI_noEXO_1 = mean(Table4Stat.BDSI_mean(Table4Stat.EXO == 0 & Table4Stat.Trial == 1 ,:));
stdBDSI_noEXO_1  = std(Table4Stat.BDSI_mean(Table4Stat.EXO == 0 & Table4Stat.Trial == 1 ,:));

gruppo = {'EXO','NonEXO'};

figure()
% plot del gruppo EXO
errorbar([0.9 4.9],[meanBDSI_EXO_0,meanBDSI_EXO_1],[stdBDSI_EXO_0,stdBDSI_EXO_1],'-^','LineWidth',1);
hold on
% plot del gruppo nonEXO
errorbar([1.1 5.1],[meanBDSI_noEXO_0,meanBDSI_noEXO_1],[stdBDSI_noEXO_0,stdBDSI_noEXO_1],'-*','LineWidth',1);
xticks([1 5]);
xticklabels({'Trial 0','Trial 1'});
legend('group EXO','group noEXO');
title('BDSI mean')

