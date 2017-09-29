% 18.8.2017 Mitja Alic
% funkcnija glede na vhodni podatek (pot\ime csv fila) in vztrajnosti 
% izracuna kaksen navor naj se doda trenutnem poteku navora
% 
% primer:
% 
% file_name='2017_08_14\xd_700u.csv';
% J=0.01;
% slike=1;
% kaksen_navor_naj_se_doda(file_name,J),slike;
% 


function delta_M=kaksen_navor_naj_se_doda(file_name,J,slike)
h=5;                                                %koliko harmonikov naj izracuna
t=linspace(0,1,1000);                               % tocke za prikaz. V napaki mora biti vedno 1000 tock

error=uvoz_podatkov(file_name);                     % uvoz napake

error=2*pi*error;                                    % napaka v redianih


[~,~,~,c,fi] = fourier(t,error,h,0);                %dolocitev posameznih harmonikov


w=2*pi; 

amp_posp=zeros(1,h);                                % definiraj matriko za izracun amplitud
cosinusni=zeros(h,1000);                            % matrika kjer bodo poteki posameznih harmoonikov 

for i=1:h
    
    amp_posp(i)=-(i*w)^2*c(i);                      %izracun amplitude harmonika pospeska
    cosinusni(i,:)=amp_posp(i)*cos(i*w.*t+fi(i));   %kjer se izracuna poteke posameznih harmonikov
end


delta_M=J*sum(cosinusni);                           % potek pospeska krat vztrajnost


if slike                                            % ce se narise slike    

    figure
    plot(t*360,delta_M)
    hold on
    plot(t*360,error,'r')
    legend('\Delta M/Nm','error/ \circ')
end

end