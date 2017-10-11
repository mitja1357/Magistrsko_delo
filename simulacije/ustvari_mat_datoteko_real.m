

function ustvari_mat_datoteko_real(ekscentricnost, velikost,X_tmp,Y_tmp, Zmesh)

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
        xd=velikost;
        yd=0;
        
end


theta=linspace(0,2*pi,1000);

r0=2.4;
koliko_harmonikov=8;


[kot_merjeni,absA,kotA,Bx,By,~,~]=vrednost_polja_real(theta,r0,xs,ys,xd,yd,koliko_harmonikov,0,X_tmp,Y_tmp, Zmesh);


stevilka_v_imenu=num2str(velikost*1000);
switch size(stevilka_v_imenu,2)
    case 1
        stevilka_v_imenu=strcat('00',stevilka_v_imenu);
    case 2
        stevilka_v_imenu=strcat('0',stevilka_v_imenu);
        
    case 3
        stevilka_v_imenu=stevilka_v_imenu;
end

    tmp=struct;

    tmp.analog_sinus=Bx;                        % 2017.10.11 zamenjal Bx in By prej:tmp.analog_sinus=By;
    tmp.analog_cosinus=By;
    tmp.napaka=(kot_merjeni-theta)/(2*pi);      % v per unit
    tmp.fft_napake=absA /360 ;           % v per unit
    tmp.fi=kotA/360;                        % v per unit
    
    tmp.oddaljenost=velikost;% da je oddaljenost v mm
    
    ime_structa=strcat('sim_real_polje_',ekscentricnost,'_',stevilka_v_imenu,'u')
    
    eval(strcat(ime_structa,'=tmp;'));
    
    cd Y:\Alic_Mitja\Magistrsko_delo\simulacije\mat_datoteke;

    save(ime_structa,ime_structa)
    
    cd Y:\Alic_Mitja\Magistrsko_delo\simulacije;
    
end

