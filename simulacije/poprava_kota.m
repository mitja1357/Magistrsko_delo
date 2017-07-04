for i=2:max(size(kot_merjeni))
%     kot_merjeni(i)=kot_merjeni(i)-(-theta(1)+kot_merjeni(1));
   tmp=0;
    while (kot_merjeni(i-1)-kot_merjeni(i))>pi
        tmp=kot_merjeni(i);
        tmp=tmp+2*pi;
        kot_merjeni(i)=tmp;
    tmp=1;
    end
    
    if tmp==0
    while (kot_merjeni(i-1)-kot_merjeni(i))<-pi
        tmp=kot_merjeni(i);
        tmp=tmp-2*pi;
        kot_merjeni(i)=tmp;
    end
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
