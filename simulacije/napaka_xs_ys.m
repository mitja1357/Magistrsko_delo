clear
ds1 = -0.9:0.01:1;
dc1 = -0.9:0.01:1;

n = 128;
theta = linspace(0,360-360/n,n);
ref = atan2d(sind(theta),cosd(theta));

for i = 1:length(ds1)
    for j = 1:length(dc1)
        
        ds = ds1(i);
        dc = dc1(j);

Sin = sqrt((1+ds)^2+dc^2).*cosd(theta - atand((1+ds)/dc));
Cos = sqrt((1+dc)^2+ds^2).*cosd(theta - atand(ds/(1+dc)));

kot = atan2d(Sin,Cos);
err = kot - ref;
err(err>180) = err(err>180)-360;
err(err<-180) = err(err<-180)+360;

fftErr = mojfft(err);

off(i,j) =  fftErr{1}(1).*cosd(fftErr{2}(1));
har2(i,j) =  fftErr{1}(3);
faz2(i,j) =  fftErr{2}(3);
har4(i,j) =  fftErr{1}(5);
faz4(i,j) =  fftErr{2}(5);
    end
end
r = sqrt(ds1.^2+dc1.^2);
fi = -atan(ds1./dc1);

clear i j err ref kot ds dc n theta fftErr Sin Cos

a2 = har2.*cosd(faz2);
b2 = har2.*sind(faz2);
a4 = har4.*cosd(faz4);
b4 = har4.*sind(faz4);

[rg,fg]=meshgrid(r,fi);
[Sg,Cg]=meshgrid(dc1,ds1);

tanFaz2 = tand(faz2);
tanFaz4 = tand(faz4/2);

%%
clear x r radij kot tmp k p0 p1
x = 0:1:90;
r = 0.02:1e-2:1;
for radij = 1:length(r)
    for kot = 1:length(x)
        tmp(kot)=interp2(Sg,Cg,tanFaz2,r(radij)*cosd(x(kot)),r(radij)*sind(x(kot)));
    end
    k = polyfit(x,tmp,1);
    
    p0(radij) = k(2);
    p1(radij) = k(1);
end


%%
ft = 2*tand(45-x);

figure(1)
plot(x,T10,x,ft)


%%
f = (1+sqrt(Sg.^2+Cg.^2)).*tand(-45+atand(Sg./Cg));
figure; mesh(Sg,Cg,atand(f)-faz2)
%%
x1 = 0.1:0.1:1;
p1 = [47.8 50.3 52.55 54.58 56.42 58.09 59.62 61.01 62.3 63.48];
p0 = -[1.062 1.118 1.168 1.213 1.254 1.291 1.325 1.356 1.384 1.411];





    