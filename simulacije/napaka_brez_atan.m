xs=struct();
yss=struct();
yd=struct();
r0=2.4;
ys=-0.1:0.001:0.1;

xs.A0=-(ys.*(r0.^2 - 23.*r0.*ys - 24.*ys.^2))./(2.*r0.^3);

xs.A1=(-16.*ys.^2.*(r0 + ys))./r0.^3;

xs.A2=(ys.*(r0.^2 + 9.*r0.*ys + 8.*ys.^2))./(2.*r0.^3);

xs.B1=(4.*ys.^3)./(3.*r0.^3);

xs.B2=(3.*r0.^2.*ys - 4.*ys.^3)./(6.*r0.^3);



yss.A0 =-(r0.^2.*ys.*(r0.^5 + 29.*r0.^4.*ys + 132.*r0.^3.*ys.^2 + 208.*r0.^2.*ys.^3 + 156.*r0.*ys.^4 + 52.*ys.^5))./(2.*(r0.^2 ...
+ 2.*r0.*ys + 2.*ys.^2).^4) + atan(ys./(r0 + ys));

yss.A1=(16.*r0.^2.*ys.^2.*(r0.^4 + 5.*r0.^3.*ys + 8.*r0.^2.*ys.^2 + 6.*r0.*ys.^3 + 2.*ys.^4))./(r0.^2 + 2.*r0.*ys + 2.*ys.^2).^4;

yss.A2 = (r0.^2.*ys.*(r0.^5 - 3.*r0.^4.*ys - 28.*r0.^3.*ys.^2 - 48.*r0.^2.*ys.^3 - 36.*r0.*ys.^4 - 12.*ys.^5))./(2.*(r0.^2 ...
+ 2.*r0.*ys + 2.*ys.^2).^4);

yss.B1=(-4.*ys.^3.*(7.*r0.^3 + 18.*r0.^2.*ys + 18.*r0.*ys.^2 + 8.*ys.^3))./(3.*(r0.^2 + 2.*r0.*ys + 2.*ys.^2).^3);

yss.B2=(ys.*(-3.*r0.^5 - 18.*r0.^4.*ys - 20.*r0.^3.*ys.^2 + 12.*r0.*ys.^4 + 8.*ys.^5))./(6.*(r0.^2 + 2.*r0.*ys + 2.*ys.^2).^3);



yd.A0=(r0.*ys.*(r0.^6 - 7.*r0.^5.*ys + 18.*r0.^4.*ys.^2 - 36.*r0.^2.*ys.^4 + 28.*r0.*ys.^5 - 8.*ys.^6))./(r0.^2 ...
- 2.*r0.*ys + 2.*ys.^2).^4 - atan(ys./(r0 - ys));

yd.A1=-((r0.*ys.*(r0.^6 - 8.*r0.^5.*ys + 22.*r0.^4.*ys.^2 - 44.*r0.^2.*ys.^4 + 32.*r0.*ys.^5 - 8.*ys.^6))./(r0.^2 ...
- 2.*r0.*ys + 2.*ys.^2).^4);

yd.A2=-((r0.^2.*ys.^2.*(r0.^4 - 4.*r0.^3.*ys + 8.*r0.*ys.^3 - 4.*ys.^4))./(r0.^2 - 2.*r0.*ys + 2.*ys.^2).^4);

yd.B1=(ys.*(3.*r0.^5 - 18.*r0.^4.*ys + 64.*r0.^3.*ys.^2 - 108.*r0.^2.*ys.^3 + 84.*r0.*ys.^4 - 32.*ys.^5))./(3.*(r0.^2 ...
- 2.*r0.*ys + 2.*ys.^2).^3);

yd.B2=(2.*ys.^3.*(-4.*r0.^3 + 9.*r0.^2.*ys - 6.*r0.*ys.^2 + 2.*ys.^3))./(3.*(r0.^2 - 2.*r0.*ys + 2.*ys.^2).^3);

figure
plot(ys,180/pi.*xs.A0)
hold on
plot(ys,180/pi.*sqrt(xs.B1.^2+xs.A1.^2))
plot(ys,180/pi.*sqrt(xs.B2.^2+xs.A2.^2))
legend('Enos.','Harm. 1', 'Harm. 2')
xlabel('ekscentri?nost / mm')
ylabel('amplituda posameznega harmonika / ^\circ')
grid on




figure
plot(ys,180/pi.*yss.A0)
hold on
plot(ys,180/pi.*sqrt(yss.B1.^2+yss.A1.^2))
plot(ys,180/pi.*sqrt(yss.B2.^2+yss.A2.^2))
legend('Enos.','Harm. 1', 'Harm. 2')
xlabel('ekscentri?nost / mm')
ylabel('amplituda posameznega harmonika / ^\circ')
grid on

figure
plot(ys,180/pi.*yd.A0)
hold on
plot(ys,180/pi.*sqrt(yd.B1.^2+yd.A1.^2))
plot(ys,180/pi.*sqrt(yd.B2.^2+yd.A2.^2))
legend('Enos.','Harm. 1', 'Harm. 2')
xlabel('ekscentri?nost / mm')
ylabel('amplituda posameznega harmonika / ^\circ')
grid on




