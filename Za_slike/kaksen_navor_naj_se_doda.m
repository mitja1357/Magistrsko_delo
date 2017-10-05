% 4.10.2017 Mitja Alic
% funkcnija glede na vhodni podatek (ekscentricnost in oddaljenost) 
% izracuna kaksen navor naj se doda trenutnem poteku navora
% eks naj bo string, oddaljenost pa je izmik ekscentricnosti v mm
% funkcija to naredi le za podatke katere sem pomeril in ne simuliral
% primer:
% 
% eks='xs'; ali
% eks='xd'; ali
% eks='ys'; ali 
% eks='zs';
% oddaljenost=0.40; 
% 
% kaksen_navor_naj_se_doda(eks,oddaljenost);
% 


function kaksen_navor_naj_se_doda(eks,oddaljenost)

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% preveri ali imas podatke %%%
    %%%%%% za izracun navora %%%%%%
    %%%%%%%% v bazi meritev %%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    switch eks
        case 'xs'
            oddaljenost=round(oddaljenost*40)/40;
            if oddaljenost>=0.45
                oddaljenost=0.45;
                warning('Najvecja pomerjenea ekscentricnost je 0.45mm katera je tudi prikazana');
            end
            if oddaljenost<=0
                oddaljenost=0;
                warning('Najmanjsa pomerjenea ekscentricnost je 0.00mm katera je tudi prikazana');
            end
            
        case 'ys'
            
            oddaljenost=round(oddaljenost*40)/40;
            if oddaljenost>=0.425
                oddaljenost=0.425;
                warning('Najvecja pomerjenea ekscentricnost je 0.425mm katera je tudi prikazana');
            end
            if oddaljenost<=0
                oddaljenost=0;
                warning('Najmanjsa pomerjenea ekscentricnost je 0.00mm katera je tudi prikazana');
            end
        case 'xd'
            oddaljenost=round(oddaljenost*4)/4;
            if oddaljenost>=1
                oddaljenost=0.999;
                warning('Najvecja pomerjenea ekscentricnost je 1.00 mm katera je tudi prikazana');
            end
            if oddaljenost<=0
                oddaljenost=0;
                warning('Najmanjsa pomerjenea ekscentricnost je 0.00mm katera je tudi prikazana');
            end
        case 'zs'
            oddaljenost=round(oddaljenost*40)/40;
            if oddaljenost<=0
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
    
    


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%% sestavi ime structa %%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% doloci poti do datotek %%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    ime_structa=strcat('meritev_',eks,'_',num2str(oddaljenost*1000),'u.mat');


    path_script=which('kaksen_navor_naj_se_doda');              % pot do skripte

    path_file=path_script(1:end-26);                          	% pot do mape

    path_mat_dat=strcat(path_file,'mat_datoteke\');             % pot do mape mat_dat

    filename=strcat(path_mat_dat,ime_structa);

    load(filename)                                              % nalozi iskan struct

    eval(strcat('amp=',ime_structa(1:end-4),'.fft_napake;'))    % shrani fft napake in fazni kot
    eval(strcat('fi1=',ime_structa(1:end-4),'.fi;'))
    
    fi=2*pi*fi1;                                        % kot daj v radiane saj je v pu
    amp=amp*2*pi;                                       % amplitude daj v radiane za odvajanje
    
    
    
    amp_kot=amp(2:9);                                   % znebi se enosmerne komponente
    h=8;                                                % koliko harmonikov upostevaj
    J = 0.1474544 + 0.001682;                           % Vztrajnost motorja in gredi
    w=2*pi;                                             % Vrtilna hitrost je 2pi (1Hz mehanska hitrost)
    t=linspace(0,1,1000);                               % za izracun navora na eni periodi
    shrani_amplitude_pospeska=zeros(1,h);                 % matrika za shranjevanje posamezne amplitude pospeska
    cosinusni=zeros(1,1000);                            % matrika kjer bodo poteki posameznih harmoonikov 

    for i=1:h
    
        amp_posp=-(i*w)^2*amp_kot(i);                      %izracun amplitude harmonika pospeska
        shrani_amplitude_pospeska(i)=amp_posp;
        cosinusni=cosinusni+amp_posp*cos(i*w.*t+fi(i));   %kjer se izracuna poteke posameznih harmonikov
    end


    delta_M=J.*cosinusni;                           % potek pospeska krat vztrajnost


    
    %%%%%%%%%%%%%%%
    %%%% slike %%%%
    %%%%%%%%%%%%%%%
    
    figure
    plot(t*360,delta_M)
    xlabel('kot zasuka / ^\circ')
    ylabel('\Delta M / Nm')
    grid on
    xyaxis=axis;
    axis([0,360,xyaxis(3),xyaxis(4)])
%     figure
%     bar(J*abs(shrani_amplitude_pospeska))



end