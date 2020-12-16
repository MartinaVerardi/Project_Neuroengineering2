clear all
close all
clc

%% Load data

load ('StatTable.mat');

Trial = Table4Stat.Trial;
EXO = Table4Stat.EXO;

Trial_cell = cell(size(Trial));
Trial_cell(Trial == 0)={'t0'};
Trial_cell(Trial == 1)={'t1'};
Trial_cat = categorical(Trial_cell);


EXO_cell = cell(size(EXO));
EXO_cell(EXO == 0)={'NonEXO'};
EXO_cell(EXO == 1)={'EXO'};
EXO_cat = categorical(EXO_cell);

%% BoxPlot Paretici/nonPAretici EXO/NonEXO by t0/t1 for iEMG

figure();
%boxchart(Trial_cat,Table4Stat.iEMG_meanPar,'GroupByColor',EXO_cat)
% title('iEMG mean by EXO/nonEXO and t1/t0')
% xlabel('t1 and t0')
% ylabel('iEMG mean')
% legend;

%boxchart(Trial_cat,Table4Stat.iEMG_meanNonPar,'GroupByColor',EXO_cat)
% title('iEMG mean by EXO/nonEXO and t1/t0')
% xlabel('t1 and t0')
% ylabel('iEMG mean')
% legend;

subplot(2,2,1), boxchart(Trial_cat,Table4Stat.iEMG_meanPar),title('iEMG Paretic by t0-t1'),xlabel('t0 and t1'),ylabel('iEMG mean')
subplot(2,2,2), boxchart(Trial_cat,Table4Stat.iEMG_meanNonPar),title('iEMG Non Paretic by t0-t1'),xlabel('t0 and t1'),ylabel('iEMG mean')
subplot(2,2,3), boxchart(EXO_cat,Table4Stat.iEMG_meanPar),title('iEMG Paretic by EXO-NonEXO'),xlabel('EXO and NonEXO'),ylabel('iEMG mean')
subplot(2,2,4), boxchart(EXO_cat,Table4Stat.iEMG_meanNonPar),title('iEMG Non Paretic by EXO-NonEXO'),xlabel('EXO and NonEXO'),ylabel('iEMG mean')

%ugly
figure;
subplot(2,1,1),boxplot(Table4Stat.iEMG_meanPar,{Trial_cat,EXO_cat}),title('Paretici')
subplot(2,1,2),boxplot(Table4Stat.iEMG_meanNonPar,{Trial_cat,EXO_cat}),title('Non Paretici')


%% BoxPlot Paretici/non paretici EXO/NonEXO by t0/t1 for BDSI

figure();
%boxchart(Trial_cat,Table4Stat.BDSI_meanPar,'GroupByColor',EXO_cat)
% title('BDSI mean by EXO/nonEXO and t1/t0')
% xlabel('t1 and t0')
% ylabel('iEMG mean')
% legend;

%boxchart(Trial_cat,Table4Stat.BDSI_meanNonPar,'GroupByColor',EXO_cat)
% title('BDSI mean by EXO/nonEXO and t1/t0')
% xlabel('t1 and t0')
% ylabel('iEMG mean')
% legend;

subplot(2,2,1), boxchart(Trial_cat,Table4Stat.BDSI_meanPar),title('BDSI Paretic by t0-t1'),xlabel('t0 and t1'),ylabel('BDSI mean')
subplot(2,2,2), boxchart(Trial_cat,Table4Stat.BDSI_meanNonPar),title('BDSI Non Paretic by t0-t1'),xlabel('t0 and t1'),ylabel('BDSI mean')
subplot(2,2,3), boxchart(EXO_cat,Table4Stat.BDSI_meanPar),title('BDSI Paretic by EXO-NonEXO'),xlabel('EXO and NonEXO'),ylabel('BDSI mean')
subplot(2,2,4), boxchart(EXO_cat,Table4Stat.BDSI_meanNonPar),title('BDSI Non Paretic by EXO-NonEXO'),xlabel('EXO and NonEXO'),ylabel('BDSI mean')


%ugly
figure;
subplot(2,1,1),boxplot(Table4Stat.BDSI_meanPar,{Trial_cat,EXO_cat}),title('Paretici')
subplot(2,1,2),boxplot(Table4Stat.BDSI_meanNonPar,{Trial_cat,EXO_cat}),title('Non Paretici')
