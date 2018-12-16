clear
dc = 0:0.05:2;

n = 8192*4;
theta = linspace(0,360-360/n,n);


for i = 1:length(dc)
    t1(i,:)=theta;
%     Sin(i,:) = sind(theta)+dc(i).*cosd(theta);
%     Cos(i,:) = cosd(theta)+dc(i).*cosd(theta);
end

Sin = sind(t1)+dc'*cosd(theta);
Cos = cosd(t1)+dc'*cosd(theta);

err = atan2d(Sin,Cos) - atan2d(sind(t1),cosd(t1));

err(err < -180) = err(err < -180) +360;
err(err >  180) = err(err >  180) -360;

fftErr = mojfft(err);

c2 = fftErr{1}(:,3);
a2 = c2.*cosd(fftErr{2}(:,3));
b2 = c2.*sind(fftErr{2}(:,3));
c0 = fftErr{1}(:,1);
clear n theta i t1 Sin Cos err

%%
scrsz = get(0,'ScreenSize');
figure('Position', ...
       [10 scrsz(4)-10-80-600 800 600]);
axes1 = axes('Parent',gcf,...
        'YGrid','on',...
        'XGrid','on',...
        'FontSize',16,...
        'FontName','Times New Roman');
plot(dc,c0, 'LineWidth',2, 'Color', [215,25,28]/255);
hold on
plot(dc, a2, 'LineWidth',2, 'Color', [253,174,97]/255);
plot(dc, b2, 'LineWidth',2, 'Color', [44,123,182]/255);

legend('C_{0}','C_{2c}', 'C_{2s}', 'Location','northwest')
grid on
xlabel('$\Delta_c$','interpreter', 'latex')
ylabel('$\varepsilon / ^\circ$','interpreter', 'latex')
% xlabel('$\theta$','interpreter', 'latex')
% ylabel('$/ ^\circ$','interpreter', 'latex')
% axis([0,360,-Inf,Inf])