% Primer:
% tip='meritev'; ali
% tip='lin'; ali
% tip='real';
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
% katere_harmonike_zelis=[0,1,2,3,4];
% narisi_grafe_potekov_ekscentricnosti(tip,eks,katere_harmonike_zelis);
%

function S=narisi_grafe_potekov_ekscentricnosti(tip,eks,katere_harmonike_zelis)

    switch tip               
        case 'meritev'
            if strcmp(eks,'yd')
                warning('Ekscentricnost za meritev ni bila pomerjena. Slika prikazuje ekscentricnost xd');
                eks='xd';
            end
        
        case 'lin'
            if strcmp(eks,'zs')
                error('Ekscentricnost za sim_lin_polje ni bila simulirana.');
            end        
        
        case 'real'
            if strcmp(eks,'zs')
                error('Ekscentricnost za sim_lin_polje ni bila simulirana.');                        
            end
        
    end
    
     %% get right data
    
    if strfind(tip,'meri')
        load('Rezultati_meritve.mat');
    else
        load('Rezultati_simulacij.mat');
    end
    
    eval(strcat('tmp=',tip ,'_',eks,';'))
    
    clear meritev_xs meritev_ys meritev_xd meritev_zs
    clear analitika lin_xs lin_ys lin_xd lin_xs lin_yd
    clear real_xs real_ys real_xd real_yd
    
    %% fft_napake    
    tmpfft=mojfft(tmp.protocol);
    fft_protocola=tmpfft{1};
    scrsz = get(0,'ScreenSize');
    fft_protocola(:,1)=fft_protocola(:,1)-fft_protocola(1,1);
    fft_fig=figure('Position',[10 scrsz(4)-10-80-600 800 600]);
    plot(tmp.displacement,fft_protocola(:,(katere_harmonike_zelis+1)),'LineWidth',2)
    xlabel('ekscentriènost / mm', 'FontSize', 16,'FontName','Times New Roman')
    ylabel('amplituda harmonika napake / ^\circ', 'FontSize', 16,'FontName','Times New Roman')
    grid on
    hold off
    title(strcat(tip,' -   ',eks))
    st=1;
%     imena_za_legendo=cell(size(katere_harmonike_zelis,2),1);    % definiraj prostor za imena v legendi
    for i=katere_harmonike_zelis
        imena_za_legendo{st}=['Harm ',num2str(i)];              % zapisi ime harmonika ki si ga narisal
        if i==0                                                 % ce je enosmerna komponenta naj se zapise Enosmerna komp.
            imena_za_legendo{st}='Enosmerna komp.';
        end
        st=st+1;
    end
    legend(imena_za_legendo,'Location','NorthWest', 'FontSize', 16,'FontName','Times New Roman')
    
    
    
    if size(tmp.displacement,1)~=length(tmp.displacement)
        tmp.displacement=tmp.displacement';
    end
    
    
    S='';
    for i=katere_harmonike_zelis
        P = polyfit(tmp.displacement,fft_protocola(:,i+1),3);
        
        latex_eks=strcat(eks(1),'_',eks(2));
        for j=1:4
            if (sign(P(j))+1)&&i>1
                predznak='+';
            else
                predznak='';
            end
            S=[S predznak num2str(P(j),'%.3f') ' ' latex_eks '^{' num2str(4-j) '}'];
        end
        S=strcat(S(1:end-8),' \\ ');
    end
    S(strfind(S,'.'))=','; %decimal comma
        
    
end