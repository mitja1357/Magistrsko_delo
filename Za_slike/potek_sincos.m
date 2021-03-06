% Mitja Alic
% Notranje Gorice 2018.06.29 
% funkcija izrise potek analognih signalov offseta in prvega harmonika kako
% se spreminja od ekscentricnosti ki jo vpises kot vhod
%
% 2018.07.02 dodal da se mi shrani v mapo na racunalniku
% 2018.07.18 poravil da sharnim ?e �elim, pri meritvah ni y skale pri amp
% in off
% 2018.10.11 popravil directorij kam se shranjujejo slike
function potek_sincos(meritev,shrani)

load real_diferencialnesonde.mat
load Rezultati_meritve.mat
pathfolder = pwd;
allSlash = strfind(pathfolder, '\');

filename= [pathfolder(1:allSlash(end)), ...
    'Diploma_Latex_v2\Slike\', ...
    upper(meritev(1:3)), '\', meritev(end-1:end),'_'];
eval(strcat('podatki=',meritev,';'))
tx = ['\Delta ',meritev(end-1),'_',meritev(end)];

if strfind(meritev,'merit')
    fftSin = createFit(podatki.ref, podatki.sin);
    fftCos = createFit(podatki.ref, podatki.cos);
else
    fftSin = mojfft(podatki.sin);
    fftCos = mojfft(podatki.cos);
end

yOff = [fftSin{1}(:,1).* cosd(fftSin{2}(:,1)), ...
    fftCos{1}(:,1).* cosd(fftCos{2}(:,1))];

y1st =[fftSin{1}(:,2), fftCos{1}(:,2)];
y1stPh =[fftSin{2}(:,2)+90, fftCos{2}(:,2)];
y2nd =[fftSin{1}(:,3), fftCos{1}(:,3)];

x = [podatki.displacement, podatki.displacement];

% clear lin_xs lin_xd lin_ys lin_yd real_xs real_xd real_ys real_yd ...
    %meritev_xs meritev_ys meritev_xd meritev_zs
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
if (max(yOff(:))-min(yOff(:)))<1e-14
    axis( [0,0.5,-0.5+mean(yOff(:)),0.5+mean(yOff(:))])
else
    maxi = max(yOff(:))+0.05.*abs(max(yOff(:))-min(yOff(:)));
    mini = min(yOff(:))-0.05.*abs(max(yOff(:))-min(yOff(:)));
    axis( [0,0.5,mini,maxi]);

end
legend('B_{sin}','B_{cos}','Location','northeast')
grid on
xlabel(['$', tx,'$ / mm'],'interpreter','latex')


if isempty(strfind(meritev,'mer'))
    ylabel('$B$ / mT','interpreter','latex')
end
if exist('shrani')
    if shrani
        saveas(gcf,[filename, 'sincos_off'],'epsc')
    end
end


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
    maxi = max(y1st(:))+0.05.*abs(max(y1st(:))-min(y1st(:)));
    mini = min(y1st(:))-0.05.*abs(max(y1st(:))-min(y1st(:)));
    axis( [0,0.5,mini,maxi]);
end

legend('B_{sin}','B_{cos}','Location','northeast')
grid on
xlabel(['$', tx,'$ / mm'],'interpreter','latex')
if isempty(strfind(meritev,'mer'))
    ylabel('$B$/ mT','interpreter','latex')
end
if exist('shrani')
    if shrani
        saveas(gcf,[filename, 'sincos_amp'],'epsc')
    end
end


figure('Name', [meritev, ' 1st harmonic phase'] ,'Position', ...
       [10 scrsz(4)-10-80-600 800 600]);
axes1 = axes('Parent',gcf,...
        'YGrid','on',...
        'XGrid','on',...
        'FontSize',16,...
        'FontName','Times New Roman');
plot(x,y1stPh,'LineWidth',2);
if (max(y1stPh(:))-min(y1stPh(:)))<1e-10
    axis( [0,0.5,-0.5+mean(y1stPh(:)),0.5+mean(y1stPh(:))])
else
    maxi = max(y1stPh(:))+0.05.*abs(max(y1stPh(:))-min(y1stPh(:)));
    mini = min(y1stPh(:))-0.05.*abs(max(y1stPh(:))-min(y1stPh(:)));
    axis( [0,0.5,mini,maxi]);

end
legend('B_{sin}','B_{cos}','Location','northeast')
grid on
xlabel(['$', tx,'$ / mm'],'interpreter','latex')
ylabel('fazni zamik /$ ^\circ$','interpreter','latex')
if exist('shrani')
    if shrani
        saveas(gcf,[filename, 'sincos_phase'],'epsc')
    end
end




figure('Name', [meritev, ' 2nd harmonic amp'] ,'Position', ...
       [10 scrsz(4)-10-80-600 800 600]);
axes1 = axes('Parent',gcf,...
        'YGrid','on',...
        'XGrid','on',...
        'FontSize',16,...
        'FontName','Times New Roman');
plot(x,y2nd,'LineWidth',2);
if (max(y2nd(:))-min(y2nd(:)))<1e-14
    axis( [0,0.5,-0.5+mean(y2nd(:)),0.5+mean(y2nd(:))])
else
    maxi = max(y2nd(:))+0.05.*abs(max(y2nd(:))-min(y2nd(:)));
    mini = min(y2nd(:))-0.05.*abs(max(y2nd(:))-min(y2nd(:)));
    axis( [0,0.5,mini,maxi]);

end
legend('B_{sin}','B_{cos}','Location','northeast')
grid on
xlabel(['$', tx,'$ / mm'],'interpreter','latex')

if isempty(strfind(meritev,'mer'))
    ylabel('$B$/ mT','interpreter','latex')
end
if exist('shrani')
    if shrani
        saveas(gcf,[filename, 'sincos_2nd'],'epsc')
    end
end






clear axes1 scrsz meritev x y1st yOff tx y1stPh

end