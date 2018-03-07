
% 
% Primer:
% tip='meritev'; ali
% tip='sim_lin_polje'; ali
% tip='sim_real_polje';
% 
% in
% 
% eks='xs'; ali
% eks='xd'; ali
% eks='ys'; ali
% eks='yd'; ali
% eks='zs';
% 
% in
% 
% oddaljenost= 0.5;
% do_katerega_harmonika=8;
% 
% narisi_grafe_meritve(tip, eks,oddaljenost, do_katerega_harmonika);


function narisi_grafe_meritve(tip, eks,oddaljenost, do_katerega_harmonika)

%% check correct inputs
    switch tip
        case 'meritev'
            switch eks
                case 'xs'
                oddaljenost=round(oddaljenost*40)/40;
                if oddaljenost>0.45
                    oddaljenost=0.45;
                    warning('Najvecja pomerjenea ekscentricnost je 0.45mm katera je tudi prikazana');
                end
                if oddaljenost<0
                    oddaljenost=0;
                    warning('Najmanjsa pomerjenea ekscentricnost je 0.00mm katera je tudi prikazana');
                end
                case 'ys'
                    oddaljenost=round(oddaljenost*40)/40;
                    if oddaljenost>0.425
                        oddaljenost=0.425;
                        warning('Najvecja pomerjenea ekscentricnost je 0.425mm katera je tudi prikazana');
                    end
                    if oddaljenost<0
                        oddaljenost=0;
                        warning('Najmanjsa pomerjenea ekscentricnost je 0.00mm katera je tudi prikazana');
                    end
                case 'xd'
                    oddaljenost=round(oddaljenost*4)/4;
                    if oddaljenost>=1
                        oddaljenost=0.999;
                        warning('Najvecja pomerjenea ekscentricnost je 1.00 mm katera je tudi prikazana');
                    end
                    if oddaljenost<0
                        oddaljenost=0;
                        warning('Najmanjsa pomerjenea ekscentricnost je 0.00mm katera je tudi prikazana');
                    end
                case 'zs'
                    oddaljenost=round(oddaljenost*40)/40;
                    if oddaljenost<0
                        oddaljenost=0;
                        warning('Najmanjsa pomerjenea ekscentricnost je 0.00mm katera je tudi prikazana');
                    end
                    if (0.300<oddaljenost)&&(oddaljenost<0.400)
                        oddaljenost=round(oddaljenost*20)/20;
                    end
                    if oddaljenost>0.4
                        oddaljenost=round((oddaljenost+0.025)*20)/20-0.025;
                    end
                    if oddaljenost>0.925
                        oddaljenost=0.925;
                        warning('Najvecja pomerjenea ekscentricnost je 0.925mm katera je tudi prikazana');
                    end
                case 'yd'
                    error('Podatki za zeljene rezultate ne obstajajo.');
            end
        case 'sim_lin_polje'
            tip='lin';
            oddaljenost=round(oddaljenost*40)/40;
            if oddaljenost>0.5
                oddaljenost=0.5;
                warning('Najvecja pomerjena ekscentricnost je 0.50 mm katera je tudi prikazana');
            end
            if oddaljenost<0
                oddaljenost=0;
                warning('Najmanjsa pomerjenea ekscentricnost je 0.00mm katera je tudi prikazana');
            end
            if strcmp(eks, 'zs')
                error('Podatki za zeljene rezultate ne obstajajo.')
            end
        case 'sim_real_polje'
            tip='real';
            oddaljenost=round(oddaljenost*40)/40;
            if oddaljenost>0.5
                oddaljenost=0.5;
                warning('Najvecja pomerjenea ekscentricnost je 0.50 mm katera je tudi prikazana');
            end
            if oddaljenost<0
                oddaljenost=0;
                warning('Najmanjsa pomerjenea ekscentricnost je 0.00mm katera je tudi prikazana');
            end
            if strcmp(eks, 'zs')
                error('Podatki za zeljene rezultate ne obstajajo.')
            end
        otherwise
            error('Vpisali ste napacen tip.')
    end
    
    %% get right data
    
    if strfind(tip,'meri')
        load('Rezultati_meritve.mat');
    else
        load('Rezultati_simulacij.mat');
    end
    
    eval(strcat('tmp=',tip ,'_',eks,';'))
    
   % clear meritev_xs meritev_ys meritev_xd meritev_zs
    %clear analitika lin_xs lin_ys lin_xd lin_xs lin_yd
    %clear real_xs real_ys real_xd real_yd
    element=find(tmp.displacement==oddaljenost);
    
    
    
    %% analog signals
    scrsz = get(0,'ScreenSize');
    analog_fig=figure('Position',[10 scrsz(4)-10-80-600 800 600]);
    plot(tmp.ref(element,:),tmp.sin(element,:),'LineWidth',2)
    hold on
    plot(tmp.ref(element,:),tmp.cos(element,:),'r','LineWidth',2)
    legend({'sin','cos'} ,"FontSize",14);

    xlabel('dejanski kot / ^\circ', 'FontSize', 16, 'FontName','Times New Roman')
    ylabel('B / mT', 'FontSize', 14)
    grid on
    axis([0,360,-inf,inf])
    hold off
%     saveas(gcf,strcat('Slike\',ime_structa(1:end-4),'_BxBy'),'epsc')

    %% napaka
    


    protocol_fig=figure('Position',[810+20 scrsz(4)-10-80-600 800 600]);
    plot(tmp.ref(element,:),tmp.protocol(element,:)-tmp.fft_protocola(1,1),'LineWidth',2)
    xlabel('dejanski kot / ^\circ', 'FontSize', 16, 'FontName','Times New Roman')
    ylabel('napaka / ^\circ', 'FontSize', 16,'FontName','Times New Roman')
    grid on
    axis([0,360,-inf,inf])
    hold off
%     saveas(gcf,strcat('Slike\',ime_structa(1:end-4),'_napaka'),'epsc')


    %% fft_napake
    tmp.fft_protocola(element,1)=tmp.fft_protocola(element,1)-tmp.fft_protocola(1,1);
    fft_fig=figure('Position',[1930 scrsz(4)-10-80-600 800 600]);
    bar(0:do_katerega_harmonika,tmp.fft_protocola(element,(1:do_katerega_harmonika+1)))
    xlabel('harmonik', 'FontSize', 16,'FontName','Times New Roman')
    ylabel('amplituda harmonika napake / ^\circ', 'FontSize', 16,'FontName','Times New Roman')
    grid on
    hold off
%     saveas(gcf,strcat('Slike\',ime_structa(1:end-4),'_fft'),'epsc')
    
end