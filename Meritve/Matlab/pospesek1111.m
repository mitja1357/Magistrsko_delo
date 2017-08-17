% izracun hitrosti

%{

[kot]=uvoz_podatkov('2017_08_16\kot_rm44.csv');

hitrost=diff(kot)/0.001;
pospesek2=diff(hitrost)/0.001;
T=1000;
figure
plot(hitrost)
figure
plot(pospesek2)
%}
clear all
T=1000;
[kot1]=uvoz_podatkov('2017_08_16\err_1_period.csv');
kot1=kot1*360;



t=linspace(0,1,T);
h=5;
[c0,a,b,c,fi] = fourier(t,kot1,h,0);





aproksimacija=c0;

for i=1:h
    
    aproksimacija=aproksimacija+ c(i)*cosd(i*360*t+fi(i));
end

drugi_odvod=diff(aproksimacija)*(1000/360)^2;

    
    
    
% pospesk=0;

% bar(b)

kot1_filtriran=clen_prvega_reda(kot1,360/1000,1,1);
% 


hitrost1=diff(kot1_filtriran)/(360/1000);
hold off
plot(hitrost1)
hold on
plot(kot1_filtriran,'r')


hitrost1_filtriran=clen_prvega_reda(hitrost1,360/1000,1,1);

hold off
plot(kot1_filtriran)
hold on
plot(hitrost1_filtriran,'r')


pospesek1=diff(hitrost1_filtriran)/(360/1000)*5;

hold off
plot(pospesek1)
hold on
plot(hitrost1_filtriran,'r')


pospesek1_filtriran=clen_prvega_reda(pospesek1,360/1000,5,1);


hold off
plot(pospesek1)
hold on
plot(pospesek1_filtriran,'r')



hold off

plot(kot1_filtriran)
hold on
plot(hitrost1_filtriran,'r')
plot(pospesek1_filtriran,'m');

w=2*pi;
for i=1:h
    
    amp_posp(i)=-(i*w)^2*c(i);
    cosinusni(i,:)=amp_posp(i)*cos(i*w.*t+fi(i));
    
end
hold off

%plot(360*t,kot1);
plot(360*t(1:end-1),drugi_odvod)
hold on
plot(360*t,sum(cosinusni)/300,'k');
%{


w=2*pi/T;
pospesk=pospesk*1;

figure
plot(pospesk)



[pomerjena_hitrost]=uvoz_podatkov('2017_08_17\hitrost.csv');

kot_predviden=linspace(0,2*pi,1000);

kot_integriran=trapz(kot_predviden,pomerjena_hitrost);


odvod_pomerjena_hitrost=diff(pomerjena_hitrost)/(2*pi/1000);
figure
plot(odvod_pomerjena_hitrost)


[error,speed,navor]=uvoz_podatkov('2017_08_17\err_spee_navor.csv');

hold off
plot(360*t,kot1)
drugi_odvod_kota1=diff(kot1,2)/(360/1000)^2;
%}
