clear all
% priprava slike
figure(1)
clf
hold on

%definiraj ekscentricnost
xs=1+0*(rand()-0.5);
ys=0+0*(rand()-0.5);
xd=0+0*(rand()-0.5);
yd=0+0*(rand()-0.5);
% definiraj zacetni poziciji sond
zac_x=[1;0];
zac_y=[0;1];
% definiraj kote
theta=linspace(0,2*pi,6);


% narisi kje se giblje sredisce senzorja
oris_sredisca_senzorja_dinamika
Bx=zeros(size(theta));
By=zeros(size(theta));
for i=theta
%   vrednosti rotacijske matrike 
  rot_mat=[cos(i) sin(i);-sin(i) cos(i) ]; 
%   definiraj vrednosti sredisca senzorja zaradi ekscentricnosti
  srediscesta=rot_mat*[xs;ys];
  srediscedin=[xd;yd];
  sredisce_senz=srediscedin+srediscesta;

%   pozicija hallove sonde
  hallx=rot_mat*(zac_x+[xs;ys])+[xd;yd];
  hally=rot_mat*(zac_y+[xs;ys])+[xd;yd];
%   narisi na sliko 
  
  plot([sredisce_senz(1),hallx(1)],[sredisce_senz(2),hallx(2)],'-b','linewidth',2);
    
  plot([sredisce_senz(1),hally(1)],[sredisce_senz(2),hally(2)],'-r','linewidth',2);

%   zenaci osi 
  axis equal

end


