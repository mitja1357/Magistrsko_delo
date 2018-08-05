% Mitja Alic
% Notranje Gorice 2018.06.29 
% funkcija izpise poteke prvih 4 harmonikov in offseta s polinomom tretje
% stopnje. dolocis kaj zelis aproksimirat katere podatke in ti izpise
% enacbe kar je v command window skopiras v eqarray v latex in lahko
% compilas
%
% 2018.07.02 dodal if stavek ki C0 popravi predznak
function tex_izpis_potekov(meritev)
load Rezultati_simulacij.mat
load Rezultati_meritve.mat

% meritev = 'lin_xd';


eval(strcat('podatki=',meritev,';'))

tx = ['\Delta ',meritev(end-1),'_',meritev(end)];

x = podatki.displacement;
fftp= mojfft(podatki.protocol);


for i = 1:5
    C0 = fftp{1, 1}(:,i);
    if i==1
        C0 = C0.*cosd(fftp{1, 2}(:,1));
    end
    fitC0=polyfit(x,C0,3);
    potencaC0 = floor(log10(abs(fitC0)));
    fitC0str = fitC0.*10.^-potencaC0;
    
    figure
    plot(x, C0,x ,fitC0(1).*x.^3+fitC0(2).*x.^2+fitC0(3).*x+fitC0(4))
    
    mojstring = strcat('&C_',num2str(i-1),' = ');
    for j = 1:4

% predznak
        if j == 1
            predznak = '%.2f';
        else
            predznak = '%+.2f';
        end
%stevilka
        osnova = num2str(fitC0str(j),predznak);
%potenca
        if potencaC0(j) == 0
            potenca = '';
        elseif potencaC0(j) == 1
            potenca = '\cdot 10';
        else
            potenca = ['\cdot 10^{',num2str(potencaC0(j),'%1.0f'),'}'];
        end
% clen
        if j == 3
           clen = tx;
        elseif j== 4
            clen = '';
        else
            clen = [tx ,'^{',num2str(4-j),'}'];
        end
        
        
        mojstring = [mojstring, osnova, potenca, clen ];
    end
    mojstring = [mojstring, ' \\'];
    
    mojstring(strfind(mojstring,'.')) = ',';
    test{i}=mojstring;
end

tmp = strvcat(test{1},test{2},test{3},test{4},test{5});
eval(strcat(meritev,'=tmp'))

clear lin_xs lin_xd lin_ys lin_yd real_xs real_xd real_ys real_yd ...
    meritev_xs meritev_ys meritev_xd meritev_zs podatki ...
    tx x fftp  i C0 fitC0 potencaC0 fitC0str mojstring j predznak osnova ...
    potenca clen test tmp meritev
