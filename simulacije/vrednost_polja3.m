clear all
%definiraj ekscentricnost
xs=0+0*(rand()-0.5);
ys=0+0*(rand()-0.5);
xd=1+0*(rand()-0.5);
yd=0+0*(rand()-0.5);
% definiraj zacetni poziciji sond
zac_x=[1;0];
zac_y=[0;1];
% definiraj kote
theta=linspace(0,2*pi,1000);
% priprava slike
figure(2)
clf
hold on


Bx=zeros(size(theta));
By=zeros(size(theta));
stevec=1;
for i=theta
%   vrednosti rotacijske matrike 
  rot_mat=[cos(i) sin(i);-sin(i) cos(i) ]; 


%   pozicija hallove sonde
  hallx=rot_mat*(zac_x+[xd;yd])+[xs;ys];
  hally=rot_mat*(zac_y+[xd;yd])+[xs;ys];

% shrani vrednost polja Bz

Bx(stevec)=hallx(1);
By(stevec)=hally(1);

stevec=stevec+1;
end


kotmerjeni=atan2(Bx,By);

figure(2)

plot(theta,Bx,'-b',theta,By,'-r')
grid on
legend('B_x','B_y')

