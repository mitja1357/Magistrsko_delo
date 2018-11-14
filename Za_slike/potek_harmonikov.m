% Mitja Alic
% Notranje Gorice 2018.06.29 
% funkcija narise graf potekov prvih stirih harmonikov glede na katero
% meritev to zelimo
%
% 2018.07.02 dodal da se mi shrani v mapo na racunalniku
% 2018.10.11 popravil directorij kam se shranjujejo slike
function potek_harmonikov(meritev)
% load Rezultati_simulacij.mat
load Rezultati_meritve.mat
load real_diferencialnesonde.mat

% meritev = 'lin_ys';
pathfolder = pwd;
allSlash = strfind(pathfolder, '\');

filename= [pathfolder(1:allSlash(end)), ...
    'Diploma_Latex_v2\Slike\', ...
    upper(meritev(1:3)), '\', meritev(end-1:end),'_'];

eval(strcat('podatki=',meritev,';'))

tx = ['\Delta ',meritev(end-1),'_',meritev(end)];
protokol = atan2d(podatki.sin,podatki.cos)-podatki.ref;
protokol(protokol > 180) = protokol(protokol > 180) -360;
protokol(protokol <-180) = protokol(protokol <-180) +360;

if strfind(meritev,'merit')
    fftp= createFit(podatki.ref, protokol);
else
    fftp= mojfft(protokol);
end
y = fftp{1}(:, 1:5);
y(:,1)=y(:,1).*cosd(fftp{2}(:, 1));
x = [podatki.displacement,podatki.displacement,podatki.displacement,podatki.displacement,podatki.displacement];


%%
scrsz = get(0,'ScreenSize');
figure('Name', meritev ,'Position', ...
       [10 scrsz(4)-10-80-600 800 600]);
axes1 = axes('Parent',gcf,...
        'YGrid','on',...
        'XGrid','on',...
        'FontSize',16,...
        'FontName','Times New Roman');
plot(x,y,'LineWidth',2);
legend('C_0','C_1','C_2','C_3','C_4','Location','northwest')
axis( [0,0.5,-Inf,Inf])
grid on
xlabel(['$', tx,'$ / mm'],'interpreter','latex')
ylabel('$\varepsilon / ^\circ$', 'interpreter','latex')
saveas(gcf,[filename, 'potek'],'epsc')
clear lin_xs lin_xd lin_ys lin_yd real_xs real_xd real_ys real_yd ...
    meritev_xs meritev_ys meritev_xd meritev_zs
clear meritev podatki tx fftp y x scrsz axes1

end
