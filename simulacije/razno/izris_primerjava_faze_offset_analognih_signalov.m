eksi={'xs','ys','xd'};
for i=1:3
    eks=eksi{i};


tip='meritev';


switch eks
    case 'xs'
        a=[1,2,3];
    case 'ys'
        a=[4,5,6];
    case 'xd'
        a=[7,8,9];
end



f1=figure(a(1));
f2=figure(a(2));
f3=figure(a(3));
set(f1,'Name',['faza ',eks]);
set(f1,'NumberTitle','off');
set(f2,'Name',['offset sin',eks]);
set(f2,'NumberTitle','off');
set(f3,'Name',['offset cos ',eks]);
set(f3,'NumberTitle','off');

eval(strcat('tmp=',tip,'_',eks,';'))
fft_sin=mojfft(tmp.sin);
fft_cos=mojfft(tmp.cos);
faza=fft_sin{2}(:,2)-fft_cos{2}(:,2);
faza(faza<-180)=faza(faza<-180)+360;
faza(faza> 180)=faza(faza> 180)-360;

figure(a(1))
plot(tmp.displacement,faza,'-*b','LineWidth',1.5)
grid on
hold on

figure(a(2))
plot(tmp.displacement,fft_sin{1}(:,1).*cosd(fft_sin{2}(:,1)),'-*b','LineWidth',1.5)
grid on
hold on

figure(a(3))
plot(tmp.displacement,fft_cos{1}(:,1).*cosd(fft_cos{2}(:,1)),'-*b','LineWidth',1.5)
grid on
hold on


tip='real';
eval(strcat('tmp=',tip,'_',eks,';'))
fft_sin=mojfft(tmp.sin);
fft_cos=mojfft(tmp.cos);
faza=fft_sin{2}(:,2)-fft_cos{2}(:,2);
faza(faza<-180)=faza(faza<-180)+360;
faza(faza> 180)=faza(faza> 180)-360;

figure(a(1))
plot(tmp.displacement,faza,'-*r','LineWidth',1.5)
grid on
hold on

figure(a(2))
plot(tmp.displacement,fft_sin{1}(:,1).*cosd(fft_sin{2}(:,1)),'-*r','LineWidth',1.5)
grid on
hold on

figure(a(3))
plot(tmp.displacement,fft_cos{1}(:,1).*cosd(fft_cos{2}(:,1)),'-*r','LineWidth',1.5)
grid on
hold on






tip='lin';
eval(strcat('tmp=',tip,'_',eks,';'))
fft_sin=mojfft(tmp.sin);
fft_cos=mojfft(tmp.cos);
faza=fft_sin{2}(:,2)-fft_cos{2}(:,2);
faza(faza<-180)=faza(faza<-180)+360;
faza(faza> 180)=faza(faza> 180)-360;


figure(a(1))
plot(tmp.displacement,faza,'-*m','LineWidth',1.5)
grid on
hold off
legend('meritev','real','lin')

figure(a(2))
plot(tmp.displacement,fft_sin{1}(:,1).*cosd(fft_sin{2}(:,1)),'-*m','LineWidth',1.5)
grid on
hold off
legend('meritev','real','lin')

figure(a(3))
plot(tmp.displacement,fft_cos{1}(:,1).*cosd(fft_cos{2}(:,1)),'-*m','LineWidth',1.5)
grid on
hold off
legend('meritev','real','lin')

end
