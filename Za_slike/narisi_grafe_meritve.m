% 2017.10.3 Mitja Alic magistrsko delo
% 
% 
% Funkcija izrise grafe analognih signalov, napake med RM44 in referencnim
% senzorjem ter vrednosti amplitud posameznega harmonika napake (dft napake
% prvih osem harmonikov). V mapi s to funkcijo mora biti mapa mat_datoteke v
% kateri so .mat datoteke s shranjenimi podatki posameznih rezultatov.
% 
% Funkcija za vhodni parameter vzame tip ali je bila meritev ali
% simulacija, eks katera ekscentricnost, in velikost ekscentricnosti v mm
% 
% 
% Primer:
% model='meritev'; ali
% model='sim_lin_polje'; ali
% model='sim_real_polje';
% 
% in
% 
% ekscentricnost='xs'; ali
% ekscentricnost='xd'; ali
% ekscentricnost='ys'; ali
% ekscentricnost='yd'; ali
% ekscentricnost='zs';
% 
% in
% 
% oddaljenost= 0.265;
% 
% narisi_grafe_meritve(tip, eks,oddaljenost);

function narisi_grafe_meritve(tip, eks,oddaljenost)



    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% preveri ali imas podatke %%%
    %%%%%% za izracun navora %%%%%%
    %%%%%%%% v bazi meritev %%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    switch tip
        case 'meritev'
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
            
            
            
            
            
        case 'sim_lin_polje'
            oddaljenost=round(oddaljenost*40)/40;
            if oddaljenost>0.5
                oddaljenost=0.5;
                warning('Najvecja pomerjenea ekscentricnost je 0.50 mm katera je tudi prikazana');
            end
            if oddaljenost<=0
                oddaljenost=0;
                warning('Najmanjsa pomerjenea ekscentricnost je 0.00mm katera je tudi prikazana');
                
            end
            
            if strcmp(eks, 'zs')
                error('Podatki za zeljene rezultate ne obstajajo.')
            end
            
            
        case 'sim_real_polje'
            oddaljenost=round(oddaljenost*40)/40;
            if oddaljenost>0.5
                oddaljenost=0.5;
                warning('Najvecja pomerjenea ekscentricnost je 0.50 mm katera je tudi prikazana');
            end
            if oddaljenost<=0
                oddaljenost=0;
                warning('Najmanjsa pomerjenea ekscentricnost je 0.00mm katera je tudi prikazana');
                
            end
            
            if strcmp(eks, 'zs')
                error('Podatki za zeljene rezultate ne obstajajo.')
            end
        otherwise
            error('Vpisali ste napacen tip.')
        

        
        
        
    end
    
    

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%% sestavi ime structa %%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% doloci poti do datotek %%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    stevilka=num2str(oddaljenost*1000);
    if oddaljenost==0;
        stevilka='000';
    end
    ime_structa=strcat(tip,'_',eks,'_',stevilka,'u.mat');


    path_script=which('narisi_grafe_meritve');              % pot do skripte

    path_file=path_script(1:end-22);                          	% pot do mape

    path_mat_dat=strcat(path_file,'mat_datoteke\');             % pot do mape mat_dat

    filename=strcat(path_mat_dat,ime_structa);


    load(filename)


    eval(strcat('tmp=',ime_structa(1:end-4),';'));   % struct shrani v struct z imenom tmp

    eval(['clear ', ime_structa ]);         % pobrisi uvozen struct; sedaj je v tmp


    %%%%%%%%%%%%%%%%%%%%%%%%
    %%% definicija x osi %%%
    %%%%%%%%%%%%%%%%%%%%%%%%

    x=linspace(0,360,1000);     % x os je v stopinjah imamo po 1000 tock kot v .mat datotekah


    % ko je senzor oz magnet v centru se lahko s zeroingom odstrani
    % enosmerno komponento
    if oddaljenost==0

        tmp.napaka=tmp.napaka-tmp.fft_napake(1);
        tmp.fft_napake(1)=0;
    end
    
    %%%%%%%%%%%%%
    %%% slike %%%
    %%%%%%%%%%%%%        


    %Sin_cos

    figure
    plot(x,tmp.analog_sinus)
    hold on
    plot(x,tmp.analog_cosinus,'r')
    legend('sin','cos')


    xlabel('kot zasuka / ^\circ')
    ylabel('B / mT')
    grid on
    xyaxis=axis;
    axis([0,360,xyaxis(3),xyaxis(4)])


    %napaka


    figure
    plot(x,(tmp.napaka)*360)
    xlabel('kot zasuka / ^\circ')
    ylabel('napaka / ^\circ')
    grid on
    xyaxis=axis;
    axis([0,360,xyaxis(3),xyaxis(4)])


    %fft_napake

    figure
    bar(0:8,tmp.fft_napake*360)
    xlabel('harmonik')
    ylabel('amplituda harmonika napake / ^\circ')
    grid on

    
   
end