clear all
close all
theta=linspace(-0.3,0.3,1000);

st1=ones(size(theta));
st2=theta;
st3=sin(theta);
st4=cos(theta);
st5=sin(2*theta);
st6=cos(2*theta);
st7=sin(3*theta);
st8=cos(3*theta);

A=[st1; st2; st3; st4; st5; st6; st7; st8]';
% A=[st1; st3; st4; st5; st6; st7; st8]';



%definiraj ekscentricnost
xs=0.0+0*(rand()-0.5);
ys=0.0+0*(rand()-0.5);
xd=0.1+0*(rand()-0.5);
yd=-0.0+0*(rand()-0.5);
% definiraj zacetni poziciji sond
zac_x=[1;0];
zac_y=[0;1];


Bx=zeros(size(theta));
By=zeros(size(theta));
stevec=1;
for i=theta
%   vrednosti rotacijske matrike 
  rot_mat=[cos(i) sin(i);-sin(i) cos(i) ]; 


%   pozicija hallove sonde
  hallx=rot_mat*(zac_x+[xs;ys])-[xd;yd];
  hally=rot_mat*(zac_y+[xs;ys])-[xd;yd];

% shrani vrednost polja Bz

Bx(stevec)=hallx(1);
By(stevec)=hally(1);

stevec=stevec+1;
end

%naredi taylor vrsto
za_serijo=By./Bx;
prvi=find(za_serijo>-0.05,1);
drugi=find(za_serijo>0.05,1);
za_serijo2=za_serijo(prvi:drugi);
teylor_vrsta=za_serijo2-za_serijo2.^3/3;
y=teylor_vrsta';
pravikot=atan2(By,Bx);
popravikot=pravikot(prvi:drugi);
popravikot=popravikot';
figure('Name','Potek kota teylor in atan2')

plot(theta(prvi:drugi),y, theta(prvi:drugi),atan2(By(prvi:drugi),Bx(prvi:drugi)))


figure('Name','Razlika med teylorjevo vrsto in atan2 kota')
plot(theta(prvi:drugi),y-popravikot)
grid on
A2=A(prvi:drugi,:);
x=A2\y;


theta=linspace(-pi,pi,1000);

st1=ones(size(theta));
st2=theta;
st3=sin(theta);
st4=cos(theta);
st5=sin(2*theta);
st6=cos(2*theta);
st7=sin(3*theta);
st8=cos(3*theta);

A=[st1; st2; st3; st4; st5; st6; st7; st8]';
% A=[st1; st3; st4; st5; st6; st7; st8]';


approx=A*x;


figure('Name','napaka med aproksimacijo s metodo lin kvadratov in pravim kotom')
plot(theta,approx'-theta)
grid on

