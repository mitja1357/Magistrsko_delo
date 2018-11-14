
load Rezultati_meritve.mat
load real_diferencialnesonde.mat
vsi_eks = {'xs', 'ys', 'xd'};
 meritev = {'lin_', 'real_', 'meritev_'};
for j = 1:3
    eks = vsi_eks{j};
   
    for i = 1:3

        eval(strcat('podatki=',meritev{i},eks,';'))

        tx = ['\Delta ',eks(1),'_',eks(end)];
        protokol = atan2d(podatki.sin,podatki.cos)-podatki.ref;
        protokol(protokol > 180) = protokol(protokol > 180) -360;
        protokol(protokol <-180) = protokol(protokol <-180) +360;

        if strfind(meritev{i},'merit')
%             fftp= mojfft(protokol);
            fftp= createFit(podatki.ref, protokol);
        else
            fftp= mojfft(protokol);
        end
        y{i} = fftp{1}(:, 1:5);
        y{i}(:,1)=y{i}(:,1).*cosd(fftp{2}(:, 1));
        x{i} = [podatki.displacement,podatki.displacement,podatki.displacement,podatki.displacement,podatki.displacement];
    end

    %%

    ax_max = max([max(y{1}(:)),max(y{2}(:)),max(y{3}(:))]);
    ax_min = min([min(y{1}(:)),min(y{2}(:)),min(y{3}(:))]);
    naslov = {'Linearno polje', 'Realno polje', 'Meritev'};
    velikost_besedila = 20;
    ime_besedila = 'Times New Roman';
    figure('Position', [1,41,1920, 963])
    
    ax1 = subplot(1,3,1,'FontSize', velikost_besedila,'FontName', ime_besedila);
    
    
    plot(x{1}, y{1},'LineWidth',2)

    legend('C_0','C_1','C_2','C_3','C_4','Location','northwest')
    axis( [0,0.5,-Inf,Inf])
    grid on
    title(naslov{1})
    xlabel(['$', tx,'$ / mm'],'interpreter','latex')
    ylabel('$\varepsilon / ^\circ$', 'interpreter','latex')
    
    ax2 = subplot(1,3,2,'FontSize', velikost_besedila,'FontName', ime_besedila);
    
    plot(x{2}, y{2},'LineWidth',2)   

    legend('C_0','C_1','C_2','C_3','C_4','Location','northwest')
    axis( [0,0.5,-Inf,Inf])
    grid on
    title(naslov{2})
    xlabel(['$', tx,'$ / mm'],'interpreter','latex')
    ylabel('$\varepsilon / ^\circ$', 'interpreter','latex')
    
    ax3 = subplot(1,3,3,'FontSize', velikost_besedila,'FontName', ime_besedila);
    plot(x{3}, y{3},'LineWidth',2)


    legend('C_0','C_1','C_2','C_3','C_4','Location','northwest')
    axis( [0,0.5,-Inf,Inf])
    grid on
    title(naslov{3})
    xlabel(['$', tx,'$ / mm'],'interpreter','latex')
    ylabel('$\varepsilon / ^\circ$', 'interpreter','latex')
 
    
end
    clear fftp i lin_xd lin_xs lin_ys lin_yd meritev_xd meritev_xs ...
        meritev_ys podatki protokol real_xd real_xs real_yd real_ys