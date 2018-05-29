figure(1)
% subplot(2,3,1);
% plot(array_pozicij(:,1,1,1),'-b','linewidth',1.5)
% hold on
% plot(array_pozicij(:,1,2,1),'-r')
% plot(array_pozicij(:,1,3,1),'-m')
% plot(array_pozicij(:,1,4,1),'-k')
% grid on
% hold off
% legend('sin1','sin2','cos1','cos2')
% title('poteki pri nicli')

subplot(2,3,1);
plot(array_pozicij(1,:,1,1),'-b')
hold on
plot(array_pozicij(1,:,2,1),'-r')
plot(array_pozicij(1,:,3,1),'-m')
plot(array_pozicij(1,:,4,1),'-k')
grid on
hold off
legend('sin1','sin2','cos1','cos2')
title('zacetne tocke od displacmenta xs')


subplot(2,3,2);
plot(array_pozicij(1,:,1,2),'-b')
hold on
plot(array_pozicij(1,:,2,2),'-r')
plot(array_pozicij(1,:,3,2),'-m')
plot(array_pozicij(1,:,4,2),'-k')
grid on
hold off
legend('sin1','sin2','cos1','cos2')
title('zacetne tocke od displacmenta ys')

subplot(2,3,4);
plot(array_pozicij(1,:,1,3),'-b')
hold on
plot(array_pozicij(1,:,2,3),'-r')
plot(array_pozicij(1,:,3,3),'-m')
plot(array_pozicij(1,:,4,3),'-k')
grid on
hold off
legend('sin1','sin2','cos1','cos2')
title('zacetne tocke od displacmenta xd')

subplot(2,3,5);
plot(array_pozicij(1,:,1,4),'-b')
hold on
plot(array_pozicij(1,:,2,4),'-r')
plot(array_pozicij(1,:,3,4),'-m')
plot(array_pozicij(1,:,4,4),'-k')
grid on
hold off
legend('sin1','sin2','cos1','cos2')
title('zacetne tocke od displacmenta yd')



subplot(2,3,3);
plot(real_xs.sin(:,1),'-b')
hold on
plot(real_ys.sin(:,1),'-r')
plot(real_xd.sin(:,1),'-m')
plot(real_yd.sin(:,1),'-k')
grid on
hold off
legend('xs','ys','xd','yd')
title('zacetne tocke sinusa')



subplot(2,3,6);
plot(real_xs.cos(:,1),'-b')
hold on
plot(real_ys.cos(:,1),'-r')
plot(real_xd.cos(:,1),'-m')
plot(real_yd.cos(:,1),'-k')
grid on
hold off
legend('xs','ys','xd','yd')
title('zacetne tocke cosinusa')
%%
figure(2)

if kot==0
    s_plot=[1,2,9,10];
elseif kot==90
    s_plot=[1,2,9,10]+2;
elseif kot==180
    s_plot=[1,2,9,10]+4;
elseif kot==270
    s_plot=[1,2,9,10]+6;
end
s_plot


real_xs.protocol(real_xs.protocol>90)=real_xs.protocol(real_xs.protocol>90)-180;
real_xs.protocol(real_xs.protocol<-90)=real_xs.protocol(real_xs.protocol<-90)+180;
real_ys.protocol(real_ys.protocol>90)=real_ys.protocol(real_ys.protocol>90)-180;
real_ys.protocol(real_ys.protocol<-90)=real_ys.protocol(real_ys.protocol<-90)+180;
real_xd.protocol(real_xd.protocol>90)=real_xd.protocol(real_xd.protocol>90)-180;
real_xd.protocol(real_xd.protocol>90)=real_xd.protocol(real_xd.protocol>90)-180;
real_xd.protocol(real_xd.protocol>90)=real_xd.protocol(real_xd.protocol>90)-180;
real_xd.protocol(real_xd.protocol<-90)=real_xd.protocol(real_xd.protocol<-90)+180;
real_yd.protocol(real_yd.protocol>90)=real_yd.protocol(real_yd.protocol>90)-180;
real_yd.protocol(real_yd.protocol<-90)=real_yd.protocol(real_yd.protocol<-90)+180;

real_xs.protocol(real_xs.protocol>45)=real_xs.protocol(real_xs.protocol>45)-90;
real_xs.protocol(real_xs.protocol<-45)=real_xs.protocol(real_xs.protocol<-45)+90;
real_ys.protocol(real_ys.protocol>45)=real_ys.protocol(real_ys.protocol>45)-90;
real_ys.protocol(real_ys.protocol<-45)=real_ys.protocol(real_ys.protocol<-45)+90;
real_xd.protocol(real_xd.protocol>45)=real_xd.protocol(real_xd.protocol>45)-90;
real_xd.protocol(real_xd.protocol>45)=real_xd.protocol(real_xd.protocol>45)-90;
real_xd.protocol(real_xd.protocol>45)=real_xd.protocol(real_xd.protocol>45)-90;
real_xd.protocol(real_xd.protocol<-45)=real_xd.protocol(real_xd.protocol<-45)+90;
real_yd.protocol(real_yd.protocol>45)=real_yd.protocol(real_yd.protocol>45)-90;
real_yd.protocol(real_yd.protocol<-45)=real_yd.protocol(real_yd.protocol<-45)+90;


subplot(2,8,s_plot(1))
plot(real_xs.protocol')
title(['xs with '])
grid on

subplot(2,8,s_plot(2))
plot(real_ys.protocol')
title('ys')
grid on

subplot(2,8,s_plot(3))
plot(real_xd.protocol')
title('xd')
grid on

subplot(2,8,s_plot(4))
plot(real_yd.protocol')
title('yd')
grid on
%%
subplot(2,8,1)
title('xs with 0')
subplot(2,8,2)
title('ys with 0')
subplot(2,8,9)
title('xd with 0')
subplot(2,8,10)
title('yd with 0')

subplot(2,8,3)
title('xs with 90')
subplot(2,8,4)
title('ys with 90')
subplot(2,8,11)
title('xd with 90')
subplot(2,8,12)
title('yd with 90')

subplot(2,8,5)
title('xs with 180')
subplot(2,8,6)
title('ys with 180')
subplot(2,8,13)
title('xd with 180')
subplot(2,8,14)
title('yd with 180')

subplot(2,8,7)
title('xs with 270')
subplot(2,8,8)
title('ys with 270')
subplot(2,8,15)
title('xd with 270')
subplot(2,8,16)
title('yd with 270')

