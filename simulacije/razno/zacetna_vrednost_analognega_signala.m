% clear
% 
% load('Rezultati_meritve.mat')
% load('Rezultati_simulacij.mat')

eks='xd';


eval(strcat('meritev=meritev_',eks,';'));
eval(strcat('rea=real_',eks, ';'));



%% doloci katere prikazes

dis=[0,0.25,0.5];
for i=1:3
    najmanjsi_m=min(abs(meritev.displacement-dis(i)));
    najmanjsi_r=min(abs(rea.displacement-dis(i)));
    
    if ismember(najmanjsi_m+dis(i),meritev.displacement)
        mer_prik(i)=find(meritev.displacement==najmanjsi_m+dis(i),1,'first');
    else
        mer_prik(i)=find(meritev.displacement==-najmanjsi_m+dis(i),1,'first');
    end
    
    if ismember(najmanjsi_r+dis(i),meritev.displacement)
        rea_prik(i)=find(rea.displacement==najmanjsi_r+dis(i),1,'first');
    else
        rea_prik(i)=find(rea.displacement==-najmanjsi_r+dis(i),1,'first');
    end    
end
mer_1st_point=find(meritev.sin(1,:)>0,1,'first');
rea_1st_point=find(rea.sin(1,:)>0,1,'first')+1;
clear i dis najmanjsi_m najmanjsi_r
%% prikazi slikce

rea_prik=1:length(rea.displacement);
mer_prik=1:length(meritev.displacement);

figure(1)
subplot(2,2,1)
plot(rea.displacement(rea_prik), rea.sin(rea_prik,rea_1st_point)./4,'-*b')
hold on
plot(meritev.displacement(mer_prik), meritev.sin(mer_prik,mer_1st_point),'-*r');
hold off
grid on
title([eks,' sinus'])
legend('real','merit')

subplot(2,2,2)
plot(rea.displacement(rea_prik), rea.cos(rea_prik,rea_1st_point),'-*b')
hold on
plot(meritev.displacement(mer_prik), meritev.cos(mer_prik,mer_1st_point),'-*r');
hold off
grid on
title([eks,' cosinus'])
legend('real','merit')

subplot(2,2,3)
plot(rea.displacement(rea_prik), rea.protocol(rea_prik,rea_1st_point)-90,'-*b')
hold on
plot(meritev.displacement(mer_prik), meritev.protocol(mer_prik,mer_1st_point) ...
    -meritev.protocol(mer_prik(1),mer_1st_point),'-*r');
hold off
grid on
title([eks,' protocol'])
legend('real','merit')

subplot(2,2,4)

rea.protocol(rea.protocol>180)=rea.protocol(rea.protocol>180)-360;
plot(rea.protocol(:,[rea_1st_point:end,1:rea_1st_point-1])')
