clear
close all

k = 1.1;
sin_off = 0000000000000000.0;
cos_off = 0000000000000000.0;
sin_f = -0*pi/180;
cos_f = 1*pi/180;

theta = linspace(0,2*pi,4096);

kot = atan2(k*sin(theta+sin_f)+sin_off,cos(theta+cos_f)+cos_off)-atan2(sin(theta),cos(theta));
kot(kot>pi) = kot(kot>pi)-2*pi;
kot(kot<-pi) = kot(kot<-pi)+2*pi;
err = (sin_f+cos_f)/2 *ones(size(theta));
for n = 1:20
    err = err + 1/n *((k-1)/(k+1))^n*sin(2*n*theta)+ ...
        1/n*sin_off^n*sin(n*theta+n*pi/2)+ ...
        1/n*cos_off^n*sin(n*theta+n*pi)+ ...
        1/n*tan(sin_f/2)^n*sin(2*n*theta+n*pi/2+n*sin_f)+ ...
        1/n*tan(cos_f/2)^n*sin(2*n*theta-n*pi/2+n*cos_f);
end
% for n = 1:20
%     err = err + ...
%         1/n*(sqrt(2)*cos_off)^n*sin(n*theta+n*3*pi/4);
% end



scrsz = get(0,'ScreenSize');
figure('Position', ...
       [10 scrsz(4)-10-80-600 800 600]);
    axes1 = axes('Parent',gcf,...
        'YGrid','on',...
        'XGrid','on',...
        'FontSize',16,...
        'FontName','Times New Roman');

    
    
    plot(theta*180/pi,kot*180/pi);
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

    
    
    plot(theta*180/pi,(kot-err)*180/pi);
    axis( [0,360,-Inf,Inf])
    grid on
    xlabel('\theta / ^\circ')
    ylabel('\epsilon - \epsilon_{p}  / ^\circ')
    
    
    
    
    
    
