%****************************************************************
% FILENAME:     DFT_m.m
% DESCRIPTION:  DFT transformacija, A in B koeficient
% AUTHOR:       Mitja Nemec
% START DATE:   22.12.2010
% VERSION:      1.0
%
% CHANGES : 
% VERSION   DATE        WHO         DETAIL 
% 1.0       22.12.2010   Mitja Nemec Initial version
%
%****************************************************************
%
%   Funkcija, ki izracuna DFT signala, in vrne A in B komponento.
%   Pri izraèunu ne uporablja nobenega okna, zaradi tega je moèno zaželeno, da
%   so periode signalov, ki jih opazujemo, natanèni veèkratniki vzorène priode.
%
% Uporaba:
%   [A,B] = DFT_m(VHOD,F,FS) kjer je VHOD ekvidistanèno vzorèeni signal
%   nad katerim želimo narediti DFT in F frekvenca za katero delamo DFT in FS
%   vzorcna frekvenca. Funckija vrne A in B koeficient tranformacije
%



function [A,B]=DFT_m(VHOD,F,DT)

[M,N] = size(VHOD);
if N > M
    VHOD = transpose(VHOD);
end

FS = 1/DT;
s = max(size(VHOD));
IZHOD = zeros(size(VHOD));

% vektor casa
t = transpose((0:s-1)/FS);

sinus = sin(2*pi*F*t);
cosinus = cos(2*pi*F*t);

A = 2*sum(cosinus.*VHOD)/s;
B = 2*sum(sinus.*VHOD)/s;


