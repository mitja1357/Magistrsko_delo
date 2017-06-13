kot=-pi:0.01:pi;
amp1=0.1;
amp2=0.3;
faza1=0.3;
faza2=0;
fun1=amp1*sin(kot+faza1);
fun2=amp2*cos(kot+faza2);

fun12=fun1+fun2;
faza12=atan2(amp2,amp1);
amp12=sqrt(amp1^2+amp2^2);
afun12=amp12*sin(kot+faza12);

figure
plot(kot,fun1,kot,fun2)


r0=1;
xs=0.1;
ys=0.1;



amp1=sqrt((r0^2+xs^2+ys^2+2*r0*ys)/(r0^2+xs^2+ys^2+2*r0*xs));
kotmerjeni=atan2(cos(kot-atan2(r0+xs,ys)),amp1*sin(kot+atan2(r0+ys,xs)));


atan
a=0.1;
stevec=1;
% for a=0:0.01:0.9
merjeni=atan2(sin(kot)-a,cos(kot)-a);
for i=2:max(size(merjeni))
    if merjeni(i)-merjeni(i-1)>pi
        merjeni(i)=merjeni(i)-2*pi;
    end
    if merjeni(i)-merjeni(i-1)<-pi
        merjeni(i)=merjeni(i)+2*pi;
    end    
    
end
maxpog(stevec)=max(kot-merjeni);
stevec=stevec+1;
% end
plot(0:0.01:0.9,maxpog)

figure('Name',strcat('xd=',num2str(a)));
plot(kot,merjeni)

fftprot=abs(fft(kot-merjeni));
figure
bar(fftprot);






xd=0.1;
r0=1;
theta=-0.6:0.01:0.6;
x=(r0*sin(theta)-xd)./(r0*cos(theta)-xd);
x=x-x.^3/3;
% kajdobim=(2*xd^3-6*r0*xd^2*cos(theta)+3*r0^2*xd*(cos(2*theta)+sin(2*theta))-r0^3*sin(3*theta))./(3*(xd-r0*cos(theta)).^3);
figure
plot(theta,x-theta)
grid on