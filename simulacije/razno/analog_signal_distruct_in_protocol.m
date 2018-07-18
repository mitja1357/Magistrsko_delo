close all;
clear



theta = linspace(0,360,8192);

primer = 1;

offset_sin = 0;
offset_cos = 0;
faza_sin = 0;
faza_cos = 0;
amp_cos = 1;
amp_sin = 1;
visji_harmoniki_sin = 0;
visji_harmoniki_cos = 0;

% y1= sind(theta*2);
% y2= sin(2.*theta*2);
% y3= sin(3.*theta*2);
% y4= sin(4.*theta*2);
% %for faza=-0.5:0.1:0.5
predviden_error = zeros(size(theta));
if (primer == 0)
    
elseif(primer == 1)
    amp_cos = 1.1;
    
    k = amp_sin/amp_cos;
    
    k1 = (k-1)/(1+k);
    for i=1:15
        faktor = 180/pi/i*k1^i;
        predviden_error = predviden_error+faktor* sind(2*i*theta);
    end
    
elseif (primer == 2)
    amp_sin = 1.1; 
    
    k = amp_sin/amp_cos;
    
    k1 = (1-k)/(1+k);
    for i=1:15
        faktor = 180/pi/i*k1^i*(-1)^(i);
        predviden_error = predviden_error+faktor* sind(2*i*theta);
    end
    
elseif (primer == 3)
    faza_sin = 1;
elseif (primer == 4)
    faza_cos = 1;
elseif (primer == 5)
    faza_sin = 1;
    faza_cos = 1;
elseif (primer == 6)
    offset_sin = 0.1;
elseif (primer == 7)
    offset_cos = 0.1;
elseif (primer == 8)
    offset_sin = 0.1;
    offset_cos = 0.1;
end;

Sin = offset_sin + amp_sin.*sind(theta+faza_sin) + visji_harmoniki_sin;
Cos = offset_cos + amp_cos.*cosd(theta+faza_cos) + visji_harmoniki_cos;
kot=atan2d(Sin,Cos);
protocol=kot-theta;
protocol(protocol>180)= protocol(protocol>180)-360;
protocol(protocol<-180)= protocol(protocol<-180)+360;

%% Grafièni prikaz
figure(1)
subplot(2,2,1)
plot(theta,Cos)
legend('Cos')

subplot(2,2,3)
plot(theta,Sin)

disp(strvcat({'meritve napake','mean          peak2peak',...
              num2str([mean(protocol) (max(protocol)-min(protocol))/360*2*pi])}))

          
          
subplot(2,2,2)
plot(theta,protocol,theta,predviden_error)
grid on
legend('err')

subplot(2,2,4)
plot(theta,protocol-predviden_error)
grid on
% disp(strvcat({'meritve napake','mean          peak2peak',...
%               num2str([mean(protocol) max(protocol)-min(protocol)])}))
% end
%%


% [amplituda,faza]=mojfft(protocol);
% aha = mojfft(protocol);
% amp_prot = aha{1,1};
% faza_prot_deg = aha{1,2};

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


