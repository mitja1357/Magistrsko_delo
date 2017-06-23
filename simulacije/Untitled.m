
%{ 
povprecje tisocih random fitov
k1 = -2.09670779884785*10^-05;
k2 = 11.6207993536692;
k3 = 6.06293148750566*10^-06;
k4 = -0.000229851193152597;
k5 = -17.1810998900258;
k6 = -4.34855920378069*10^-05;
k7 = 0.0813703977054933;
k8 = 0.000127308318127276;
k9 = 7.42507292390418;
k10 = 2.73222469343121*10^-05;
%}



k1 = -1.003664013127360 *10^-2;
k2 = 2.194720476205664* 10^+0;
k3 = 3.622177244599267 *10^-4;
k4 = 4.306784511138259* 10^-2;
k5 = -4.712794643730906* 10^+0;
k6 = 1.293228142971838* 10^-2;
k7 = -6.928742017897364* 10^-1;
k8 = -3.105948102428563* 10^-2;
k9 = 3.635396623498841* 10^+0;
k10 = -5.577595543405037 * 10^-3;


xs=0.0;
ys=0.0;
xd=0.0;
r0=1;
theta=linspace(-pi/4,pi/4,1000);

Y = xs *cos(theta) + (r0 + ys)*sin(theta) - xd;
X = (r0 + xs)* cos(theta) + ys* sin(theta) - xd;
arctgbrez = k1*X.^3 + k2*X.^2 .*Y + k3* X.^2 + k4*X.*Y.^2 + k5*X.*Y + k6*X + k7*Y.^3 + k8*Y.^2 + k9*Y + k10;
figure('Name','brez','numbertitle','off');
plot(theta,arctgbrez)
grid on
xlabel('\theta /rad')
ylabel('')


%arctgbrez=0;

xs=0.1;
ys=0.0;
xd=0.0;
r0=1;
theta=linspace(-pi/4,pi/4,1000);

Y = xs *cos(theta) + (r0 + ys)*sin(theta) - xd;
X = (r0 + xs)* cos(theta) + ys* sin(theta) - xd;
arctg = k1*X.^3 + k2*X.^2 .*Y + k3* X.^2 + k4*X.*Y.^2 + k5*X.*Y + k6*X + k7*Y.^3 + k8*Y.^2 + k9*Y + k10;
figure('Name','xs','numbertitle','off');
plot(theta,(arctg-sin(theta)-arctgbrez)*180/pi)




xs=0.0;
ys=0.1;
xd=0.0;
r0=1;
theta=linspace(-pi/4,pi/4,1000);

Y = xs *cos(theta) + (r0 + ys)*sin(theta) - xd;
X = (r0 + xs)* cos(theta) + ys* sin(theta) - xd;
arctg = k1*X.^3 + k2*X.^2 .*Y + k3* X.^2 + k4*X.*Y.^2 + k5*X.*Y + k6*X + k7*Y.^3 + k8*Y.^2 + k9*Y + k10;
figure('Name','ys','numbertitle','off');
plot(theta,(arctg-sin(theta)-arctgbrez)*180/pi)




xs=0.0;
ys=0.0;
xd=0.1;
r0=1;
theta=linspace(-pi/4,pi/4,1000);

Y = xs *cos(theta) + (r0 + ys)*sin(theta) - xd;
X = (r0 + xs)* cos(theta) + ys* sin(theta) - xd;
arctg = k1*X.^3 + k2*X.^2 .*Y + k3* X.^2 + k4*X.*Y.^2 + k5*X.*Y + k6*X + k7*Y.^3 + k8*Y.^2 + k9*Y + k10;
figure('Name','xd','numbertitle','off');
plot(theta,(arctg-sin(theta)-arctgbrez)*180/pi)





