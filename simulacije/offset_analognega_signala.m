clear
theta = linspace(0,2*pi,4096);

x1 = [-50:0.01:-1.01,...
    linspace(-1.01,-0.99,1000),...
    -0.99:0.01:0.99,...
    linspace(0.99,1.01,1000),...
    1.01:0.01:50];
x = x1;
% x = x1(x1>=0);

Sin = sin(theta);
Cos = cos(theta);
y = zeros(size(x));

for i = 1:length(x)
    err =atan2(Sin+x(i),Cos)-theta;
    err(err<-pi) = err(err<-pi)+2*pi;
    err(err> pi) = err(err> pi)-2*pi;
    y(i)=mean(err);
end
clear theta Sin Cos err i x1
%%

a = -0.00008;
b = 2;
f = -0.0005.*atan((x./(-1+x.^2))).*(-1+x.^2)./(1+x.^4);
figure(1)
plot(x,y,x,f,'r')
% axis([-2,2,-2e-4,2e-4])


%%
r_0=1
y_s = x;
analitika=180/pi.*(r_0.*y_s.*(r_0.^6-7.*r_0.^5.*y_s+18.*r_0.^4.*y_s ...
    .^2-36.*r_0.^2.*y_s.^4+28.*r_0.*y_s.^5-8.*y_s.^6))./(r_0.^2-2.*r_0.*y_s ...
    +2.*y_s.^2).^4-atan2d(y_s,r_0-y_s);
plot(x,analitika)