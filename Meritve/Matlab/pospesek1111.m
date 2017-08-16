% izracun hitrosti



[kot]=uvoz_podatkov('2017_08_16\kot_rm44.csv');

hitrost=diff(kot)/0.001;
pospesek2=diff(hitrost)/0.001;
T=1000;
figure
plot(hitrost)
figure
plot(pospesek2)
[kot1]=uvoz_podatkov('2017_08_16\err_1_period.csv');
kot1=kot1*360;
t=linspace(0,1,T);
h=10;
[c0,a,b,c,fi] = fourier(t,kot1,h,0);
pospesk=0;

bar(b)

for ii=1:h
    
    
    cosinusni=ii^2.*a(ii).*cosd(ii*360 .*t);
    sinusni=ii^2.*b(ii).*sind(ii*360 .*t);
    pospesk=pospesk+cosinusni+sinusni;
end
w=2*pi/T;
pospesk=pospesk*1;

figure
plot(pospesk)





hitrost1=diff(kot1)/0.001;
pospesek1=diff(hitrost1)/0.001;


figure
plot(hitrost1)
figure
plot(pospesek1)
hold on
plot(-kot1*1000000,'r')


