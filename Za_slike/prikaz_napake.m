% Mitja Alic
% Notranje Gorice 2018.07.16
% funkcija narise analogna signala napako in fft od izbrane ekscentri?nosti
% in velikosti
% meritev
%
% 2018.07.02 dodal da se mi shrani v mapo na racunalniku
function prikaz_napake(meritev, eks, shrani)
%%
load real_diferencialnesonde.mat
load Rezultati_meritve.mat

%  meritev = 'meritev_xs';
%  eks = 0.0;
pathfolder = pwd;
allSlash = strfind(pathfolder, '\');

filename= [pathfolder(1:allSlash(end)), ...
    'Diploma_Latex_v2\Slike\', ...
    upper(meritev(1:3)), '\', meritev(end-1:end),'_'];
if eks == 0
    filename= [pathfolder(1:end-10), ...
    'Diploma_Latex_v2\Slike\', ...
    upper(meritev(1:3)), '\00_'];
end

eval(strcat('podatki=',meritev,';'))
%%
el = find(min(abs(podatki.displacement-eks))==abs(podatki.displacement-eks));
Ref = podatki.ref(el,:);
Err = podatki.protocol(el,:);

Sin = podatki.sin(el,:);
Cos = podatki.cos(el,:);
fftp= mojfft(Err);
fftS = mojfft(Sin);
fftC = mojfft(Cos);
display(strvcat('          S        C',...
    ['off | ', num2str([fftS{1}(1)*cosd(fftS{2}(1)),fftC{1}(1)*cosd(fftC{2}(1))],' %.2e')],...
    ['1st | ', num2str([fftS{1}(2),fftC{1}(2)],' %.2e')]))
y = fftp{1}(1:5);
y(1)=y(1).*cosd(fftp{2}(1));



scrsz = get(0,'ScreenSize');

figure('Name', [meritev, ' ', num2str(eks), ' sin cos'] ,'Position', ...
       [10 scrsz(4)-10-80-600 800 600]);
axes1 = axes('Parent',gcf,...
        'YGrid','on',...
        'XGrid','on',...
        'FontSize',16,...
        'FontName','Times New Roman');
plot(Ref, Sin, Ref, Cos, 'LineWidth',2);
legend('B_{sin}','B_{cos}','Location','northeast')
axis( [0,360,-Inf,Inf])
grid on
xlabel(' $\theta / ^\circ$','interpreter','latex')
if isempty(strfind(meritev,'mer'))
    ylabel('$B$ / mT','interpreter','latex')
end
if exist('shrani')
    if shrani
        saveas(gcf,[filename, 'sincos'],'epsc')
    end
end

figure('Name', [meritev, ' ', num2str(eks), ' napaka'] ,'Position', ...
       [10 scrsz(4)-10-80-600 800 600]);
axes1 = axes('Parent',gcf,...
        'YGrid','on',...
        'XGrid','on',...
        'FontSize',16,...
        'FontName','Times New Roman');
plot(Ref, Err, 'LineWidth',2);
axis( [0,360,-Inf,Inf])
grid on
xlabel(' $\theta / ^\circ$','interpreter','latex')
ylabel('$\varepsilon / ^\circ$', 'interpreter','latex')
if exist('shrani')
    if shrani
        saveas(gcf,[filename, 'napaka'],'epsc')
    end
end
figure('Name', [meritev, ' ', num2str(eks), ' fft'] ,'Position', ...
       [10 scrsz(4)-10-80-600 800 600]);
axes1 = axes('Parent',gcf,...
        'YGrid','on',...
        'XGrid','on',...
        'FontSize',16,...
        'FontName','Times New Roman');
bar(0:4, y, 'LineWidth',2);
% axis( [0,4,-Inf,Inf])
grid on
xlabel('harmonik')
ylabel('$\varepsilon / ^\circ$', 'interpreter','latex')

if exist('shrani')
    if shrani
        saveas(gcf,[filename, 'fft'],'epsc')
    end
end
%%
clear lin_xs lin_xd lin_ys lin_yd real_xs real_xd real_ys real_yd ...
    meritev_xs meritev_ys meritev_xd meritev_zs
clear meritev podatki tx fftp y x scrsz axes1
%%
end
