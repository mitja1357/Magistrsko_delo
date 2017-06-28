
function [B]=vrednost_B_realno(pozicija)

X_tmp=X(1,:);
Y_tmp=Y(:,1)';

iskanx=min(abs(pozicija(1)-X_tmp));
iskany=min(abs(pozicija(2)-Y_tmp));


x_tmp=find(abs(X_temp)==iskanx+pozicija(1));
y_tmp=find(abs(Y_temp)==iskany+pozicija(2));

B=Z(x_tmp,y_tmp);

end


