clear all
close all

% na koliko harmonikov naredi F vrsto
st_harmonikov=8;

% katere stopnje naj bo aproksimacijski polinom
stopnja_polinoma=3;

% kateri harmonik zelis na sliki
harm=0;

if harm+1>st_harmonikov
    st_harmonikov=harm+1;
    fprintf('st_harmonikov je manjse kot kateri harmoik zelis prikazat');
end
% v prvo vrstico matrike mat_harmonikov vpisi amplitude harmonikov ko ni
% ekscentricnosti


mat_harmonikov=zeros(21,st_harmonikov+1);
[error,kot,ref]=uvoz_podatkov('brez_eks.csv');
error=error*360;
[c0,a,b,c,fi] = fourier(1:1000,error,st_harmonikov,0);
tmp= [c0,c];
mat_harmonikov(1,1:(st_harmonikov+1))=tmp;


% matriko mat_harmonikov napolni s amplitudami harmonikov od 10u do 200u
% staticne ekscentricnosti v x-smeri

for i=1:20
    
ime=strcat('xs_',num2str(i),'0u.csv');

[error,kot,ref]=uvoz_podatkov(ime);
error=error*360;
[c0,a,b,c,fi] = fourier(1:1000,error,st_harmonikov,0);
tmp= [c0,c];

mat_harmonikov(i+1,1:(st_harmonikov+1))=tmp;
end


% naredi aproksimacijo potekov amplitud s polinomom


% definiraj x os
xs=(0:1e-5:200e-6)';

% naredi metodo najmanjsih kvadratov koeficiente vpises v matriko koef_mnk


koef_mnk=zeros((stopnja_polinoma+1),size(st_harmonikov,1)+1);
clear tmp i
for i=1:(st_harmonikov+1)
    koef_mnk(:,i)= metoda_najmanjsih_kvadratov_polinom(xs,mat_harmonikov(:,i),stopnja_polinoma); 
end


%kateri element zelis
harm=harm+1;

approx=0;
clear i
for i=1:stopnja_polinoma+1
    
    approx=approx+koef_mnk(i,harm)*xs.^(i-1);
end

figure
plot(xs,mat_harmonikov(:,harm));
hold on
plot(xs,approx,'r')