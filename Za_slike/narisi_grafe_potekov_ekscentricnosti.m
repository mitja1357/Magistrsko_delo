% 2017.10.4 Mitja Alic magistrsko delo
% 
% 
% 
% Funkcija izrise potek amplitude harmonikov v odvistnosti od velikosti 
% ekscentricnosti.
% 
% Vhod funkcije je izbira tipa (modeli iz simulacij ali meritev), 
% katero ekscentricnost(eks), ter array katerih harmonikov(0 je offset)
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
% % eks='zs';
% 
% in
% 
% katere_harmonike_zelis=[0,1,2,3];
% narisi_grafe_potekov_ekscentricnosti(tip,eks,katere_harmonike_zelis);


function [koeficienti]= narisi_grafe_potekov_ekscentricnosti(tip,eks,katere_harmonike_zelis)


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% ali obstaja ekscentricnost za izbrani model %%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    switch tip               
        case 'meritev'
            if strcmp(eks,'yd')
                warning('Ekscentricnost za meritev ni bila pomerjena. Slika prikazuje ekscentricnost xd');
                eks='xd';
            end
        
        case 'sim_lin_polje'
            if strcmp(eks,'zs')
                error('Ekscentricnost za sim_lin_polje ni bila simulirana.');
            end        
        
        case 'sim_real_polje'
            if strcmp(eks,'zs')
                error('Ekscentricnost za sim_lin_polje ni bila simulirana.');                        
            end
        
    end



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
      
        % oddaljenost(stevec)=str2num(ime(end-7:end-5)).*1e-3;% iz imena vzemi oddaljenost in jo daj v mm
        eval(strcat('oddaljenost(stevec)=',ime(1:end-3),'oddaljenost;'));   % zapisi oddaljenost v mm
        eval(strcat('amplitude(stevec,:)=',ime(1:end-3),'fft_napake;')) % shrani amplitude v matriko
        
        eval(['clear ',ime(1:end-4)])                       % clear nalozen struct
       
        stevec=stevec+1;                                    % povecaj index v matriki
        end
    end

    eval(['cd ', path_file])                                    % vrni se nazaj v mapo skripte

    amplitude(:,1)=amplitude(:,1)-amplitude(1,1);               % offset-e premakni tako da bo v izhodiscu nicla

    clear i ime list stevec isci_string;                        %pobrisi uporabljene spremenljivke
   koeficienti=cell(1);
   stevec=1;
    for i=katere_harmonike_zelis
        
        koeficienti{stevec}= metoda_najmanjsih_kvadratov_polinom(oddaljenost', amplitude(:,i+1),3);
        koeficienti{stevec}= koeficienti{stevec}*360;
        stevec=stevec+1;
    end

    %%%%%%%%%%%%%
    %%% slike %%%
    %%%%%%%%%%%%%
    
    FigHandle=figure;
    set(FigHandle, 'Position', [100, 100, 960, 720]);
%     set(gca, 'ColorOrder', jet(length(katere_harmonike_zelis)), 'NextPlot', 'replacechildren');
    
   
    hold on
    st=1;
    imena_za_legendo=cell(size(katere_harmonike_zelis,2),1);    % definiraj prostor za imena v legendi
    for i=katere_harmonike_zelis
        plot(oddaljenost,amplitude(:,i+1)*360);   % narisi poteke s nastavljenimi barvami
        
        
        imena_za_legendo{st}=['Harm ',num2str(i)];              % zapisi ime harmonika ki si ga narisal
        if i==0                                                 % ce je enosmerna komponenta naj se zapise Enosmerna komp.
            imena_za_legendo{st}='Enosmerna komp.';
        end
        st=st+1;
        
    
    end
    
    ylabel('amplituda harmonika napake / ^\circ')
    xlabel('ekscentricnost / mm')
    
    
    legend(imena_za_legendo,'Location','NorthWest')
    grid on
    saveas(gcf,strcat('Z:\Home\Magistrsko_delo\Diploma_Latex_v2\Slike\potek_',tip,'_',eks),'epsc')
end