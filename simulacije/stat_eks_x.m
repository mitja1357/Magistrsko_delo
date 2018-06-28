clear
theta = linspace(0,2*pi,8192);

x = 0.1;

xsKot= atan2(sin(theta)+x*cos(theta),cos(theta)+x*cos(theta));
ref = atan2(sin(theta),cos(theta));

xsErr = xsKot-ref;
xsErr(xsErr<-pi)=xsErr(xsErr<-pi)+2*pi;
xsErr(xsErr>pi)=xsErr(xsErr>pi)-2*pi;

pred = zeros(size(theta))+atan(x/(x+2));
    
for n = 1:15
        
    pred= pred + 1/n .* (x/sqrt(x.^2+2*x+2)).^n.* ...
        sin(2*n*theta +n*(pi/2 + atan(x+1)));
    
end

figure(1)
plot(theta',xsErr'-pred')
grid on

