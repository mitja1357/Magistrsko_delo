function [koeficienti]= metoda_najmanjsih_kvadratov_polinom(X,Y,potenca)
% funkcija je metoda najmanjsih kvadratov, ki aproksimira s polinomom zeljene stopnje
% za vhodne spremenljivke vzame funkcija stolpicni matriki X kot t'cke
% x-osi, matrika Y pa tocke y osi
% potenca pove na katere stopnjo naj bo polinom
% potenca mora biti naravno stevilo
% koeficient(1) x^potenca+koeficient(2) x^(potenca-1)+... + koeficient(potenca) x+ koeficient(potenca+1)

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



end