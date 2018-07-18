
eks='xd';

eval(strcat('meritev=meritev_',eks,';'))


novi_sin=zeros(size(meritev.sin));
novi_cos=zeros(size(meritev.sin));
protokol=zeros(size(meritev.sin));



tmp=fft(meritev.sin(1,:));
tmp(3:end-1)=0;
novi_sin(1,:)=ifft(tmp);
max_el=find(max(novi_sin(1,:))==novi_sin(1,:));
novi_sin(1,:)=meritev.sin(1,:);
novi_cos(1,:)=meritev.cos(1,:);


for i= 2:length(meritev.displacement)
   
    tmp=fft(meritev.sin(i,:));
    tmp(3:end-1)=0;
    novi_sin(i,:)=ifft(tmp); 
    max_nov=find(max(novi_sin(i,:))==novi_sin(i,:));
    koliksen_shift(i)=max_nov-max_el;
    
    if max_nov>max_el
        novi_sin(i,:)=meritev.sin(i,[max_nov-max_el:length(meritev.sin(i,:)) ,1:max_nov-max_el-1]);
        novi_cos(i,:)=meritev.cos(i,[max_nov-max_el:length(meritev.sin(i,:)) ,1:max_nov-max_el-1]);
    elseif max_nov<max_el
        novi_sin(i,:)=meritev.sin(i,[length(meritev.sin(i,:))+(max_nov-max_el):length(meritev.sin(i,:)),1:length(meritev.sin(i,:))+(max_nov-max_el)-1]);
        novi_cos(i,:)=meritev.cos(i,[length(meritev.sin(i,:))+(max_nov-max_el):length(meritev.sin(i,:)),1:length(meritev.sin(i,:))+(max_nov-max_el)-1]);
    else
        novi_sin(i,:)=meritev.sin(i,:);
        novi_cos(i,:)=meritev.cos(i,:);
    end
    
    protokol(i,:)=atan2d(novi_sin(i,:),novi_cos(i,:))-linspace(0,360,1000);
    protokol(i,protokol(i,:)>180)=protokol(i,protokol(i,:)>180)-360;
    protokol(i,protokol(i,:)<-180)=protokol(i,protokol(i,:)<-180)+360;
    
        
end
 protokol(1,:)=meritev.protocol(1,:);


figure
subplot(2,2,1)
plot(novi_sin')
hold on
plot(novi_cos')
grid on
grid minor
title('popravljen analog')
subplot(2,2,3)
plot(protokol')
grid on
grid minor
title('popravlejen protokol')



subplot(2,2,2)
plot(meritev.cos')
hold on
plot(meritev.sin')
grid on
grid minor
title('zajeti analog')


subplot(2,2,4)
plot(meritev.cos',meritev.sin')
hold on
plot(meritev.cos(:,1),meritev.sin(:,1),'*k')
plot(novi_cos(:,1),novi_sin(:,1),'*m')
aa=[meritev.cos(:,1)';zeros(size(meritev.cos(:,1)'))];
bb=[meritev.sin(:,1)';zeros(size(meritev.cos(:,1)'))];
plot(aa(:),bb(:),'-k');

aa=[novi_cos(:,1)';zeros(size(meritev.cos(:,1)'))];
bb=[novi_sin(:,1)';zeros(size(meritev.cos(:,1)'))];
plot(aa(:),bb(:),'-m');
grid on
grid minor
title('lis')
axis equal
%%
koliksen_shift'.*360/1000
figure
plot(meritev.cos',meritev.sin')
hold on
plot(meritev.cos(:,1),meritev.sin(:,1),'-k')
plot(novi_cos(:,1),novi_sin(:,1),'-m')

grid on
grid minor
title('lis')
axis equal


