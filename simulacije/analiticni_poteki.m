r_0=2.4;
y_s=-0.01:0.001:0.01;
% plot(y_s,atan2d(y_s,(y_s+r_0)))
% hold on
% plot(y_s,(-90/pi*r_0^2.*y_s.*(r_0^5+29*r_0^4.*y_s+132*r_0^3.*y_s.^2+208*r_0^2.*y_s.^3 ...
% +156*r_0.*y_s.^4+52.*y_s.^5))./(r_0^2+2*r_0.*y_s+2.*y_s.^2).^4);
% grid on

xs.A_0=(-90*r_0^2.*y_s.*(r_0^5+29.*r_0.^4.*y_s+132.*r_0^3.*y_s.^2+208*r_0^2.*y_s.^3 ...
+156.*r_0.*y_s.^4+52.*y_s.^5))./(pi.*(r_0^2+2.*r_0.*y_s+2.*y_s.^2).^4)+atan2d(y_s,r_0+y_s);
xs.A_1=(2280*r_0.^2.*y_s.^2.*(r_0.^4+5.*r_0.^3.*y_s+8.*r_0.^2.*y_s.^2+6.*r_0.*y_s.^3 ...
+2.*y_s.^4))./((pi.*r_0.^2+2.*r_0.*y_s+2.*y_s).^4);
xs.B_1=-(240.*y_s.^3.*(7.*r_0.^3+18.*r_0.^2.*y_s+18.*r_0.^2.*y_s+18.*r_0.*y_s.^2 ...
+8.*y_s.^3))./(pi.*(r_0.^2+2.*r_0.*y_s+2.*y_s.^2).^3);
xs.A_2=(90.*r_0.^2.*y_s.*(r_0.^5-3.*r_0.^4.*y_s-28.*r_0.^3.*y_s.^2-48.*r_0.^2.*y_s.^3 ...
-36.*r_0.*y_s.^4-12.*y_s.^5))./(pi.*(r_0.^2+2.*r_0.*y_s+2.*y_s.^2).^4);
xs.B_2=(30.*y_s.*(-3.*r_0.^5-18.*r_0.^4.*y_s-20.*r_0.^3.*y_s.^2 +12.*r_0.*y_s.^4 ...
+8.*y_s.^5))./(pi.*(r_0.^2+2.*r_0.*y_s+2.*y_s.^2).^3);

ys.A_0=-90.*y_s.*r_0.^-3.*(r_0^2-23.*r_0.*y_s-24.*y_s.^2)/pi;
ys.A_1=-16.*90.*y_s.^2.*r_0.^-3.*(r_0+y_s)/pi;
ys.A_2=90.*y_s.*r_0.^-3.*(r_0.^2+9.*r_0.*y_s+8.*y_s.^2)/pi;
ys.B_1=4*60*y_s.^3.*r_0.^-3/pi;
ys.B_2=30.*r_0.^-3/pi.*(3.*r_0.^2.*y_s-4.*y_s.^3);

xd.A_0=180/pi.*(r_0.*y_s.*(r_0.^6-7.*r_0.^5.*y_s+18.*r_0.^4.*y_s.^2-36.*r_0.^2.*y_s.^4 ...
+28.*r_0.*y_s.^5-8.*y_s.^6))./(r_0.^2-2.*r_0.*y_s+2.*y_s.^2).^4-atan2d(y_s,r_0-y_s);

xd.A_1=-((r_0.*y_s.*(r_0.^6-8.*r_0.^5.*y_s+22.*r_0.^4.*y_s.^2-44.*r_0.^2.*y_s.^4 ...
+32.*r_0.*y_s.^5-8.*y_s.^6))./(r_0.^2-2.*r_0.*y_s+2.*y_s.^2).^4)*180/pi;

xd.A_2=-((r_0.^2.*y_s.^2.* (r_0.^4-4.* r_0.^3.* y_s+8.* r_0.* y_s.^3-4 ...
    .* y_s.^4))./(r_0.^2-2.* r_0.* y_s+2.* y_s.^2).^4)*180/pi;

xd.B_1=(y_s.* (3.* r_0.^5-18.* r_0.^4.* y_s+64.* r_0.^3.* y_s.^2 -108 ...
.* r_0.^2.* y_s.^3+84.* r_0.* y_s.^4-32.* y_s.^5))./(3.* (r_0.^2-2.* r_0 ...
.* y_s+2.* y_s.^2).^3)*180/pi;

xd.B_2=(2.* y_s.^3.* (-4.* r_0.^3+9.* r_0.^2.* y_s-6.* r_0.* y_s.^2+2.* y_s...
.^3))./(3.* (r_0.^2-2.* r_0.* y_s+2.* y_s.^2).^3)*180/pi;



FigHandle=figure;
set(FigHandle, 'Position', [100, 100, 960, 720]);
%set(gca, 'ColorOrder', jet(3), 'NextPlot', 'replacechildren');

plot(y_s,xs.A_0);
hold on
plot(y_s,sqrt(xs.A_1.^2+xs.B_1.^2));
plot(y_s,sqrt(xs.A_2.^2+xs.B_2.^2));
grid on
    ylabel('amplituda harmonika napake / ^\circ')
    xlabel('ekscentricnost / mm')

legend('Enosmerna komp.','Harm 1','Harm 2','Location','NorthWest')
FigHandle=figure;
set(FigHandle, 'Position', [100, 100, 960, 720]);
%set(gca, 'ColorOrder', jet(3), 'NextPlot', 'replacechildren');
plot(y_s,ys.A_0);
hold on
plot(y_s,sqrt(ys.A_1.^2+ys.B_1.^2));
plot(y_s,sqrt(ys.A_2.^2+ys.B_2.^2));
grid on
    ylabel('amplituda harmonika napake / ^\circ')
    xlabel('ekscentricnost / mm')
legend('Enosmerna komp.','Harm 1','Harm 2','Location','NorthWest')
FigHandle=figure;
set(FigHandle, 'Position', [100, 100, 960, 720]);
%set(gca, 'ColorOrder', jet(3), 'NextPlot', 'replacechildren');
plot(y_s,xd.A_0);
hold on
plot(y_s,sqrt(xd.A_1.^2+xd.B_1.^2));
plot(y_s,sqrt(xd.A_2.^2+xd.B_2.^2));
grid on
legend('Enosmerna komp.','Harm 1','Harm 2','Location','NorthWest')
    ylabel('amplituda harmonika napake / ^\circ')
    xlabel('ekscentricnost / mm')