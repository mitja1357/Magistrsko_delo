% Mitja Alic
% Notranje Gorice 2018.06.29 
% funkcija izrise potek napake najblizje 0,24mm zaradi razmerja proti 
% radiju hallovih sond. Razmerje je tako 0.1
% izrisem napako in poteka analognih signalov
% 
% 
% 2018.07.02 dodal da se mi shrani v mapo na racunalniku
function potek_napake(meritev)
load Rezultati_simulacij.mat
load Rezultati_meritve.mat

% meritev = 'lin_xd';
filename= ...
    ['C:\Users\mitja\Documents\Magistrsko_delo\Diploma_Latex_v2\Slike\', ...
    upper(meritev(1:3)), '\', meritev(end-1:end),'_'];
eval(strcat('podatki=',meritev,';'))

el = find(min(abs(podatki.displacement-0.24))== ...
    abs(podatki.displacement-0.24));
podatki.displacement(el)
ref = podatki.ref(el, :);
prot = podatki.protocol(el, :);
Sin = podatki.sin(el, :);
Cos = podatki.cos(el, :);

scrsz = get(0,'ScreenSize');
figure('Name', meritev ,'Position', ...
       [10 scrsz(4)-10-80-600 800 600]);
axes1 = axes('Parent',gcf,...
        'YGrid','on',...
        'XGrid','on',...
        'FontSize',16,...
        'FontName','Times New Roman');
plot(ref,prot,'LineWidth',2);
axis( [0,360,-Inf,Inf])
grid on
xlabel('\theta / ^\circ')
ylabel('\epsilon / ^\circ')
saveas(gcf,[filename, 'napaka'],'epsc')

figure('Name', meritev ,'Position', ...
       [10 scrsz(4)-10-80-600 800 600]);
axes1 = axes('Parent',gcf,...
        'YGrid','on',...
        'XGrid','on',...
        'FontSize',16,...
        'FontName','Times New Roman');
plot(ref,Sin,ref,Cos,'LineWidth',2);
legend('sin','cos','Location','northeast')
axis( [0,360,-Inf,Inf])
grid on
xlabel('\theta / ^\circ')
ylabel('B / mT')
saveas(gcf,[filename, 'sincos'],'epsc')



fftp = mojfft(prot);
fftp{1}(1) = fftp{1}(1) *cosd(fftp{2}(1));

figure('Name', meritev ,'Position', ...
       [10 scrsz(4)-10-80-600 800 600]);
axes1 = axes('Parent',gcf,...
        'YGrid','on',...
        'XGrid','on',...
        'FontSize',16,...
        'FontName','Times New Roman');
bar(0:4,fftp{1}(1:5),'LineWidth',2);
% axis( [0,5,-Inf,Inf])
grid on
xlabel('harmonik')
ylabel('amplituda harmonika / ^\circ')
saveas(gcf,[filename, 'fft'],'epsc')





clear lin_xs lin_xd lin_ys lin_yd real_xs real_xd real_ys real_yd ...
    meritev_xs meritev_ys meritev_xd meritev_zs
clear el ref prot Sin Cos scrsz axes1 podatki meritev fftp
end