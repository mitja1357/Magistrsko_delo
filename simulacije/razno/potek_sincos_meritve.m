function potek_sincos_meritve(meritev,shrani)
load Rezultati_meritve.mat
eval(strcat('m = meritev_',meritev,';'));
dis = m.displacement;
x = m.ref;
y1 = m.cos;
y2 = m.sin;

tx =['\Delta ',meritev(1),'_',meritev(2)];

for i = 1:length(dis)
    fftcos= mojfft(y1(i,:));
    fftsin= mojfft(y2(i,:));
    
    cosA0(i)=fftcos{1}(1)*cosd(fftcos{2}(1));
    cosA1(i)=fftcos{1}(2);
    cosf1(i)=fftcos{2}(2);
    sinA0(i)=fftsin{1}(1)*cosd(fftsin{2}(1));
    sinA1(i)=fftsin{1}(2);
    sinf1(i)=fftsin{2}(2);
    
%     [fitresult, gof] = createFits(x(i,:), ...
%         y1(i,:), y2(i,:),1);
%     w(i)=fitresult{1}.w;
%     cosA0(i)=fitresult{1}.a0;
%     cosA1(i)=fitresult{1}.a1;
%     cosf1(i)=fitresult{1}.f1;
%     cosA2(i)= fitresult{1}.a2;
%     cosf2(i)= fitresult{1}.f2;
%     cosA3(i)=fitresult{1}.a3;
%     cosf3(i)=fitresult{1}.f3;
%     sinA0(i)=fitresult{2}.a0;
%     sinA1(i)=fitresult{2}.a1;
%     sinf1(i)=fitresult{2}.f1;
%     sinA2(i)= fitresult{2}.a2;
%     sinf2(i)= fitresult{2}.f2;
%     sinA3(i)=fitresult{2}.a3;
%     sinf3(i)=fitresult{2}.f3;
end

%%
filename= ...
    ['C:\Users\mitja\Documents\Magistrsko_delo\Diploma_Latex_v2\Slike\', ...
    'MER', '\', meritev,'_'];

scrsz = get(0,'ScreenSize');
% figure('Name',[meritev , ' frekvenca'],'Position', ...
%        [10 scrsz(4)-10-80-600 800 600]);
% axes1 = axes('Parent',gcf,...
%         'YGrid','on',...
%         'XGrid','on',...
%         'FontSize',16,...
%         'FontName','Times New Roman');
% plot(dis,w,'LineWidth',2);
% grid on
% xlabel([tx ' / mm'])
% ylabel('f / Hz')





figure('Name',[meritev , ' offset'],'Position', ...
       [10 scrsz(4)-10-80-600 800 600]);
axes1 = axes('Parent',gcf,...
        'YGrid','on',...
        'XGrid','on',...
        'FontSize',16,...
        'FontName','Times New Roman');
plot(dis,sinA0,dis,cosA0,'LineWidth',2);

legend('sin','cos','Location','northeast')
grid on
xlabel([tx ' / mm'])
% ylabel('B / mT')
if exist('shrani')
    if shrani
        saveas(gcf,[filename, 'sincos_off'],'epsc')
    end
end

figure('Name',[meritev , ' amp'],'Position', ...
       [10 scrsz(4)-10-80-600 800 600]);
axes1 = axes('Parent',gcf,...
        'YGrid','on',...
        'XGrid','on',...
        'FontSize',16,...
        'FontName','Times New Roman');
plot(dis,abs(sinA1),dis,abs(cosA1),'LineWidth',2);

legend('sin','cos','Location','northeast')
grid on
xlabel([tx ' / mm'])
% ylabel('B / mT')
if exist('shrani')
    if shrani
        saveas(gcf,[filename, 'sincos_amp'],'epsc')
    end
end
figure('Name',[meritev , ' faza'],'Position', ...
       [10 scrsz(4)-10-80-600 800 600]);
axes1 = axes('Parent',gcf,...
        'YGrid','on',...
        'XGrid','on',...
        'FontSize',16,...
        'FontName','Times New Roman');
plot(dis,sinf1+90,dis,cosf1,'LineWidth',2);

legend('sin','cos','Location','northeast')
grid on
xlabel([tx ' / mm'])
ylabel('fazni zamik / ^\circ')
if exist('shrani')
    if shrani
        saveas(gcf,[filename, 'sincos_phase'],'epsc')
    end
end
% figure('Name',[meritev , ' 2nd harm'],'Position', ...
%        [10 scrsz(4)-10-80-600 800 600]);
% axes1 = axes('Parent',gcf,...
%         'YGrid','on',...
%         'XGrid','on',...
%         'FontSize',16,...
%         'FontName','Times New Roman');
% plot(dis,abs(sinA2),dis,abs(cosA2),'LineWidth',2);
% 
% legend('sin','cos','Location','northeast')
% grid on
% xlabel([tx ' / mm'])
% % ylabel('B / mT')
% 
% figure('Name',[meritev , ' 3rd harm'],'Position', ...
%        [10 scrsz(4)-10-80-600 800 600]);
% axes1 = axes('Parent',gcf,...
%         'YGrid','on',...
%         'XGrid','on',...
%         'FontSize',16,...
%         'FontName','Times New Roman');
% plot(dis,abs(sinA3),dis,abs(cosA3),'LineWidth',2);
% 
% legend('sin','cos','Location','northeast')
% grid on
% xlabel([tx ' / mm'])
% ylabel('B / mT')
%%
clear i axes1 scrsz tx meritev m dis x y1 y2 fitresult gof w
clear cosA0 cosA1 cosf1 cosA2 cosf2 cosA3 cosf3
clear sinA0 sinA1 sinf1 sinA2 sinf2 sinA3 sinf3
end
