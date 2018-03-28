close all;



theta=linspace(0,360,8192);

primer = 2;

offset_sin=1;
offset_cos=1;
faza=0;
amp_cos=0;

y1= sin(theta*2*pi/360);
y2= sin(2.*theta*2*pi/360);
y3= sin(3.*theta*2*pi/360);
y4= sin(4.*theta*2*pi/360);
%for faza=-0.5:0.1:0.5

if(primer == 1)
    Sin=1*sind(theta+faza);
    Cos=(1+amp_cos)*cosd(theta)+offset_cos+0.5*cosd(2.*theta);
elseif (primer == 2)
    Sin=1*sind(theta+faza)+0.5*sind(2.*theta);
    Cos=(1+amp_cos)*cosd(theta)+offset_cos+0.5*cosd(2.*theta);
elseif (primer == 3)
    Sin=1*sind(theta+faza);
    Cos=(1+amp_cos)*cosd(theta)+offset_cos+0.5*cosd(2.*theta);
elseif (primer == 4)
    Sin=1*sind(theta+faza)+0.5*sind(2.*theta);
    Cos=(1+amp_cos)*cosd(theta)+offset_cos+0.5*cosd(2.*theta);
end;

kot=atan2d(Sin,Cos);
protocol=kot-theta;
protocol(protocol>180)= protocol(protocol>180)-360;
protocol(protocol<-180)= protocol(protocol<-180)+360;

%% Grafièni prikaz
figure
subplot(2,1,1)
plot(theta,Cos)
legend('Cos')

subplot(2,1,2)
plot(theta,Sin)

disp(strvcat({'meritve napake','mean          peak2peak',...
              num2str([mean(protocol) max(protocol)-min(protocol)])}))

          
          
figure
plot(theta,protocol)
grid on
legend('err')
disp(strvcat({'meritve napake','mean          peak2peak',...
              num2str([mean(protocol) max(protocol)-min(protocol)])}))
% end
%%


% [amplituda,faza]=mojfft(protocol);
aha = mojfft(protocol);
amp_prot = aha{1,1};
faza_prot_deg = aha{1,2};

%%
% 
% x=linspace(0,1,10e4);
% 
% 
% y1=sin(x*50*2*pi);
% y2=sin(2*x*50*2*pi);
% y3=sin(3*x*50*2*pi);
% y4=sin(4*x*50*2*pi);
% 
% % y1=cos(x*50*2*pi);
% % y2=cos(2*x*50*2*pi);
% % y3=cos(3*x*50*2*pi);
% % y4=cos(4*x*50*2*pi);
% % 
% %%
% figure
% plot(x,y1+y2)
% hold on;
% plot(x,y1+y3,'r')
% 
% legend('1+2','1+3')
% 
% 
% xlim([0,20e-3])


