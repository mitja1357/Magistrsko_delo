for i=2:max(size(kot_merjeni))
%     kot_merjeni(i)=kot_merjeni(i)-(-theta(1)+kot_merjeni(1));
   
    while kot_merjeni(i-1)-kot_merjeni(i)>pi
        kot_merjeni(i)=kot_merjeni(i)+2*pi;
    end
    
    
end
clear i;

while kot_merjeni(1)-theta(1)>=pi
    kot_merjeni=kot_merjeni-2*pi;
end
while kot_merjeni(1)-theta(1)<=-pi
    kot_merjeni=kot_merjeni+2*pi;
end
% kot_merjeni(1)=theta(1);
