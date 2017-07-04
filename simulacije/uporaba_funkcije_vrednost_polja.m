 close all
 clear all
theta=linspace(-pi,pi,1024);
r0=2.4;
xs=0.0;
ys=0.0;
xd=0.00;
yd=0;

koliko_harmonikov=4;
zacetek=1.2;
konec=2.2;
potek=linspace(zacetek,konec,3000);
amp=zeros(max(size(potek)),koliko_harmonikov+1);
ampcos=amp;
ampsin=amp;
stevec=1;


po_kateri_eks='xd';

for i=potek
eval(strcat(po_kateri_eks,'=',num2str(i),';'))


[kot_merjeni,absA,kotA,Bx,By,absSin,absCos]=vrednost_polja(theta,r0,xs,ys,xd,yd,koliko_harmonikov,0);


amp(stevec,:)=absA';
ampcos(stevec,:)=absCos';
ampsin(stevec,:)=absSin';

stevec=stevec+1;

end;


if zacetek < 0
spremeni_predznak=find(potek>=0,1);
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

end



% figure
% hold on
% for i=1:koliko_harmonikov+1
%     
%     plot(potek,ampcos(:,i))
%     
%     
% end
% grid on
% 
% figure
% hold on
% for i=1:koliko_harmonikov+1
%     
%     plot(potek,ampsin(:,i))
%     
%     
% end
% grid on

switch po_kateri_eks
    case 'xs'
        izrisi_harmonike=[0 2];
        legenda={'A_0','A_2'};
    case 'ys'
        izrisi_harmonike=[0 2];
        legenda={'A_0','A_2'};
    case 'xd'
        izrisi_harmonike=[1 2];
        legenda={'A_1','A_2'};
    case 'yd'
        izrisi_harmonike=1;
        legenda={'A_1'};
end

Barve;
eval(strcat('barve=Barva',num2str(max(size(izrisi_harmonike))),';' ))
clear Barva1 Barva2 Barva3 Barva4 Barva5 Barva6 Barva7 Barva8 Barva9 Barva10 Barva11 Barva12;

figure
hold on
stevec=1;
for i=izrisi_harmonike
plot(potek,amp(:,i+1),'Color',cell2mat(barve(stevec))./255)

eval(strcat('amp_harmonik_',num2str(stevec),'=amp(:,',num2str(i+1),');'))

tmp=fit(potek',amp(:,i+1),'poly3');

tmpsin=fit(potek',ampsin(:,i+1),'poly3');
tmpcos=fit(potek',ampcos(:,i+1),'poly3');
eval(strcat('polinom_harmonika_',num2str(i),'=tmp;'));
eval(strcat('polinom_harmonika_sin',num2str(i),'=tmpsin;'));
eval(strcat('polinom_harmonika_cos',num2str(i),'=tmpcos;'));

stevec=stevec+1;
end
legend(legenda);


