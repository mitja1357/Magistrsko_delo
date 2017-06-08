clear all;
close all;
%definiraj ekscentricnost
xs=0.0+0*(rand()-0.5);
ys=0+0*(rand()-0.5);
xd=0.10+0*(rand()-0.5);
yd=0+0*(rand()-0.5);
% definiraj zacetni poziciji sond
zac_x=[1;0];
zac_y=[0;1];
% definiraj kote
theta=linspace(-pi,pi,1000);
% priprava slike


ime_slik=strcat('xs=',num2str(xs),', ','yd=',num2str(ys),', ','xd=',num2str(xd),', ','yd=',num2str(yd));


fig_BxBy=figure('Name',strcat('Bx,By, ',ime_slik),'numbertitle','off','Position',[0   550   560   420]);
clf
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
  rot_mat=[cos(i) -sin(i);sin(i) cos(i) ]; 


%   pozicija hallove sonde
  hallx=rot_mat*(zac_x+[xd;yd])+[xs;ys];
  hally=rot_mat*(zac_y+[xd;yd])+[xs;ys];

% shrani vrednost polja Bz

Bx(stevec)=hallx(1);
By(stevec)=hally(1);

stevec=stevec+1;
end
figure(fig_BxBy)
plot(theta,Bx,'-b')
plot(theta,By,'-r')
grid on
legend('B_x','B_y')

kot_merjeni=atan2(Bx,By);

poprava_kota;


figure(fig_protokol)
plot(kot_merjeni-theta,'-r')
grid on


fftprotokol=fft(kot_merjeni-theta);

figure(fig_fft_protokol)
plot(0:9,abs(fftprotokol(1:10)))
grid on