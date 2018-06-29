% Mitja Alic
% Notranje Gorice 2018.06.29 
% funkcija izrise potek analognih signalov offseta in prvega harmonika kako
% se spreminja od ekscentricnosti ki jo vpises kot vhod

load Rezultati_simulacij.mat
load Rezultati_meritve.mat

meritev = 'lin_xs';

eval(strcat('podatki=',meritev,';'))

fftSin = mojfft(podatki.sin);
fftCos = mojfft(podatki.cos);

yOff = [fftSin{1}(:,1).* cosd(fftSin{2}(:,1)), ...
    fftCos{1}(:,1).* cosd(fftCos{2}(:,1))];

y1st =[fftSin{1}(:,2), fftCos{1}(:,2)];


x = [podatki.displacement, podatki.displacement];

clear lin_xs lin_xd lin_ys lin_yd real_xs real_xd real_ys real_yd ...
    meritev_xs meritev_ys meritev_xd meritev_zs
clear podatki fftSin fftCos


scrsz = get(0,'ScreenSize');
figure('Name', [meritev, ' Off'] ,'Position', ...
       [10 scrsz(4)-10-80-600 800 600]);
axes1 = axes('Parent',gcf,...
        'YGrid','on',...
        'XGrid','on',...
        'FontSize',16,...
        'FontName','Times New Roman');
plot(x,yOff,'LineWidth',2);
axis( [0,0.5,-Inf,Inf])
legend('sin','cos','Location','northwest')
grid on
xlabel('\theta / ^\circ')
ylabel('B / mT')

figure('Name', [meritev, ' 1st harmonic'] ,'Position', ...
       [10 scrsz(4)-10-80-600 800 600]);
axes1 = axes('Parent',gcf,...
        'YGrid','on',...
        'XGrid','on',...
        'FontSize',16,...
        'FontName','Times New Roman');
plot(x,y1st,'LineWidth',2);
axis( [0,0.5,-Inf,Inf])
legend('sin','cos','Location','northwest')
grid on
xlabel('\theta / ^\circ')
ylabel('B / mT')


clear axes1 scrsz meritev x y1st yOff