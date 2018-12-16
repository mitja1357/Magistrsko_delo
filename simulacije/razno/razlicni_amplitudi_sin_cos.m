clear
theta = linspace(0,360-360/8192,8192);
Sin = sind(theta);
Cos = cosd(theta);

k = 0:1e-2:10;

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
har2(k<1) = -har2(k<1);
% har4(k>1) = -har4(k>1);
%%
scrsz = get(0,'ScreenSize');
figure('Position', ...
       [10 scrsz(4)-10-80-600 800 400]);
axes1 = axes('Parent',gcf,...
        'YGrid','on',...
        'XGrid','on',...
        'FontSize',16,...
        'FontName','Times New Roman');
plot(k,har2, 'LineWidth',2, 'Color', [215,25,28]/255);


legend('C_{2}', 'Location','northwest')
grid on
xlabel('$k$','interpreter', 'latex')
ylabel('$\varepsilon / ^\circ$','interpreter', 'latex')

