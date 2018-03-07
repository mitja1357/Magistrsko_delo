function primerjava_harmonikov(eks,harmonik)
    load('Rezultati_meritve.mat')
    load('Rezultati_simulacij.mat')
    
    eval(strcat('liny=lin_',eks,'.fft_protocola(:,',num2str(harmonik+1),');'))
    eval(strcat('linx=lin_',eks,'.displacement',';'))
    
    eval(strcat('realy=real_',eks,'.fft_protocola(:,',num2str(harmonik+1),');'))
    eval(strcat('realx=real_',eks,'.displacement',';'))
    
    eval(strcat('meritevy=meritev_',eks,'.fft_protocola(:,',num2str(harmonik+1),');'))
    eval(strcat('meritevx=meritev_',eks,'.displacement',';'))
    
    analitikax=analitika.displace;
    
    
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
    
    plot(linx,liny,realx,realy,meritevx,meritevy,analitikax,analitikay,'LineWidth',2)
    axis([0 0.4 -inf inf])
    grid on
    legend('lin','real','meritev','analika')
    
    
    
    
    

    

 








end

