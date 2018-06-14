clear
theta = linspace(0,2*pi,8192);



k = 0:0.01:.1;

primer = 3;
Sin = zeros(length(k),length(theta));
Cos = Sin;
theta1 = Sin;
predviden_err = Sin;

for i = 1: length(k)
    if primer == 1
        Sin(i,:) = sin(theta)+k(i);
        Cos(i,:) = cos(theta);
        for n = 1:15
            predviden_err(i,:) = predviden_err(i,:) +...
                k(i)^n/n*sin(n*theta +n*pi/2);
        end
    elseif primer == 2
        Sin(i,:) = sin(theta);
        Cos(i,:) = cos(theta)+k(i);
        for n = 1:15
            predviden_err(i,:) = predviden_err(i,:) +...
                (-1)^n*k(i)^n/n*sin(n*theta);
        end
        
    elseif primer == 3
        Sin(i,:) = sin(theta)+k(i);
        Cos(i,:) = cos(theta)+k(i);
        
        for n = 1:15
            predviden_err(i,:) = predviden_err(i,:) +...
                k(i)^(n)/n*2*cos(pi/4*n) *sin(n*theta+3*pi/4*n);
        

        end
        
        
    end
    theta1(i,:) = theta;
end
fftSin = mojfft(Sin);
fftCos = mojfft(Cos);
% faza = fftSin{2}(:,2)-fftCos{2}(:,2);
kot = atan2(Sin,Cos);
err = kot -theta1;
err(err<-pi) = err(err<-pi)+2*pi;
err(err> pi) = err(err> pi)-2*pi;

figure(1)
subplot(3,1,1)
plot(theta1',err')
subplot(3,1,2)

plot(theta1',predviden_err')
subplot(3,1,3)

plot(theta1',predviden_err'-err')

%%
fftErr = mojfft(err);
magnitude= fftErr{1}(:,2:end);
najvecji_error = err(end,:);

an = fftErr{1}.*cosd(fftErr{2});
bn = fftErr{1}.*sind(fftErr{2});

for i =1:10
    eval(strcat('an',num2str(i-1),'=an(:,',num2str(i),');'))
    eval(strcat('bn',num2str(i-1),'=bn(:,',num2str(i),');'))
end



fft_najvecji_error = fftErr{1}(end,2:end);
harmoniki = 1:length(fft_najvecji_error);
predvidi = zeros(1,8192);
k1 = k(1);
for i = 1:5
    test = k1^i/i*sqrt(2+2*cos(i*pi/2)*cos(pi*i)).*cos(i.*theta-pi/2*(3-i));

predvidi = predvidi + test;
end
fft_predviden = mojfft(predvidi);

figure(1)
plot(fft_najvecji_error')


har0 = fftErr{1}(:,1).*cosd(fftErr{2}(:,1));
har1 = fftErr{1}(:,2);

har2 = fftErr{1}(:,3);
har3 = fftErr{1}(:,4);
har4 = fftErr{1}(:,5);
har5 = fftErr{1}(:,6);
har6 = fftErr{1}(:,7);
har7 = fftErr{1}(:,8);
har1(k<0) = -har1(k<0);
har3(k<0) = -har3(k<0);
har5(k<0) = -har5(k<0);
har7(k<0) = -har7(k<0);
figure(2)
subplot(2,2,1)
plot(k,har0,k,har1,k,har2,k,har3,k,har4)
legend(num2str((0:4)'))
subplot(2,2,2)
plot(theta1',err')
legend(num2str(k'))
% subplot(2,2,3)
% plot(theta,err(1,:)-predviden_err(1,:))




% %%
% 
% fft_napake=mojfft(err-predviden_err);
% %%
% napaka1har = fft_napake{1, 1}(:,2);
% napaka1har(k<0)=-napaka1har(k<0);
% 
% napaka3har = fft_napake{1, 1}(:,4);
% napaka3har(k<0)=-napaka1har(k<0);
% subplot(2,2,4)
% plot(k,napaka1har)
%%
for i = 1:4095
    kvocient(i) = fft_najvecji_error(i)/fft_najvecji_error(i+1);
end
plot(kvocient)
