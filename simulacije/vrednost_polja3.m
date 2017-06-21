% clear all;
% close all;
%definiraj ekscentricnost
xs=0.0+0*(rand()-0.5);
ys=0.0+0*(rand()-0.5);
xd=0.10+0*(rand()-0.5);
yd=-0.0+0*(rand()-0.5);
% definiraj zacetni poziciji sond
zac_x=[1;0];
zac_y=[0;1];
% definiraj kote
theta=linspace(-pi/1,pi/1,1000);
% priprava slike


ime_slik=strcat('xs=',num2str(xs),', ','yd=',num2str(ys),', ','xd=',num2str(xd),', ','yd=',num2str(yd));


fig_BxBy=figure('Name',strcat('Bx,By, ',ime_slik),'numbertitle','off','Position',[0   550   560   420]);
%clf
hold on

fig_fft_protokol=figure('Name',strcat('fft protokola, ',ime_slik),'numbertitle','off','Position',[560   550   560   420]);
clf
hold on

fig_protokol=figure('Name',strcat('Protokol, ',ime_slik),'numbertitle','off','Position',[1120   550   560   420]);
clf
hold on

Bx=zeros(size(theta));
By=zeros(size(theta));
stevec=1;
for i=theta
%   vrednosti rotacijske matrike 
  rot_mat=[cos(i) sin(i);-sin(i) cos(i) ]; 


%   pozicija hallove sonde
  hallx=rot_mat*(zac_x+[xs;ys])-[xd;yd];
  hally=rot_mat*(zac_y+[xs;ys])-[xd;yd];

% shrani vrednost polja Bz

Bx(stevec)=hallx(1);
By(stevec)=hally(1);

stevec=stevec+1;
end
figure(fig_BxBy);
plot(theta,Bx,'-b');
plot(theta,By,'-r');
grid on;
legend('B_{H_1}','B_{H_2}');
title('Pomerjeno magnetno polje Hallovih sond v odvisnosti kota zasuka');
xlabel('\theta/ rad');
ylabel('B/ T');

kot_merjeni=atan2(By,Bx);

poprava_kota;


figure(fig_protokol)
plot(theta,(kot_merjeni-theta)*180/pi,'-r')
grid on


fftprotokol=fft(kot_merjeni-theta);

figure(fig_fft_protokol)
bar(0:19,abs(fftprotokol(1:20)))
grid on