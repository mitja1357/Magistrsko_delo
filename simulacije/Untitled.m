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

close all
k1= -9.096261296524362e-04;
k2= 1.563390717760689e-01;
k3= 5.510294165871715e-03;
k4= 2.826155249085411e-03;
k5= -8.112831025380142e-01;
k6= -1.103377090795027e-02;
k7= -4.901114339562490e-02;
k8= -5.462208655918772e-03;
k9= 1.509736176781744e+00;
k10= 7.988321379653943e-03;

k1=-2.889794474058519e-03;
k2=-1.208588285296162e-03;
k3=2.201958629842505e-02;
k4=6.485109124883191e-04;
k5=-1.438489270702308e-01;
k6=-5.606362926467791e-02;
k7=-2.113643897117244e-02;
k8=-1.498834589367169e-03;
k9=7.690082703437420e-01;
k10=4.765072206264760e-02;

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

%}


k1 =-6.306319442659312e-4;
k2 =-1.640168709495793e-3;
k3 = 3.962017072440235e-3;
k4 =-2.887048260782111e-4;
k5 =-1.412276545356571e-1;
k6 =-7.931822230064153e-3;
k7 =-2.104555700820865e-2;
k8 = 6.238774627110503e-4;
k9 = 7.651613620676274e-1;
k10 =4.980440898351878e-3;

eks=0.1;
xs=0.0;
ys=0.0;
xd=0.0;
r0=2.4;
theta=linspace(-pi/4,pi/4,1000);

Y = xs *cos(theta) + (r0 + ys)*sin(theta) - xd;
X = (r0 + xs)* cos(theta) + ys* sin(theta) - xd;
arctgbrez = k1*X.^3 + k2*X.^2 .*Y + k3* X.^2 + k4*X.*Y.^2 + k5*X.*Y + k6*X + k7*Y.^3 + k8*Y.^2 + k9*Y + k10;
figure('Name','brez','numbertitle','off');
plot((theta)*180/pi,(arctgbrez-theta)*180/pi)
grid on
xlabel('\theta /rad')
ylabel('')


%arctgbrez=0;

xs=eks;
ys=0.0;
xd=0.0;
theta=linspace(-pi/4,pi/4,1000);

Y = xs *cos(theta) + (r0 + ys)*sin(theta) - xd;
X = (r0 + xs)* cos(theta) + ys* sin(theta) - xd;
arctg = k1*X.^3 + k2*X.^2 .*Y + k3* X.^2 + k4*X.*Y.^2 + k5*X.*Y + k6*X + k7*Y.^3 + k8*Y.^2 + k9*Y + k10;
figure('Name','xs','numbertitle','off');
plot(theta*180/pi,(arctg-theta)*180/pi)
grid on



xs=0.0;
ys=eks;
xd=0.0;
theta=linspace(-pi/4,pi/4,1000);

Y = xs *cos(theta) + (r0 + ys)*sin(theta) - xd;
X = (r0 + xs)* cos(theta) + ys* sin(theta) - xd;
arctg = k1*X.^3 + k2*X.^2 .*Y + k3* X.^2 + k4*X.*Y.^2 + k5*X.*Y + k6*X + k7*Y.^3 + k8*Y.^2 + k9*Y + k10;
figure('Name','ys','numbertitle','off');
plot(theta*180/pi,(arctg-theta)*180/pi)
grid on



xs=0.0;
ys=0.0;
xd=eks;
theta=linspace(-pi/4,pi/4,1000);

Y = xs *cos(theta) + (r0 + ys)*sin(theta) - xd;
X = (r0 + xs)* cos(theta) + ys* sin(theta) - xd;
arctg = k1*X.^3 + k2*X.^2 .*Y + k3* X.^2 + k4*X.*Y.^2 + k5*X.*Y + k6*X + k7*Y.^3 + k8*Y.^2 + k9*Y + k10;
figure('Name','xd','numbertitle','off');
plot(theta*180/pi,(arctg-theta)*180/pi)
grid on




