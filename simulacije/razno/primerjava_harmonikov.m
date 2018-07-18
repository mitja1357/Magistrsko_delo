function primerjava_harmonikov(eks,harmonik)
    load('Rezultati_meritve.mat')
    load('Rezultati_simulacij.mat')
    
    eval(strcat('liny=lin_',eks,'.protocol;'))
    eval(strcat('linx=lin_',eks,'.displacement',';'))
    
    eval(strcat('realy=real_',eks,'.protocol;'))
    eval(strcat('realx=real_',eks,'.displacement',';'))
    
    eval(strcat('meritevy=meritev_',eks,'.protocol;'))
    eval(strcat('meritevx=meritev_',eks,'.displacement;'))
    
    analitikax=analitika.displace;
    tmp=mojfft(liny);
    liny=tmp{1};
    tmp=mojfft(realy);
    realy=tmp{1};
    tmp=mojfft(meritevy);
    meritevy=tmp{1};
    
    eval(strcat('analitikaya=analitika.',eks,'.A_',num2str(harmonik),';'))
    if harmonik>0
        eval(strcat('analitikayb=analitika.',eks,'.B_',num2str(harmonik),';'))
        analitikay=sqrt(analitikaya.^2+analitikayb.^2);
    else
        analitikay=analitikaya;    
    end
    
    
    
    
    if harmonik==0
        liny=liny-liny(1);
        realy=realy-realy(1);
        meritevy=meritevy-meritevy(1);
    end
    
    plot(linx,liny(:,harmonik+1),realx,realy(:,harmonik+1),...
        meritevx,meritevy(:,harmonik+1),analitikax,analitikay,'LineWidth',2)
    axis([0 0.4 -inf inf])
    grid on
    legend('lin','real','meritev','analika')
    
    
    
    
    

    

 








end

