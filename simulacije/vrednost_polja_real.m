function [kot_merjeni,absA,kotA,Bx,By,absSin,absCos]=vrednost_polja_real(theta,r0,xs,ys,xd,yd,koliko_harmonikov,slike,X_tmp,Y_tmp, Zmesh)




% definiraj zacetni poziciji sond
zac_x=[r0;0];
zac_y=[0;r0];

% priprava slike

if slike
ime_slik=strcat('xs=',num2str(xs),', ','ys=',num2str(ys),', ','xd=',num2str(xd),', ','yd=',num2str(yd));


fig_BxBy=figure('Name',strcat('Bx,By, ',ime_slik),'numbertitle','off','Position',[0   550   560   420]);
%clf
hold on

% fig_fft_protokol=figure('Name',strcat('fft protokola, ',ime_slik),'numbertitle','off','Position',[560   550   560   420]);
% clf
% hold on

fig_protokol=figure('Name',strcat('Protokol, ',ime_slik),'numbertitle','off','Position',[1120   550   560   420]);
clf
hold on
end
Bx=zeros(size(theta));
By=zeros(size(theta));
stevec=1;
for i=theta
%   vrednosti rotacijske matrike 
  rot_mat=[cos(i-pi/2) sin(i-pi/2);-sin(i-pi/2) cos(i-pi/2) ]; 


%   pozicija hallove sonde
  hallx=rot_mat*(zac_x+[xs;ys])-[xd;yd];
  hally=rot_mat*(zac_y+[xs;ys])-[xd;yd];
  
  




% shrani vrednost polja Bz




Bx(stevec)=vrednost_B_realno(hallx,X_tmp,Y_tmp,Zmesh);


By(stevec)=vrednost_B_realno(hally,X_tmp,Y_tmp,Zmesh);

stevec=stevec+1;
end

if slike

figure(fig_BxBy);
plot(theta*180/pi,Bx,'-b');
plot(theta*180/pi,By,'-r');
grid on;
legend('B_{H_1}','B_{H_2}');
title('Pomerjeno magnetno polje Hallovih sond v odvisnosti kota zasuka');
xlabel('\theta/ rad');
ylabel('B/ T');
end
kot_merjeni=atan2(By,Bx);

poprava_kota;
kot_merjeni=kot_merjeni;
if slike
figure(fig_protokol)
plot(theta*180/pi,(kot_merjeni-theta)*180/pi,'-r')
grid on


% fftprotokol=fft(kot_merjeni-theta);
% 
% figure(fig_fft_protokol)
% bar(0:19,abs(fftprotokol(1:20)))
% grid on
end

aproksimacija_protokola







end