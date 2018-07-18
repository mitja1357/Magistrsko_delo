theta=linspace(0,360,10000);

A0=0.0;
B0=0.2;

A1=1.0;
B1=1.00;

fi_A1=0;
fi_B1=0;

asin=A1.*sind(theta+fi_A1)+A0;
acos=B1.*cosd(theta+fi_B1)+B0;
protokol=atan2d(asin,acos)-theta;
protokol(protokol<-180)=protokol(protokol<-180)+360;
protokol(protokol> 180)=protokol(protokol> 180)-360;

f1=figure('Position',[1921 17 1680 974]);
subplot(2,2,1)
plot(theta,asin,'-g',theta,acos,'-m',theta,cosd(theta),':b',theta,sind(theta),':r','LineWidth',2)
title('analogs')
grid on
subplot(2,2,2)
plot(acos,asin,'-b',cosd(theta),sind(theta),':r','LineWidth',2)
title('Lissajous')
axis equal
grid on 
grid minor

pred_err=(fi_A1+fi_B1)./2+(fi_A1-fi_B1)./2.*cosd(2.*theta)+ ...
         (A1./B1-1)./2.*sind(2.*theta).*180/pi+ ...
         A0.*cosd(theta).*180/pi-...
         B0.*sind(theta).*180/pi;

subplot(2,2,3)
title('Napaka')
[hAx,hL1,hL2]=plotyy(theta,[protokol;pred_err],theta,protokol-pred_err)
hL1.LineWidth=2;
hL2.LineWidth=2;

legend('protokol','pred err')
grid on
grid minor

Y=fft(protokol-pred_err);
mag=2.*abs(Y(1:(length(Y)/2+1)))./length(Y);

subplot(2,2,4)
bar(mag(1:6))
title('razlika napak')
grid on
grid minor



%%
close all