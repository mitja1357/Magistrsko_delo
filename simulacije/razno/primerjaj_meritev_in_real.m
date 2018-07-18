eks='xs'

eval(strcat('meritev=meritev_',eks,';'))

for i=1:length(meritev.displacement)
    
    prvi_el(i)=find(meritev.sin(i,:)>0,1,'first');
    
    nova_raz=[prvi_el(i):1000,1:(prvi_el(i)-1)];
%     nova_raz=nova_raz([250:1000,1:249]);
    meritev.sin(i,:)=meritev.sin(i,nova_raz);
    meritev.cos(i,:)=meritev.cos(i,nova_raz);
    meritev.protocol(i,:)=atan2d(meritev.sin(i,:),meritev.cos(i,:));
    meritev.protocol(i,:)=meritev.protocol(i,:)-meritev.ref(i,:);
    
end
meritev.protocol(meritev.protocol<-180)=meritev.protocol(meritev.protocol<-180)+360;

figure(1)
subplot(2,2,1)
plot(meritev.protocol')
grid on
legend(num2str(meritev.displacement))

subplot(2,2,2)
plot(meritev.sin')
hold on
plot(meritev.cos')
hold off

mean(meritev.protocol,2);


eval(strcat('rea=real_',eks,';'))

subplot(2,2,3)
plot(rea.protocol')
grid on
legend(num2str(rea.displacement))
subplot(2,2,4)
plot(rea.sin')
hold on
plot(rea.cos')
hold off

mean(meritev.protocol,2);



fft_sin=mojfft(meritev.sin);
fft_cos=mojfft(meritev.cos);

fft_sinr=mojfft(rea.sin);
fft_cosr=mojfft(rea.cos);

faza_m = fft_sin{2}(:,2)-fft_cos{2}(:,2);
faza_r = fft_sinr{2}(:,2)-fft_cosr{2}(:,2);
faze=zeros(21,1);
faze(:,2)=faza_r;
faze(1:length(faza_m),1) = faza_m;
figure(2);
har=[1;3;4;5];
subplot(1,2,1)
plot(fft_cosr{1}(:,har))
hold on
plot(fft_cos{1}(:,har),':')
hold off
title('cosinus')
legend(num2str([har;har]-1))
subplot(1,2,2)
plot(fft_sinr{1}(:,har))
hold on
plot(fft_sin{1}(:,har),':')
hold off
title('sinus')

legend(num2str([har;har]-1))





figure(4)
plot(meritev.protocol(:,1))
grid on