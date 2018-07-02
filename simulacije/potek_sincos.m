% Mitja Alic
% Notranje Gorice 2018.06.29 
% funkcija izrise potek analognih signalov offseta in prvega harmonika kako
% se spreminja od ekscentricnosti ki jo vpises kot vhod

load Rezultati_simulacij.mat
load Rezultati_meritve.mat

meritev = 'lin_xd';

eval(strcat('podatki=',meritev,';'))
tx = ['\Delta ',meritev(end-1),'_',meritev(end)];

fftSin = mojfft(podatki.sin);
fftCos = mojfft(podatki.cos);

yOff = [fftSin{1}(:,1).* cosd(fftSin{2}(:,1)), ...
    fftCos{1}(:,1).* cosd(fftCos{2}(:,1))];

y1st =[fftSin{1}(:,2), fftCos{1}(:,2)];
y1stPh =[fftSin{2}(:,2)+90, fftCos{2}(:,2)];

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
if (max(yOff(:))-min(yOff(:)))<1e-14;
    axis( [0,0.5,-0.5+mean(yOff(:)),0.5+mean(yOff(:))])
else
    axis( [0,0.5,-Inf,Inf])
end
legend('sin','cos','Location','northeast')
grid on
xlabel([tx ' / mm'])
ylabel('B / mT')

figure('Name', [meritev, ' 1st harmonic'] ,'Position', ...
       [10 scrsz(4)-10-80-600 800 600]);
axes1 = axes('Parent',gcf,...
        'YGrid','on',...
        'XGrid','on',...
        'FontSize',16,...
        'FontName','Times New Roman');
plot(x,y1st,'LineWidth',2);
if (max(y1st(:))-min(y1st(:)))<1e-14;
    axis( [0,0.5,-0.5+mean(y1st(:)),0.5+mean(y1st(:))])
else
    axis( [0,0.5,-Inf,Inf])
end

legend('sin','cos','Location','northeast')
grid on
xlabel([tx ' / mm'])
ylabel('B / mT')

figure('Name', [meritev, ' 1st harmonic phase'] ,'Position', ...
       [10 scrsz(4)-10-80-600 800 600]);
axes1 = axes('Parent',gcf,...
        'YGrid','on',...
        'XGrid','on',...
        'FontSize',16,...
        'FontName','Times New Roman');
plot(x,y1stPh,'LineWidth',2);
if (max(y1stPh(:))-min(y1stPh(:)))<1e-14;
    axis( [0,0.5,-0.5+mean(y1stPh(:)),0.5+mean(y1stPh(:))])
else
    axis( [0,0.5,-Inf,Inf])
end
legend('sin','cos','Location','northeast')
grid on
xlabel([tx ' / mm'])
ylabel('fazni zamik / ^\circ')



clear axes1 scrsz meritev x y1st yOff tx y1stPh