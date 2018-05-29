

get_angle=meritev_xd.protocol;
for i=1:12
    get_angle(i,:)=get_angle(i,:)+linspace(0,360,1000);
end
clear i

get_sine=sind(get_angle);
get_cosine=cosd(get_angle);

%%
sinus.fft_mag=[];
sinus.fft_phase=[];
cosinus.fft_mag=[];
cosinus.fft_phase=[];
for i=1:size(get_sine,1)
    L=length(get_sine);
    
    Y=fft(get_sine(i,:));   
    P2 = abs(Y/L);
    P1 = P2(1:L/2+1);
    P1(2:end-1) = 2*P1(2:end-1);
    
    sinus.fft_mag(i,:)=P1;
    tmp=angle(Y);
    sinus.fft_phase(i,:)=tmp(1:L/2+1).*180/pi;
        
    Y=fft(get_cosine(i,:));   
    P2 = abs(Y/L);
    P1 = P2(1:L/2+1);
    P1(2:end-1) = 2*P1(2:end-1);
    
    cosinus.fft_mag(i,:)=P1;
    tmp=angle(Y);
    cosinus.fft_phase(i,:)=tmp(1:L/2+1).*180/pi;
    
end
clear P1 P2 tmp Y L i

%%

figure('Name','fft merive analognih signalov');

subplot(2,2,1)
plot(meritev_xd.displacement,sinus.fft_mag(:,2))
hold on
plot(meritev_xd.displacement,cosinus.fft_mag(:,2),'-r')
legend('Sin','Cos')
grid on
grid minor
title('amplituda')

subplot(2,2,2)
plot(meritev_xd.displacement,sinus.fft_mag(:,1))
hold on
plot(meritev_xd.displacement,cosinus.fft_mag(:,1),'-r')
legend('Sin','Cos')
grid on
grid minor
title('offset')

subplot(2,2,3)
plot(meritev_xd.displacement,sinus.fft_mag(:,3))
hold on
plot(meritev_xd.displacement,cosinus.fft_mag(:,3),'-r')
legend('Sin','Cos')
grid on
grid minor
title('2nd harm')

subplot(2,2,4)
plot(meritev_xd.displacement,-sinus.fft_phase(:,2)+cosinus.fft_phase(:,2))
grid on
grid minor
title('faza')



























