 clear  amp_sin amp_cos ofset_sin ofset_cos

% tip='sim_real_polje';
tip='meritev';
eks='xd';
x=linspace(0,360,1000);     % x os je v stopinjah imamo po 1000 tock kot v .mat datotekah
addpath('C:\Users\mitja\Documents\Magistrsko_delo\Za_slike');
path_script=which('narisi_grafe_potekov_ekscentricnosti');	% pot do skripte

    path_file=path_script(1:end-38);                          	% pot do mape

    path_mat_dat=strcat(path_file,'mat_datoteke\');             % pot do mape mat_dat

    isci_string=strcat(tip,'_',eks);               %sestavi ime ki je ime structa

    list=dir(path_mat_dat);                                     % izpis datotek v mapi mat_dat

    stevec=1;                                                   % stevec za elemente v matriki in pobrisi matriki da bos lahko notri vpisova
    clear amplitude oddaljenost
    eval(['cd ', path_mat_dat])                                 % preseli se v mapo
    for i=1:max(size(list))                                     % pojdi cez datoteke
        
        ime=list(i).name;                                       % dobi ime datoteke

        if strfind(ime,isci_string)                             % ali ime datoteke vsebuje isci_string
 
        load(ime);                                          % nalozi zeljeno .mat datoteko
        eval(strcat('tmp=',ime(1:end-4),';'))
         
        [c0_sin,~,~,c_sin,fi_sin] = fourier(x,tmp.analog_sinus,1,0);
        [c0_cos,~,~,c_cos,fi_cos] = fourier(x,tmp.analog_cosinus,1,0);
        ofset_sin(stevec)=c0_sin;
        ofset_cos(stevec)=c0_cos;
        
        amp_sin(stevec)=c_sin;
        amp_cos(stevec)=c_cos;
        eval(['clear ',ime(1:end-4),'tmp'])                       % clear nalozen struct
        stevec=stevec+1;                                    % povecaj index v matriki
        end
    end
    
  eval(strcat(tip,'_','ofset_sin=ofset_sin;'))
  eval(strcat(tip,'_','ofset_cos=ofset_cos;'))
  eval(strcat(tip,'_','amp_sin=amp_sin;'))
  eval(strcat(tip,'_','amp_cos=amp_cos;'))
    
    figure
    plot(ofset_sin)
    hold on
    plot(ofset_cos)
    figure
    plot(amp_cos)
    hold on
    plot(amp_sin)