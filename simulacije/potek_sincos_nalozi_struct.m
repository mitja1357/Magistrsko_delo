% Mitja Alic
% Notranje Gorice 2018.06.29 
% funkcija izrise potek analognih signalov offseta in prvega harmonika kako
% se spreminja od ekscentricnosti ki jo vpises kot vhod
%
% 2018.07.02 dodal da se mi shrani v mapo na racunalniku
% 2018.07.18 poravil da sharnim ?e �elim, pri meritvah ni y skale pri amp
% in off
function potek_sincos_nalozi_struct(podatki,shrani)

meritev=inputname(1);
filename= ...
    ['C:\Users\mitja\Documents\Magistrsko_delo\Diploma_Latex_v2\Slike\', ...
    upper(meritev(1:3)), '\', meritev(end-1:end),'_'];

tx = '\Delta ';

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
y1stPh(y1stPh<-180) = y1stPh(y1stPh<-180)+360;
y1stPh(y1stPh>180) = y1stPh(y1stPh>180)-360;
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

legend('sin','cos','Location','northeast')
grid on
xlabel([tx ' / mm'])
if ~strfind(meritev,'mer')
ylabel('B / mT')
end
if exist('shrani')
    if shrani
        saveas(gcf,[filename, 'sincos_phase'],'epsc')
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


legend('sin','cos','Location','northeast')
grid on
xlabel([tx ' / mm'])
if ~strfind(meritev,'mer')
ylabel('B / mT')
end
if exist('shrani')
    if shrani
        saveas(gcf,[filename, 'sincos_phase'],'epsc')
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

legend('sin','cos','Location','northeast')
grid on
xlabel([tx ' / mm'])
ylabel('fazni zamik / ^\circ')
if exist('shrani')
    if shrani
        saveas(gcf,[filename, 'sincos_phase'],'epsc')
    end
end




clear axes1 scrsz meritev x y1st yOff tx y1stPh

end