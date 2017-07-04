%iz datoteke onaxis.txt prebere podatke in jih zvrsti v tri 1D matrike
%za izris v mesh ali surf potrebujes se funkcijo To_meshgrid.m
%tic

load('PODATKI.mat');

B=PODATKI;
X=B(:,1);
Y=B(:,2);
Z=B(:,3);
clear A B filename;
%toc

