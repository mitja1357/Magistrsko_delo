
eks='xd';

eval(strcat('real=real_',eks,';'))
eval(strcat('meritev=meritev_',eks,';'))

%%
 scrsz = get(0,'ScreenSize');

figure('Position',[1930 scrsz(4)-30-80-950 1600 950]);
subplot(2,2,1)
plot(real.displacement,mean(real.cos'),'LineWidth',1.6)
hold on
plot(real.displacement,mean(real.sin'),'-r','LineWidth',1.6)
plot(meritev.displacement,mean(meritev.sin'),'-k','LineWidth',1.6)
plot(meritev.displacement,mean(meritev.cos'),'-m','LineWidth',1.6)
legend('real cos','real sin','mer sin','mer cos')
title(['povprecje analognih ',eks])
xlabel('displace')
ylabel('mean(analog)')
grid on
grid minor
axis([0,0.5,-inf,inf])

subplot(2,2,2)
plot(real.displacement,max(real.cos')-min(real.cos'),'LineWidth',1.6)
hold on
plot(real.displacement,max(real.sin')-min(real.sin'),'-r','LineWidth',1.6)
plot(meritev.displacement,max(meritev.sin')-min(meritev.sin'),'-k','LineWidth',1.6)
plot(meritev.displacement,max(meritev.cos')-min(meritev.cos'),'-m','LineWidth',1.6)
legend('real cos','real sin','mer sin','mer cos')
title(['peak2peak analognih ',eks])
xlabel('displace')
ylabel('peak2peak(analog)')
grid on
grid minor
axis([0,0.5,-inf,inf])
subplot(2,2,3)
tmp1=mojfft(real.sin);
tmp2=mojfft(real.cos);
plot(real.displacement,tmp1{2}(:,2)-tmp2{2}(:,2),'LineWidth',1.6)
hold on
tmp1=mojfft(meritev.sin);
tmp2=mojfft(meritev.cos);

if mean(tmp1{2}(:,2)-tmp2{2}(:,2))<-180
    plot(meritev.displacement,tmp1{2}(:,2)-tmp2{2}(:,2)+360,'-r','LineWidth',1.6)
elseif mean(tmp1{2}(:,2)-tmp2{2}(:,2))> 180
    plot(meritev.displacement,tmp1{2}(:,2)-tmp2{2}(:,2)-360,'-r','LineWidth',1.6)
else
    plot(meritev.displacement,tmp1{2}(:,2)-tmp2{2}(:,2),'-r','LineWidth',1.6)
end
    
    
title(['faza ',eks])
grid on
grid minor
legend('real','meritev')
axis([0,0.5,-inf,inf])

subplot(2,2,4)
tmp1=mojfft(real.sin);
tmp2=mojfft(real.cos);
plot(real.displacement,tmp1{1}(:,3),'-r','LineWidth',1.6)
hold on
plot(real.displacement,tmp2{1}(:,3),'LineWidth',1.6)
tmp1=mojfft(meritev.sin);
tmp2=mojfft(meritev.cos);
plot(meritev.displacement,tmp1{1}(:,3),'-k','LineWidth',1.6)
plot(meritev.displacement,tmp2{1}(:,3),'-m','LineWidth',1.6)
title(['2nd harmonik ',eks])
grid on
grid minor
legend('real sin','real cos','mer sin','mer cos')
axis([0,0.5,-inf,inf])



figure('Position',[100 scrsz(4)-30-80-950 1600 950]);
subplot(2,2,1)
plot(real.protocol([1,end],:)')
grid on
subplot(2,2,2)
plot(real.sin([1,end],:)')
hold on
plot(real.cos([1,end],:)')
grid on
subplot(2,2,3)
plot(meritev.protocol([1,end],:)')
grid on
subplot(2,2,4)
plot(meritev.sin([1,end],:)')
hold on
plot(meritev.cos([1,end],:)')
grid on




clear tmp1 tmp2 scrsz
figure
subplot(2,1,1)
pmxss=plot(meritev_xs.sin','-b','DisplayName','meritev_xs.sin');
hold on
pmyss=plot(meritev_ys.sin','-r','DisplayName','meritev_xs.sin');
pmxds=plot(meritev_xd.sin','-m','DisplayName','meritev_xs.sin');
pmxsc=plot(meritev_xs.cos','-b','DisplayName','meritev_xs.sin');
pmysc=plot(meritev_ys.cos','-r','DisplayName','meritev_xs.sin');
pmxdc=plot(meritev_xd.cos','-m','DisplayName','meritev_xs.sin');
grid on
grid minor
legend([pmxss(1),pmyss(1),pmxds(1)],{'m xs','m ys', 'm xd' })
subplot(2,1,2)
prxss=plot(real_xs.sin','-b','DisplayName','meritev_xs.sin');
hold on
pryss=plot(real_ys.sin','-r','DisplayName','meritev_xs.sin');
prxds=plot(real_xd.sin','-m','DisplayName','meritev_xs.sin');
prxsc=plot(real_xs.cos','-b','DisplayName','meritev_xs.sin');
prysc=plot(real_ys.cos','-r','DisplayName','meritev_xs.sin');
prxdc=plot(real_xd.cos','-m','DisplayName','meritev_xs.sin');
legend([prxss(1),pryss(1),prxds(1)],{'m xs','m ys', 'm xd' })
grid on
grid minor
