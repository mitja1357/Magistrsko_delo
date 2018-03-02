% 2018.3.1 Mitja Alic
% 
% Skripta izrise potek amplitude dolocenega harmonika
% 
% Input
% eks='xs'; ali
% eks='ys'; ali
% eks='xd';
% 
% kateri_harmonik=1; oziroma 0:8

function narisi_primerjave_potekov(eks,kateri_harmonik)

    path_script=which('narisi_primerjave_potekov');	% pot do skripte
    path_file='Z:\Home\Magistrsko_delo\Za_slike';                          	% pot do mape
    path_mat_dat=strcat(path_file,'\mat_datoteke');             % pot do mape mat_dat
    
    list=dir(path_mat_dat);                                     % izpis datotek v mapi mat_dat
    real=struct;
    lin=struct;
    meritve=struct;
    real.amp=[];
    lin.amp=[];
    meritve.amp=[];
    real.odd=[];
    lin.odd=[];
    meritve.odd=[];
    
    eval(['cd ', path_mat_dat])                                 % preseli se v mapo
    for i=1:max(size(list))                                     % pojdi cez datoteke
        ime=list(i).name;
        if strfind(ime,eks)
           if strfind(ime,'real')
            load(ime)
            eval(strcat('real.amp=[real.amp;',ime(1:end-3),'fft_napake];'))
            eval(strcat('real.odd=[real.odd;',ime(1:end-3),'oddaljenost];'));
           elseif strfind(ime,'lin')
               load(ime)
               eval(strcat('lin.amp=[lin.amp;',ime(1:end-3),'fft_napake];'))
               eval(strcat('lin.odd=[lin.odd;',ime(1:end-3),'oddaljenost];'));
           elseif strfind(ime,'merit')
               load(ime)
               eval(strcat('meritve.amp=[meritve.amp;',ime(1:end-3),'fft_napake];'))
               eval(strcat('meritve.odd=[meritve.odd;',ime(1:end-3),'oddaljenost];'));
           end
           if exist(ime)
               eval(['clear ',ime(1:end-4)])                       % clear nalozen struct
           end
        end
    end
    

    eval(['cd ', path_file])                                    % vrni se nazaj v mapo skripte

    meritve.amp(:,1)=meritve.amp(:,1)-meritve.amp(1,1);
    lin.amp(:,1)=lin.amp(:,1)-lin.amp(1,1);
    real.amp(:,1)=real.amp(:,1)-real.amp(1,1);
    clear i ime list stevec isci_string path_file path_mat_dat path_script;                        %pobrisi uporabljene spremenljivke
  

    %%%%%%%%%%%%%
    %%% slike %%%
    %%%%%%%%%%%%%

    
    FigHandle=figure;
    set(FigHandle, 'Position', [100, 100, 960, 720]);
%     set(gca, 'ColorOrder', jet(length(katere_harmonike_zelis)), 'NextPlot', 'replacechildren');
        
   
    hold on
    i=kateri_harmonik;
   
        plot(lin.odd,lin.amp(:,i+1)*360,'LineWidth',2);
        plot(real.odd,real.amp(:,i+1)*360,'LineWidth',2);   % narisi poteke s nastavljenimi barvami
        plot(meritve.odd,meritve.amp(:,i+1)*360,'LineWidth',2);
       
    ylabel('amplituda harmonika napake / ^\circ','FontSize', 16)
    xlabel('ekscentriènost / mm','FontSize', 16)
    axis([0 0.5 -inf inf]);
    
    
    lgd=legend('linearno polje','realno polje','meritev','Location','NorthWest');
    lgd.FontSize=16;
    grid on
    saveas(gcf,strcat('Z:\Home\Magistrsko_delo\Diploma_Latex_v2\Slike\primerjava_',eks,'_',num2str(i)),'epsc')
end