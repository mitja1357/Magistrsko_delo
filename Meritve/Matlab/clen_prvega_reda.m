function Y=clen_prvega_reda(X,Tv,T,k)

a=T/(T+Tv);
b=Tv*k/(T+Tv);


tmp=0;
for i=1:max(size(X))
    
   
    
    Y(i)=b*X(i)+tmp;
    
    tmp=a*Y(i);
end

end
