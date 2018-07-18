eks='ys';
mer='lin';


eval(strcat('mer_uporabljena=',mer,'_',eks,';'));


narisi=find(mer_uporabljena.displacement==0|mer_uporabljena.displacement==max(...
    mer_uporabljena.displacement)|...
mer_uporabljena.displacement==abs(min(abs(...
    max(mer_uporabljena.displacement)/2 - mer_uporabljena.displacement))+max(mer_uporabljena.displacement)/2)|...
    mer_uporabljena.displacement==abs(min(abs(...
    max(mer_uporabljena.displacement)/2 - mer_uporabljena.displacement))-max(mer_uporabljena.displacement)/2));

 scrsz = get(0,'ScreenSize');
%%
figure('Position',[1930 scrsz(4)-30-80-950 1800 950]);
NameArray = {'LineStyle'};
ValueArray = {'-','--',':'}';

subplot(2,2,[1,3]);
p1 = plot(mer_uporabljena.cos(narisi,:)');
set(p1,NameArray,ValueArray);
hold on
p2=plot(mer_uporabljena.sin(narisi,:)');
grid on
set(p2,NameArray,ValueArray);
title(mer);



%%
subplot(2,2,2)

p3=plot(mer_uporabljena.protocol(narisi,:)');
grid on
set(p3,NameArray,ValueArray)

subplot(2,2,4)
p4=plot(mer_uporabljena.cos(narisi,:)',mer_uporabljena.sin(narisi,:)');
grid on
hold on
axis equal
set(p4,NameArray,ValueArray)
crtax=[zeros(1,size(mer_uporabljena.cos(narisi,:),1)); mer_uporabljena.cos(narisi,1)'];
crtax=crtax(:);

crtay=[zeros(1,size(mer_uporabljena.sin(narisi,:),1)); mer_uporabljena.sin(narisi,1)'];
crtay=crtay(:);

plot(crtax,crtay,'k');
plot(crtax,crtay,'*r');
axis equal


%saveas(gcf,strcat(mer,'.png'))









