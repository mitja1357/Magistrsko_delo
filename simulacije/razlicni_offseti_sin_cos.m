clear
theta = linspace(0,2*pi,8192);



k = -0.2:0.01:.2;

primer = 1;
Sin = zeros(length(k),length(theta));
Cos = Sin;
theta1 = Sin;
predviden_err = Sin;

for i = 1: length(k)
    if primer == 1
        Sin(i,:) = sin(theta)+k(i);
        Cos(i,:) = cos(theta);
    elseif primer == 2
        Sin(i,:) = sin(theta);
        Cos(i,:) = cos(theta)+k(i);
    elseif primer == 3
        Sin(i,:) = sin(theta)+k(i);
        Cos(i,:) = cos(theta)+k(i);
    end
    
    predviden_err(i,:) = (k(i)+(1/3)*k(i)^3)*cos(theta)+0.5*k(i)^2*cos(2*theta+pi/2)+ ...
                         +k(i)^3*cos(theta+pi)/3;
    
    theta1(i,:) = theta;
end

fftSin = mojfft(Sin);
fftCos = mojfft(Cos);
faza = fftSin{2}(:,2)-fftCos{2}(:,2);
kot = atan2(Sin,Cos);
err = kot -theta1;
err(err<-pi) = err(err<-pi)+2*pi;
err(err> pi) = err(err> pi)-2*pi;



%%
fftErr = mojfft(err);
najvecji_error = fftErr{1}(1,2:end);
harmoniki = 1:length(najvecji_error);

figure
plot(harmoniki,najvecji_error-2*exp(-log(10)*harmoniki))
%%

har0 = fftErr{1}(:,1).*cosd(fftErr{2}(:,1));
har1 = fftErr{1}(:,2);
har1(k<0) = -har1(k<0);
har2 = fftErr{1}(:,3);
har3 = fftErr{1}(:,4);
har4 = fftErr{1}(:,5);


figure(1)
subplot(2,2,1)
plot(k,har0,k,har1,k,har2,k,har3,k,har4)
legend(num2str((0:4)'))
subplot(2,2,2)
plot(theta1',err')
legend(num2str(k'))
subplot(2,2,3)
plot(theta,err(1,:)-predviden_err(1,:))




%%

fft_napake=mojfft(err-predviden_err);
%%
napaka1har = fft_napake{1, 1}(:,2);
napaka1har(k<0)=-napaka1har(k<0);

napaka3har = fft_napake{1, 1}(:,4);
napaka3har(k<0)=-napaka1har(k<0);
subplot(2,2,4)
plot(k,napaka1har)