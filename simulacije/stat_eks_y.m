clear
theta = linspace(0,2*pi,8192);

x = 0.1;

ysKot= atan2(sin(theta)+x*sin(theta),cos(theta)+x*sin(theta));
ref = atan2(sin(theta),cos(theta));

ysErr = ysKot-ref;
ysErr(ysErr<-pi)=ysErr(ysErr<-pi)+2*pi;
ysErr(ysErr>pi)=ysErr(ysErr>pi)-2*pi;

pred = zeros(size(theta))-atan(x/(x+2));
    
for n = 1:15
        
    pred= pred + 1/n .* (x/sqrt(x.^2+2*x+2)).^n.* ...
        sin(2*n*theta +n*(pi/2 - atan(x+1)));
    
end

scrsz = get(0,'ScreenSize');
figure('Position', ...
       [10 scrsz(4)-10-80-600 800 600]);
axes1 = axes('Parent',gcf,...
        'YGrid','on',...
        'XGrid','on',...
        'FontSize',16,...
        'FontName','Times New Roman');
plot(theta*180/pi,ysErr*180/pi,'LineWidth',2);
axis( [0,360,-Inf,Inf])
grid on
xlabel('\theta / ^\circ')
ylabel('\epsilon  / ^\circ')



figure('Position', ...
       [10 scrsz(4)-10-80-600 800 600]);
axes1 = axes('Parent',gcf,...
        'YGrid','on',...
        'XGrid','on',...
        'FontSize',16,...
        'FontName','Times New Roman');
plot(theta*180/pi,(ysErr-pred)*180/pi,'LineWidth',2);
axis( [0,360,-Inf,Inf])
grid on
xlabel('\theta / ^\circ')
ylabel('\epsilon-\epsilon_p  / ^\circ')