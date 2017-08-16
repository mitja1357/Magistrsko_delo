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

t=linspace(0,1,T);
h=10;
[c0,a,b,c,fi] = fourier(t,kot1,h,0);
pospesk=0;
for i=1:h
    pospesk=pospesk+i^2*a(i).*cos(i*2*pi/T *t)+i^2*b(i).*sin(i*2*pi/T *t);
end
w=2*pi/T;
pospesk=pospesk*-w^2;

figure
plot(pospesek2)





hitrost1=diff(kot1)/0.001;
pospesek1=diff(hitrost1)/0.001;


figure
plot(hitrost1)
figure
plot(pospesek1)
hold on
plot(-kot1*1000000,'r')


