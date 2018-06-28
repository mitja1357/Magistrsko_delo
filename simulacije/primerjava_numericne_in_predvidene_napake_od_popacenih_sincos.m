% Mitja Alic 2018.06.22 Notranje Gorice
% funkcija predvivdi kaksen bo pogresek atan ce je sin ali cos povzrocena 1
% in samo 1 deformacija. Popravis lahko fazo, amplitudo ali offset enega od
% signalov.
clear

sinOff = 0.0;
cosOff = -0.1;

sinAmp = 1.0;
cosAmp = 1;

sinFaza = 0*pi/180;
cosFaza = 0*pi/180;







theta = 0:pi/2048:2*pi;

Sin = sinOff+ sinAmp.*sin(theta+sinFaza);
Cos = cosOff+ cosAmp.*cos(theta+cosFaza);

Err = atan2(Sin,Cos);


PredErr = zeros(size(theta));
PredErr = PredErr+(sinFaza+cosFaza)/2+atan2(sin(theta),cos(theta));

razAmp = sinAmp/cosAmp;
for n = 1:1500
    
    PredErr = PredErr+ ...
        1/n.*((razAmp-1)/(razAmp+1))^n*sin(2*n*theta)+...
        1/n.*tan(sinFaza/2)^n*sin(2*n*theta+n*pi/2+n*sinFaza)+...
        1/n.*tan(cosFaza/2)^n*sin(2*n*theta+n*pi/2+n*cosFaza)+...
        1/n*sinOff^n*sin(n*theta +n*pi/2)+ ...
        1/n*cosOff^n*sin(n*theta +n*pi);
end

figure(1)
subplot(3,1,1)
plot(theta,Err)
grid on
title('Numericni Error')

subplot(3,1,2)
plot(theta,PredErr)
grid on
title('Predviden Error')

subplot(3,1,3)
plot(theta,PredErr-Err)
grid on
title('Razlika napak')

fftRazlike = mojfft(PredErr-Err);


