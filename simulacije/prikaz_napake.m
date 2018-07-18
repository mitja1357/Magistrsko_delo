% Mitja Alic
% Notranje Gorice 2018.07.16
% funkcija narise analogna signala napako in fft od izbrane ekscentri?nosti
% in velikosti
% meritev to zelimo
%
% 2018.07.02 dodal da se mi shrani v mapo na racunalniku
function prikaz_napake(meritev, eks, shrani)
%%
load Rezultati_simulacij.mat
load Rezultati_meritve.mat

%  meritev = 'meritev_xs';
%  eks = 0.0;

filename= ...
    ['C:\Users\mitja\Documents\Magistrsko_delo\Diploma_Latex_v2\Slike\', ...
    upper(meritev(1:3)), '\', meritev(end-1:end),'_'];

eval(strcat('podatki=',meritev,';'))

[fitresult, gof] = createFits(Ref, Sin, Cos, 1);

disp(strvcat({'      Offset          Amp       Faza',...
                ['Sin |',num2str(fitresult{1}.a0),'   ',num2str(fitresult{1}.a1),'   ',num2str(fitresult{1}.f1-fitresult{2}.f1)],...
                ['Cos |',num2str(fitresult{2}.a0),'   ',num2str(fitresult{2}.a1),'   '],...
                }))

Ref = Ref - Ref(1);

Ref(Ref<0) = Ref(Ref<0) +360;

Err = atan2d(Sin,Cos)-Ref;

Err(Err < -180) = Err(Err < -180) +360;
Err(Err >  180) = Err(Err > 180) -360;









fftp= mojfft(Err);

y = fftp{1}(1:5);
y(1)=y(1).*cosd(fftp{2}(1));


%%
scrsz = get(0,'ScreenSize');

figure('Name', [meritev, ' ', num2str(eks), ' sin cos'] ,'Position', ...
       [10 scrsz(4)-10-80-600 800 600]);
axes1 = axes('Parent',gcf,...
        'YGrid','on',...
        'XGrid','on',...
        'FontSize',16,...
        'FontName','Times New Roman');
plot(Ref, Sin, Ref, Cos, 'LineWidth',2);
legend('sin','cos','Location','northwest')
axis( [0,360,-Inf,Inf])
grid on
xlabel(' \theta / ^\circ')

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
xlabel(' \theta / ^\circ')
ylabel('\epsilon / ^\circ')
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
xlabel(' harmonik')
ylabel('\epsilon / ^\circ')

if exist('shrani')
    if shrani
        saveas(gcf,[filename, 'fft'],'epsc')
    end
end
%%
clear lin_xs lin_xd lin_ys lin_yd real_xs real_xd real_ys real_yd ...
    meritev_xs meritev_ys meritev_xd meritev_zs
clear meritev podatki tx fftp y x scrsz axes1

end
