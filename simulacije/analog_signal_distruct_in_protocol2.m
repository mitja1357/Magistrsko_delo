close all;



theta = linspace(0,360,8192);

primer = 4;

offset_cos = 0.0;
offset_sin = 0.0;

delta_amp_1_harm = 0.0;
delta_faza_1_harm_deg = 0;

amp_cos_2_harm = 0.0;
amp_sin_2_harm = 0.0;
delta_faza_2_harm_deg = 0;

amp_cos_3_harm = 0.0;
amp_sin_3_harm = 0.0;
delta_faza_3_harm_deg = 0;

amp_cos_4_harm = 0.0;
amp_sin_4_harm = 0.0;
delta_faza_4_harm_deg = 0;

%%
if(primer == 1)
    Cos = offset_cos + 1*cosd(theta);
    Sin = offset_sin + (1+delta_amp_1_harm)*sind(theta + delta_faza_1_harm_deg);
    %     Cos=(1+delta_amp_cos)*cosd(theta)+offset_cos+0.5*cosd(2.*theta);
elseif (primer == 2)
    Cos = offset_cos + ...
          1*cosd(theta) + ...
          amp_cos_2_harm*cosd(2*theta);
    Sin = offset_sin + ...
          (1 + delta_amp_1_harm)*sind(theta + delta_faza_1_harm_deg) + ...
          amp_sin_2_harm*sind(2*theta + delta_faza_2_harm_deg);
elseif (primer == 3)
    Cos = offset_cos + ...
          1*cosd(theta) + ...
          amp_cos_2_harm*cosd(2*theta) + ...
          amp_cos_3_harm*cosd(3*theta);
    Sin = offset_sin + ...
          (1 + delta_amp_1_harm)*sind(theta + delta_faza_1_harm_deg) + ...
          amp_sin_2_harm*sind(2*theta + delta_faza_2_harm_deg) + ...
          amp_sin_3_harm*sind(3*theta + delta_faza_3_harm_deg);
elseif (primer == 4)
    Cos = offset_cos + ...
          1*cosd(theta) + ...
          amp_cos_2_harm*cosd(2*theta) + ...
          amp_cos_3_harm*cosd(3*theta) + ...
          amp_cos_4_harm*cosd(4*theta);
    Sin = offset_sin + ...
          (1 + delta_amp_1_harm)*sind(theta + delta_faza_1_harm_deg) + ...
          amp_sin_2_harm*sind(2*theta + delta_faza_2_harm_deg) + ...
          amp_sin_3_harm*sind(3*theta + delta_faza_3_harm_deg) + ...
          amp_sin_4_harm*sind(4*theta + delta_faza_4_harm_deg);
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

figure
bar(0:6,amp_prot(1:7))

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


