% Mitja Alic 2018.06.22 Notranje Gorice
% funkcija predvivdi kaksen bo pogresek atan ce je sin ali cos povzrocena 1
% in samo 1 deformacija. Popravis lahko fazo, amplitudo ali offset enega od
% signalov.
clear

sinOff = 0.0;
cosOff = 0.0;

sinAmp = 1.0;
cosAmp = 1;

sinFaza = 90*pi/180;
cosFaza = 0*pi/180;







theta = linspace(0,2*pi-2*pi/8192,8192);

Sin = sinOff+ sinAmp.*sin(theta+sinFaza);
Cos = cosOff+ cosAmp.*cos(theta+cosFaza);

kot = atan2(Sin,Cos);
Err = kot - atan2(sin(theta),cos(theta));
Err(Err<-pi) = Err(Err<-pi)+2*pi;
Err(Err> pi) = Err(Err> pi)-2*pi;
PredErr = zeros(size(theta));
PredErr = PredErr+(sinFaza+cosFaza)/2;

razAmp = sinAmp/cosAmp;
for n = 1:15
    
    PredErr = PredErr+ ...
        1/n.*((razAmp-1)/(razAmp+1))^n*sin(2*n*theta)+...
        1/n.*tan(sinFaza/2)^n*sin(2*n*theta+n*pi/2+n*sinFaza)+...
        1/n.*tan(cosFaza/2)^n*sin(2*n*theta+n*pi/2+n*cosFaza)+...
        1/n*sinOff^n*sin(n*theta +n*pi/2)+ ...
        1/n*cosOff^n*sin(n*theta +n*pi);
end

figure(1)
subplot(3,1,1)
plot(theta,kot)
grid on
title('Numericni Error')

subplot(3,1,2)
plot(theta,PredErr+atan2(sin(theta),cos(theta)))
grid on
title('Predviden Error')

subplot(3,1,3)
plot(theta,PredErr-Err)
grid on
title('Razlika napak')

fftPred = mojfft(PredErr);
fftErr = mojfft(Err);

fftAmp= [fftErr{1},fftPred{1},fftErr{1}-fftPred{1}];
fftPh= [fftErr{2},fftPred{2},fftErr{2}-fftPred{2}];

%%
figure
plot(theta*180/pi,(Err)*180/pi,'Linewidth',3)
axis([0,360,-50,140])
grid on
set(gca,'FontSize',22);
xlabel('$\mathrm{\theta/^\circ}$','Interpreter','latex','FontSize', 28)
ylabel('napaka$/^\circ$','Interpreter','latex','FontSize', 28)
%%

figure
plot(theta*180/pi,(PredErr-Err)*180/pi)
axis([0,360,-4e-14,8e-14])
grid on
set(gca,'FontSize',22);
xlabel('$\mathrm{\theta/^\circ}$','Interpreter','latex','FontSize', 28)
ylabel('razlika med predvideno in dejansko napako$/^\circ$','Interpreter','latex','FontSize', 28)






