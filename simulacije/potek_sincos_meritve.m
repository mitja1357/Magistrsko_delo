meritev ='xs';
eval(strcat('m = meritev_',meritev,';'));
dis = m.displacement;
x = m.ref;
y1 = m.sin;
y2 = m.cos;

tx =['\Delta ',meritev(1),'_',meritev(2)];

for i = 1:length(dis)
    [fitresult, gof] = createFits(x(i,:), ...
        y1(i,:), y2(i,:),1);
    w(i)=fitresult{1}.w;
    cosA0(i)=fitresult{1}.a0;
    cosA1(i)=fitresult{1}.a1;
    cosf1(i)=fitresult{1}.f1;
    cosA2(i)= fitresult{1}.a2;
    cosf2(i)= fitresult{1}.f2;
    cosA3(i)=fitresult{1}.a3;
    cosf3(i)=fitresult{1}.f3;
    sinA0(i)=fitresult{2}.a0;
    sinA1(i)=fitresult{2}.a1;
    sinf1(i)=fitresult{2}.f1;
    sinA2(i)= fitresult{2}.a2;
    sinf2(i)= fitresult{2}.f2;
    sinA3(i)=fitresult{2}.a3;
    sinf3(i)=fitresult{2}.f3;
end

%%
scrsz = get(0,'ScreenSize');
figure('Name',[meritev , ' frekvenca'],'Position', ...
       [10 scrsz(4)-10-80-600 800 600]);
axes1 = axes('Parent',gcf,...
        'YGrid','on',...
        'XGrid','on',...
        'FontSize',16,...
        'FontName','Times New Roman');
plot(dis,w,'LineWidth',2);
grid on
xlabel([tx ' / mm'])
ylabel('f / Hz')




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
ylabel('B / mT')

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
ylabel('B / mT')

figure('Name',[meritev , ' faza'],'Position', ...
       [10 scrsz(4)-10-80-600 800 600]);
axes1 = axes('Parent',gcf,...
        'YGrid','on',...
        'XGrid','on',...
        'FontSize',16,...
        'FontName','Times New Roman');
plot(dis,sinf1-sinf1(1),dis,cosf1-cosf1(1),'LineWidth',2);

legend('sin','cos','Location','northeast')
grid on
xlabel([tx ' / mm'])
ylabel('B / mT')

figure('Name',[meritev , ' 2nd harm'],'Position', ...
       [10 scrsz(4)-10-80-600 800 600]);
axes1 = axes('Parent',gcf,...
        'YGrid','on',...
        'XGrid','on',...
        'FontSize',16,...
        'FontName','Times New Roman');
plot(dis,abs(sinA2),dis,abs(cosA2),'LineWidth',2);

legend('sin','cos','Location','northeast')
grid on
xlabel([tx ' / mm'])
ylabel('B / mT')

figure('Name',[meritev , ' 3rd harm'],'Position', ...
       [10 scrsz(4)-10-80-600 800 600]);
axes1 = axes('Parent',gcf,...
        'YGrid','on',...
        'XGrid','on',...
        'FontSize',16,...
        'FontName','Times New Roman');
plot(dis,abs(sinA3),dis,abs(cosA3),'LineWidth',2);

legend('sin','cos','Location','northeast')
grid on
xlabel([tx ' / mm'])
ylabel('B / mT')
%%
clear i axes1 scrsz tx meritev m dis x y1 y2 fitresult gof 
clear cosA0 cosA1 cosf1 cosA2 cosf2 sinA0 sinA1 sinf1 w sinA2 sinf2 

