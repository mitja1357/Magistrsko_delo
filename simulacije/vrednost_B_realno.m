function [B]=vrednost_B_realno(pozicija,X_tmp,Y_tmp,Zmesh)




iskanx=min(abs(pozicija(1)-X_tmp));
iskany=min(abs(pozicija(2)-Y_tmp));

iskanx=round(50*(iskanx+pozicija(1)))/50;
iskany=round(50*(iskany+pozicija(2)))/50;

x_tmp=find(abs(X_tmp-iskanx)<1e-6);
y_tmp=find(abs(Y_tmp-iskany)<1e-6);

B=Zmesh(x_tmp,y_tmp);

end


