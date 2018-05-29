%%
theta=linspace(0,360,8192*4);

sin_har2nd=[];
sin_amp=[];
sin_off=[];
sin_phase=[];

cos_har2nd=[];
cos_amp=[];
cos_off=[];
cos_phase=[];

meritve=[];
%%
for i=-5:1:5
    kot=theta+i;
    sinus.analog=sind(kot);
    cosinus.analog=cosd(theta);
    
    % create fft
    
    L=length(theta);
    
    Y=fft(sinus.analog);   
    P2 = abs(Y/L);
    P1 = P2(1:L/2+1);
    P1(2:end-1) = 2*P1(2:end-1);
    
    sinus.fft_mag=P1;
    tmp=angle(Y);
    sinus.fft_phase=tmp(1:L/2+1).*180/pi;
    
    
    Y=fft(cosinus.analog);
    P2 = abs(Y/L);
    P1 = P2(1:L/2+1);
    P1(2:end-1) = 2*P1(2:end-1);
        
    cosinus.fft_mag=P1;
    tmp=angle(Y);
    cosinus.fft_phase=tmp(1:L/2+1).*180/pi;
    
    sin_har2nd=[sin_har2nd;sinus.fft_mag(3)];
    sin_amp=[sin_amp;sinus.fft_mag(2)];
    sin_off=[sin_off;sinus.fft_mag(1)];
    sin_phase=[sin_phase;sinus.fft_phase(2)];
    
    cos_har2nd=[cos_har2nd;cosinus.fft_mag(3)];
    cos_amp=[cos_amp;cosinus.fft_mag(2)];
    cos_off=[cos_off;cosinus.fft_mag(1)];
    cos_phase=[cos_phase;cosinus.fft_phase(2)];
    meritve=[meritve i];
end

%%
figure
subplot(2,2,1)
plot(meritve,cosinus.amp)
hold on
plot(meritve,sinus.amp,'-r')
legend('cos','sin')
title('Potek amp')
    
    
subplot(2,2,2)
plot(meritve,cosinus.off)
hold on
plot(meritve,sinus.off,'-r')
legend('cos','sin')
title('Potek offseta')

subplot(2,2,3)
plot(meritve,cosinus.har2nd)
hold on
plot(meritve,sinus.har2nd,'-r')
legend('cos','sin')
title('Potek 2nd harmonika')


subplot(2,2,4)
plot(meritve,cosinus.phase-sinus.phase)
title('Potek faze')



    
    
    