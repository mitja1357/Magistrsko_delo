% 3.8.2017 Mitja Alic
% funkcija uvozi csv file in naredi fouriejevo vrsto
% izhod je array harmonikov in enosmerne komponente element 1 je enosmerna
% komponenta

function [amps,error]= izpis_harmonikov(ime, st_harmonikov) 

[error]=uvoz_podatkov(ime);
error=error*360;
[c0,a,b,c] = fourier(1:1000,error,st_harmonikov,0);
clear a b

amps=[c0,c];

end


% xs=0:1e-6:300e-6;
% app_sim= [ 0.000000000012404e+10 0.000001317106809e+10  -0.001390729685983e+10   4.194420358607621e+10];
% simulacijski=app_sim(1)+app_sim(2)*xs+app_sim(3)*xs.^2+app_sim(4)*xs.^3;
% 
% meritve=koef_mnk(1,1)+koef_mnk(2,1)*xs+koef_mnk(3,1)*xs.^2+koef_mnk(4,1)*xs.^3;
% figure
% plot(xs,simulacijski,'b')
% hold on
% plot(xs,meritve,'r')

