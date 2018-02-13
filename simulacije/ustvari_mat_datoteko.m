
function ustvari_mat_datoteko(ekscentricnost, velikost)

if velikost>1
    display('problem s zapisom .mat datoteke ker je ekscentricnost vecja od 1mm. Zadeva se je kljub temu izpisala')
end

velikost=round(velikost*1000)/1000;     % zaokrozi na mikrometer
switch ekscentricnost
    case 'xs'
        xs=velikost;
        ys=0;
        xd=0;
        yd=0;

    case 'ys'
        xs=0;
        ys=velikost;
        xd=0;
        yd=0;

    case 'xd'
        xs=0;
        ys=0;
        xd=velikost;
        yd=0;
        
        
    case 'yd' 
        xs=0;
        ys=0;
        xd=0;
        yd=velikost;
        
end


theta=linspace(0,2*pi,1000);

r0=2.4;
koliko_harmonikov=8;



[kot_merjeni,absA,kotA,Bx,By,~,~]=vrednost_polja(theta,r0,xs,ys,xd,yd,koliko_harmonikov,0);


stevilka_v_imenu=num2str(velikost*1000);
switch size(stevilka_v_imenu,2)
    case 1
        stevilka_v_imenu=strcat('00',stevilka_v_imenu);
    case 2
        stevilka_v_imenu=strcat('0',stevilka_v_imenu);
        
    case 3
        stevilka_v_imenu=stevilka_v_imenu;
end
    napaka=kot_merjeni-theta;
    
    
    
    while mean(napaka)>pi/4
        napaka=napaka-pi/2;
        absA(1)=absA(1)-90;
    end
    while mean(napaka)<-pi/4
        napaka=napaka+pi/2;
        absA(1)=absA(1)+90;
    end
    tmp=struct;

    tmp.analog_sinus=By;                        % 2017.10.11 zamenjal Bx in By prej:tmp.analog_sinus=By;
    tmp.analog_cosinus=Bx;
    tmp.napaka=(napaka)/(2*pi);      % v per unit
    tmp.fft_napake=absA /360 ;           % v per unit
    tmp.fi=kotA/360;                        % v per unit
    
    tmp.oddaljenost=velikost;% da je oddaljenost v mm
    
    ime_structa=strcat('sim_lin_polje_',ekscentricnost,'_',stevilka_v_imenu,'u')
    
    eval(strcat(ime_structa,'=tmp;'));
    
    

    save(strcat('Z:\Home\Magistrsko_delo\Za_slike\mat_datoteke\',ime_structa),ime_structa)
    
    
    
end

