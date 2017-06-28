 close all
 clear all
theta=linspace(-pi,pi,1024);
r0=2.4;
xs=0.0;
ys=0.0;
xd=0.00;
yd=0;

koliko_harmonikov=2;
zacetek=-2;
konec=10;
korak=0.25;

amp=zeros((konec-zacetek)/korak,koliko_harmonikov+1);
ampcos=amp;
ampsin=amp;
stevec=1;
potek=zacetek:korak:konec;
for xs=potek
[kot_merjeni,absA,kotA,Bx,By,absSin,absCos]=vrednost_polja(theta,r0,xs,ys,xd,yd,koliko_harmonikov,0);


amp(stevec,:)=absA';
ampcos(stevec,:)=absCos';
ampsin(stevec,:)=absSin';

stevec=stevec+1;

end

spremeni_predznak=find(zacetek:korak:konec>=0,1);
amp(1:spremeni_predznak,3)=-amp(1:spremeni_predznak,3);


% figure
% bar(0:koliko_harmonikov,kotA)

x1=potek(spremeni_predznak-1);
x2=potek(spremeni_predznak);
x3=potek(spremeni_predznak+1);

y1=amp(spremeni_predznak-1,:);
y2=amp(spremeni_predznak,:);
y3=amp(spremeni_predznak+1,:);

k1=sign((y2-y1)./(x2-x1));
k2=sign((y3-y2)./(x3-x2));
predznak=double(k1==k2);
for i=1:koliko_harmonikov+1
    if predznak(i)==0
        predznak(i)=-1;
    end
end
% for i=1:koliko_harmonikov+1
%       amp(1:spremeni_predznak,i)=amp(1:spremeni_predznak,i).*predznak(i);
% end
% 





figure
hold on
for i=1:koliko_harmonikov+1
    
    plot(zacetek:korak:konec,ampcos(:,i))
    
    
end
grid on

figure
hold on
for i=1:koliko_harmonikov+1
    
    plot(zacetek:korak:konec,ampsin(:,i))
    
    
end
grid on


figure
hold on
plot(zacetek:korak:konec,amp(:,1),'-b')
plot(zacetek:korak:konec,amp(:,3),'-r')
