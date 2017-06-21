
r0=1;
xd=0;
xs=0;
ys=0.1;
theta=linspace(-pi/4,pi/4,100);
Bh1=(r0+xs)*cos(theta)+ys*sin(theta)-xd;
Bh2=xs*cos(theta)+(r0+ys)*sin(theta)-xd;

dod=zeros(size(Bh1,1),size(Bh1,2));
zapp=dod;
for l=1:max(size(k))
    dod=k(l)*((Bh1.^pot(l,1)).*(Bh2.^pot(l,2)));
    zapp=zapp+dod;
end

plot(theta,zapp-osnovna_napaka-theta)
