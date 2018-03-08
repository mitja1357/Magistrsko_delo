theta=linspace(0,360,1000);
eks={'xs','ys','xd','yd'};


for j=1:4
    ekcentric=eks{j};

    r0=2.4;
    xs=0;
    ys=0;
    xd=0;
    yd=0;

    displace=0:25e-3:500e-3;
    RM44_lin_all=[];
    Sin_all=[];
    Cos_all=[];
    Ref_all=[];
    for i=displace
        eval(strcat(ekcentric,'=i;'))
        Sin= r0*sind(theta)+xs.*cosd(theta)+ys.* sind(theta)-xd;
        Sin_all=[Sin_all;Sin];
        Cos= r0*cosd(theta)+xs.*cosd(theta)+ys.* sind(theta)-xd;
        Cos_all=[Cos_all;Cos];

        RM44_lin=atan2d(Sin,Cos);
        RM44_lin((find(diff(RM44_lin)<-90)+1):end)=RM44_lin((find(diff(RM44_lin)<-90)+1):end)+360;
        RM44_lin_all=[RM44_lin_all;RM44_lin];
        Ref_all=[Ref_all; theta];
        
    end
    clear i RM44_lin Sin Cos

    protocol_lin_all=RM44_lin_all-theta;
    

    
    tmp=struct;
    
    tmp.protocol=protocol_lin_all;
    tmp.sin=Sin_all;
    tmp.cos=Cos_all;
    tmp.displacement=displace';
    tmp.ref=Ref_all;

    eval(strcat('lin_',ekcentric,'=tmp;'));

end


clear j L T Fs n dim Y P2 P1 tmp X_tmp Y_tmp Zmesh ekcentric RM44_lin_all 
clear protocol_lin_all fft_lin_all Sin_all Cos_all displace xd xs yd ys 
clear Ref_all theta r0 eks ans

