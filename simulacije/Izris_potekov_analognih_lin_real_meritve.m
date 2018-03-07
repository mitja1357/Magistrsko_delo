close all

load('Rezultati_meritve.mat')
load('Rezultati_simulacij.mat')
st='xd';
eval(strcat('Meritev.dist=meritev_',st,'.displacement;'))
eval(strcat('Meritev.sin=meritev_',st,'.sin;'))
eval(strcat('Meritev.cos=meritev_',st,'.cos;'))
eval(strcat('Real.dist=real_',st,'.displacement;'))
eval(strcat('Real.sin=real_',st,'.sin;'))
eval(strcat('Real.cos=real_',st,'.cos;'))
eval(strcat('Lin.dist=lin_',st,'.displacement;'))
eval(strcat('Lin.sin=lin_',st,'.sin;'))
eval(strcat('Lin.cos=lin_',st,'.cos;'))

Meritev.sinfft=mojfft(Meritev.sin);
Meritev.cosfft=mojfft(Meritev.cos);
Real.sinfft=mojfft(Real.sin);
Real.cosfft=mojfft(Real.cos);
Lin.sinfft=mojfft(Lin.sin);
Lin.cosfft=mojfft(Lin.cos);

Real.sinfft(:,2)=Real.sinfft(:,2).*Meritev.sinfft(1,2)./Real.sinfft(1,2);
Real.cosfft(:,2)=Real.cosfft(:,2).*Meritev.cosfft(1,2)./Real.cosfft(1,2);

 scrsz = get(0,'ScreenSize');

figure('Position',[1930 scrsz(4)-30-80-710 950 710]);

plot(Meritev.dist,Meritev.sinfft(:,1),'LineWidth',2)
hold on
plot(Meritev.dist,Meritev.cosfft(:,1),'LineWidth',2)
plot(Real.dist,Real.sinfft(:,1),'LineWidth',2)
plot(Real.dist,Real.cosfft(:,1),'LineWidth',2)
plot(Lin.dist,Lin.sinfft(:,1).*20,'LineWidth',2)
plot(Lin.dist,Lin.cosfft(:,1).*20,'LineWidth',2);
 title(['Offset ' st])
 legend({'Mersin','Mercos','Real sin','Realcos','Linsin','lincos'})
 grid on

 figure('Position',[2895 scrsz(4)-30-80-710 950 710]);
 
 plot(Meritev.dist,Meritev.sinfft(:,2)','LineWidth',2)
 hold on
 plot(Meritev.dist,Meritev.cosfft(:,2)','LineWidth',2)
 plot(Real.dist,Real.sinfft(:,2)','LineWidth',2)
 plot(Real.dist,Real.cosfft(:,2)','LineWidth',2)
 plot(Lin.dist,Lin.sinfft(:,2)'.*20,'LineWidth',2)
 plot(Lin.dist,Lin.cosfft(:,2)'.*20,'LineWidth',2);
  legend({'Mersin','Mercos','Real sin','Realcos','Linsin','lincos'})
grid on
grid minor
title(['Amps ', st])
 
