
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
% do_katerega_harmonika=4;
% 
% narisi_potek_navora(tip, eks,oddaljenost, do_katerega_harmonika);


function narisi_potek_navora(tip, eks,oddaljenost, do_katerega_harmonika)

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
    
    J = 0.1474544 + 0.001682;                           % Vztrajnost motorja in gredi
    
    fft_protocola=mojfft(tmp.protocol(element,:)*pi/180);
    
    theta=tmp.ref(element,:);
    w=(0:500);
    
    navoramps=-fft_protocola{1}.*((2*pi.*w).^2)';
    dodan_navor=0;
    for i=1:do_katerega_harmonika+1
       dodan_navor=dodan_navor+navoramps(i).*(cosd(w(i).*theta+fft_protocola{2}(i)));
    end
    plot(theta,dodan_navor.*J)
    hold on
    plot(theta,tmp.protocol(element,:))
    
    
    
    
   
end