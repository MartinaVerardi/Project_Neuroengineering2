clear all
close all
clc
%%
load('StatTable.mat')
%% iEMG Paretico

% test dati non accoppiati
noEXO_0 = Table4Stat.iEMG_meanPar(Table4Stat.EXO == 0 & Table4Stat.Trial == 0 ,:);
EXO_0 = Table4Stat.iEMG_meanPar(Table4Stat.EXO == 1 & Table4Stat.Trial == 0 ,:);

[p0,h0,stats] = ranksum(noEXO_0,EXO_0)

% differenze al tempo t1
noEXO_1 = Table4Stat.iEMG_meanPar(Table4Stat.EXO == 0 & Table4Stat.Trial == 1 ,:);
EXO_1 = Table4Stat.iEMG_meanPar(Table4Stat.EXO == 1 & Table4Stat.Trial == 1 ,:);

[p1,h1,stats] = ranksum(noEXO_1,EXO_1)

% test dei dati accoppiati
noEXO_0 = Table4Stat.iEMG_meanPar(Table4Stat.EXO == 0 & Table4Stat.Trial == 0 ,:);
noEXO_1 = Table4Stat.iEMG_meanPar(Table4Stat.EXO == 0 & Table4Stat.Trial == 1 ,:);

p_noEXO = signrank(noEXO_0,noEXO_1)

% gruppo EXO

EXO_0 = Table4Stat.iEMG_meanPar(Table4Stat.EXO == 1 & Table4Stat.Trial == 0 ,:);
EXO_1 = Table4Stat.iEMG_meanPar(Table4Stat.EXO == 1 & Table4Stat.Trial == 1 ,:);

p_EXO = signrank(EXO_0,EXO_1)

%% BDSI Paretico
% test dati non accoppiati
noEXO_0 = Table4Stat.BDSI_meanPar(Table4Stat.EXO == 0 & Table4Stat.Trial == 0 ,:);
EXO_0 = Table4Stat.BDSI_meanPar(Table4Stat.EXO == 1 & Table4Stat.Trial == 0 ,:);

p0 = ranksum(noEXO_0,EXO_0)

% differenze al tempo t1
noEXO_1 = Table4Stat.BDSI_meanPar(Table4Stat.EXO == 0 & Table4Stat.Trial == 1 ,:);
EXO_1 = Table4Stat.BDSI_meanPar(Table4Stat.EXO == 1 & Table4Stat.Trial == 1 ,:);

p1 = ranksum(noEXO_1,EXO_1)

% test dei dati accoppiati
noEXO_0 = Table4Stat.BDSI_meanPar(Table4Stat.EXO == 0 & Table4Stat.Trial == 0 ,:);
noEXO_1 = Table4Stat.BDSI_meanPar(Table4Stat.EXO == 0 & Table4Stat.Trial == 1 ,:);

p_noEXO = signrank(noEXO_0,noEXO_1)

% gruppo EXO

EXO_0 = Table4Stat.BDSI_meanPar(Table4Stat.EXO == 1 & Table4Stat.Trial == 0 ,:);
EXO_1 = Table4Stat.BDSI_meanPar(Table4Stat.EXO == 1 & Table4Stat.Trial == 1 ,:);

p_EXO = signrank(EXO_0,EXO_1)

%% iEMG Non Paretico
% test dati non accoppiati

noEXO_0 = Table4Stat.iEMG_meanNonPar(Table4Stat.EXO == 0 & Table4Stat.Trial == 0 ,:);
EXO_0 = Table4Stat.iEMG_meanNonPar(Table4Stat.EXO == 1 & Table4Stat.Trial == 0 ,:);

p0 = ranksum(noEXO_0,EXO_0)

% differenze al tempo t1
noEXO_1 = Table4Stat.iEMG_meanNonPar(Table4Stat.EXO == 0 & Table4Stat.Trial == 1 ,:);
EXO_1 = Table4Stat.iEMG_meanNonPar(Table4Stat.EXO == 1 & Table4Stat.Trial == 1 ,:);

p1 = ranksum(noEXO_1,EXO_1)

% test dati accoppiati
noEXO_0 = Table4Stat.iEMG_meanNonPar(Table4Stat.EXO == 0 & Table4Stat.Trial == 0 ,:);
noEXO_1 = Table4Stat.iEMG_meanNonPar(Table4Stat.EXO == 0 & Table4Stat.Trial == 1 ,:);

p_noEXO = signrank(noEXO_0,noEXO_1)

% gruppo EXO

EXO_0 = Table4Stat.iEMG_meanNonPar(Table4Stat.EXO == 1 & Table4Stat.Trial == 0 ,:);
EXO_1 = Table4Stat.iEMG_meanNonPar(Table4Stat.EXO == 1 & Table4Stat.Trial == 1 ,:);

p_EXO = signrank(EXO_0,EXO_1)
%% BDSI Non Paretico

% test dati non accoppiati
noEXO_0 = Table4Stat.BDSI_meanNonPar(Table4Stat.EXO == 0 & Table4Stat.Trial == 0 ,:);
EXO_0 = Table4Stat.BDSI_meanNonPar(Table4Stat.EXO == 1 & Table4Stat.Trial == 0 ,:);

p0 = ranksum(noEXO_0,EXO_0)

% differenze al tempo t1
noEXO_1 = Table4Stat.BDSI_meanNonPar(Table4Stat.EXO == 0 & Table4Stat.Trial == 1 ,:);
EXO_1 = Table4Stat.BDSI_meanNonPar(Table4Stat.EXO == 1 & Table4Stat.Trial == 1 ,:);

p1 = ranksum(noEXO_1,EXO_1)

% test dei dati accoppiati
noEXO_0 = Table4Stat.BDSI_meanNonPar(Table4Stat.EXO == 0 & Table4Stat.Trial == 0 ,:);
noEXO_1 = Table4Stat.BDSI_meanNonPar(Table4Stat.EXO == 0 & Table4Stat.Trial == 1 ,:);

p_noEXO = signrank(noEXO_0,noEXO_1)

% gruppo EXO

EXO_0 = Table4Stat.BDSI_meanNonPar(Table4Stat.EXO == 1 & Table4Stat.Trial == 0 ,:);
EXO_1 = Table4Stat.BDSI_meanNonPar(Table4Stat.EXO == 1 & Table4Stat.Trial == 1 ,:);

p_EXO = signrank(EXO_0,EXO_1)