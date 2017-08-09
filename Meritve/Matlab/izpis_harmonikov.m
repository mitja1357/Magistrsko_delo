% 3.8.2017 Mitja Alic
% funkcija uvozi csv file in naredi fouriejevo vrsto
% vhod je ime csv file ('kako_se_imenuje.csv'), stevilo harmonikov je na
% koliko harmonikov zelis da jih razvrsti v fouriejevi vrsti, slike pa je
% bit ali zelis videti slike ali ne
% izhod je array harmonikov in enosmerne komponente element 1 je enosmerna
% komponenta

function [amps,error,napaka]= izpis_harmonikov(ime, st_harmonikov,slike, odstrani_offset,approx,c_offset) 

[error]=uvoz_podatkov(ime);
error=error*360;
error=error-c_offset;
[c0,a,b,c] = fourier(1:1000,error,st_harmonikov,0);


if odstrani_offset
    
    error=error-c0;
    c0=0;
end



kot=linspace(0,360,1000);

napaka=0;
for i=1:st_harmonikov
    napaka=napaka + a(i).*cosd(i.*kot)+b(i).*sind(i.*kot);
end
napaka=napaka+c0;

clear a b

amps=[c0,c];


if slike
    figure
    plot(kot,error,'-r');
    if approx
    hold on
    plot(kot,napaka,'-b')
    end
    grid on
    figure
    bar(0:st_harmonikov,amps);
    grid on
end


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

