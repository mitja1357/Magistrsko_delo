clear
theta = linspace(0,2*pi,8192);

primer = 2;


x = linspace(-pi/2,pi/2,500);



Sin = zeros(length(x),length(theta));
Cos = Sin;
theta1 = Sin;
predviden_err = Sin;
dodajSin = Sin;
dodajCos = Sin;
tempSin = ones(1,length(theta));


for i = 1: length(x)
    dodajSin(i,:) =sin(x(i)).*tempSin;
    dodajCos(i,:) =cos(x(i)).*tempSin;
    theta1(i,:) = theta;
end
if primer == 1
    Sin = dodajCos.*sin(theta1)+dodajSin.*cos(theta1);
    Cos = cos(theta1);
elseif primer == 2
    Sin = sin(theta1);
    Cos = dodajCos.*cos(theta1)-dodajSin.*sin(theta1);
end


kot = atan2(Sin,Cos);
clear Sin Cos primer i n
err = kot -theta1;
err(err<-pi) = err(err<-pi)+2*pi;
err(err> pi) = err(err> pi)-2*pi;

PredErr = pi/4.*ones(size(theta1));
% for n = 1: 100
% %     k(n) =  (2*(cos(n*pi/4))^2+3*cos(n*pi/2)+4*cos(3*n*pi/2)-1)./(4*n);
%     PredErr = PredErr+1/n.*sin(2*n*theta+n*pi);
% end

figure(1)
subplot(2,1,1)
plot(theta1'.*180/pi,err'.*180/pi)
grid on

subplot(2,1,2)
plot(theta1'.*180/pi,PredErr'.*180/pi)
grid on

fftErr = mojfft(err);
fftPred = mojfft(PredErr);
h = fftErr{1, 1}(3:2:30,:);
xh = 2*(1:length(h))';
x = x*180/pi;
%%
h0 = fftErr{1, 1}(:,1).*cosd(fftErr{2}(:,1));
h2 = fftErr{1, 1}(:,3)*180/pi;
h2(x<0) = -h2(x<0);
h4 = fftErr{1, 1}(:,5);
h6 = fftErr{1, 1}(:,7);
h8 = fftErr{1, 1}(:,9);
h10 = fftErr{1, 1}(:,11);
h12 = fftErr{1, 1}(:,13);