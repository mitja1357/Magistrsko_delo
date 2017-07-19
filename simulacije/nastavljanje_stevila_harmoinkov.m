
clear all
load('X_tmp.mat');
load('Y_tmp.mat');
load('Zmesh.mat');
X_tmp=(round(X_tmp.*50)/50);
Y_tmp=(round(Y_tmp.*50)/50);


theta=linspace(-pi,pi,2048);
r0=2.4;
xs=0.1;
ys=0.0;
xd=0.0;
yd=0.0;


harmonikov=8;

[kot_merjeni,absA,kotA,Bx,By,absSin,absCos]=vrednost_polja_real(theta,r0,xs,ys,xd,yd,harmonikov,0,X_tmp,Y_tmp, Zmesh);
