clear
theta = linspace(0,360,8192);
Sin = sind(theta);
Cos = cosd(theta);

k = -30:30:30;
primer = 1;
for i = 1: length(k)
    if primer == 1
        Sin = sind(theta+k(i));
    elseif primer == 2
        Cos = cosd(theta+k(i));
    else
    end
    fftSin = mojfft(Sin);
    fftCos = mojfft(Cos);
    faza(i) = fftSin{2}(2)-fftCos{2}(2);
    
    kot = atan2d(Sin,Cos);
    err(i,:) = kot -theta;
end


err(err<-180) = err(err<-180)+360;
err(err> 180) = err(err> 180)-360;

%%
fftErr = mojfft(err);

har0 = fftErr{1}(:,1).*cosd(fftErr{2}(:,1));
har1 = fftErr{1}(:,2);
har2 = fftErr{1}(:,3);
har3 = fftErr{1}(:,4);
har4 = fftErr{1}(:,5);
har5 = fftErr{1}(:,6);
har6 = fftErr{1}(:,7);
har7 = fftErr{1}(:,8);
har8 = fftErr{1}(:,9);
har9 = fftErr{1}(:,10);
har10 = fftErr{1}(:,11);

%%
% figure;
% plot(fftErr{1}(:,[1:11]))
%%
figure(primer);
plot(err')
legend(num2str(k'))
