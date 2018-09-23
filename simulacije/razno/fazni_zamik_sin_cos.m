clear
theta = linspace(0,360,8192);



k = -90:5:90;
primer = 2;
Sin = zeros(length(k),length(theta));
Cos = Sin;
theta1 = Sin;

for i = 1: length(k)
    if primer == 1
        Sin(i,:) = sind(theta+k(i));
        Cos(i,:) = cosd(theta);
    elseif primer == 2
        Sin(i,:) = sind(theta);
        Cos(i,:) = cosd(theta+k(i));
    else
    end

    theta1(i,:) = theta;
end

fftSin = mojfft(Sin);
fftCos = mojfft(Cos);
faza = fftSin{2}(:,2)-fftCos{2}(:,2);kot = atan2d(Sin,Cos);
err = kot -theta1;
err(err<-180) = err(err<-180)+360;
err(err> 180) = err(err> 180)-360;



%%
fftErr = mojfft(err);

har0 = fftErr{1}(:,1).*cosd(fftErr{2}(:,1));
har1 = fftErr{1}(:,2);
har1(k<0) = -har1(k<0);

har2 = fftErr{1}(:,3);
har2(k<0) = -har2(k<0);

har3 = fftErr{1}(:,4);
har3(k<0) = -har3(k<0);
har4 = fftErr{1}(:,5);
har4(k<0) = -har4(k<0);
har5 = fftErr{1}(:,6);
har5(k<0) = -har5(k<0);
har6 = fftErr{1}(:,7);
har6(k<0) = -har6(k<0);
har7 = fftErr{1}(:,8);
har7(k<0) = -har7(k<0);
har8 = fftErr{1}(:,9);
har8(k<0) = -har8(k<0);
har9 = fftErr{1}(:,10);
har9(k<0) = -har9(k<0);
har10 = fftErr{1}(:,11);
har10(k<0) = -har10(k<0);

%%
figure;
plot(k,har0,k,har1,k,har2,k,har3,k,har4, 'Linewidth',3)%,k,har3,k,har4,k,har5,k,har6,k,har7,k,har8, ...
     %k,har9,k,har10)
grid on
set(gca,'FontSize',22);
xlabel('$\mathrm{\varphi_{sin}/^\circ}$','Interpreter','latex','FontSize', 28)
ylabel('amplituda harmonika napake$/^\circ$','Interpreter','latex','FontSize', 28)
legend('Enosmerna komponenta', '1 harmonik', '2 harmonik','3 harmonik', '4 harmonik', 'Location','NorthWest')
%%
figure(primer);
subplot(2,2,2)
plot(theta1',err')
legend(num2str(k'))

subplot(2,2,4)
plot(Cos',Sin')
legend(num2str(k'))

subplot(2,2,[1,3])
plot(theta1',Cos',theta1',Sin')
legend(num2str(k'))

