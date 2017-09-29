function[koeficienti]= metoda_najmanjsih_kvadratov_polinom(X,Y,potenca,slika)
% funkcija je metoda najmanjsih kvadratov, ki aproksimira s polinomom zeljene stopnje
% za vhodne spremenljivke vzame funkcija stolpicni matriki X kot t'cke
% x-osi, matrika Y pa tocke y osi
% potenca pove na katere stopnjo naj bo polinom
% potenca mora biti naravno stevilo
% ce je slika 0 potem nebo prikazas slike
% koeficient(1) +koeficient(2) x+... + koeficient(potenca) x^(potenca-1)+ koeficient(potenca+1)x^potenca

if size(X)~=size(Y)
    fprintf('Matriki naj imata enako velikost');
end

if size(Y,2)~=1
    fprintf('Y matrika naj bo stolpec');
end

if (potenca -round(potenca))~=0 || potenca<0
fprintf('Potenca naj bo naravno stevilo');
end

A=ones(size(Y,1),potenca+1);

for i=2:potenca+1
A(:,i)=X.^(i-1);
end

koeficienti=A\Y;



%%%%% sliko naredi z 10% razponom sirso
if slika
    razpon=max(X)-min(X);
    t=linspace(min(X)-0.05*razpon,max(X)+0.05*razpon,1000);
    yy=zeros(1,1000);
    for i=0:potenca
        yy=yy+koeficienti(i+1).*t.^i;    
    end
    figure
    plot(t,yy)
    hold on
    plot(X,Y,'r*')
end



end