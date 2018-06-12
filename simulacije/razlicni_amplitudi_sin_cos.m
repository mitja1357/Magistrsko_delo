clear
theta = linspace(0,360,8192);
Sin = sind(theta);
Cos = cosd(theta);

k = 0:1e-2:20;

for i = 1: length(k)
    kot = atan2d(k(i).*Sin,Cos);
    err(i,:) = kot -theta;
end

err(err<-180) = err(err<-180)+360;
err(err> 180) = err(err> 180)-360;
%%
fftErr = mojfft(err);

har2 = fftErr{1}(:,3);%.*cosd(fftErr{2}(:,3));
har4 = fftErr{1}(:,5);%.*cosd(fftErr{2}(:,5));
har2(k>1) = -har2(k>1);
% har4(k>1) = -har4(k>1);
%%
figure(1)
plot(k,har2,k,har4,'Linewidth',2)
grid on
grid minor
hold on

%%
a2= 180/pi
a4 = 90/pi

fit2 = a2.*(1-k)./(1+k);

fit4 = a4.*((1-k)./(1+k)).^2;
plot(k,fit2,'-r')
plot(k,fit4,'-r')

figure(2)
plot(k, fit4-har4')
