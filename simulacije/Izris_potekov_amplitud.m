switch po_kateri_eks
    case 'xs'
        crt=3;
        legenda={'A_0','A_2','B_2'};
    case 'ys'
        crt=3;
        legenda={'A_0','A_2','B_2'};
    case 'xd'
        crt=4;
        legenda={'A_1','B_1','A_2','B_2'};
    case 'yd'
        crt=4;
        legenda={'A_1','B_1','A_2','B_2'};
end


Barve;
eval(strcat('barve=Barva',num2str(4),';' ));


figure
hold on
i=crt;
if  mod(crt,2)
    plot(potek,amp(:,1),'Color',cell2mat(barve(1))./255)
    i=i-1;
end





if i<crt
    plot(potek,ampcos(:,3),'Color',cell2mat(barve(2))./255)
    plot(potek,ampsin(:,3),'Color',cell2mat(barve(3))./255)
else
    plot(potek,ampcos(:,2),'Color',cell2mat(barve(1))./255)
    plot(potek,ampsin(:,2),'Color',cell2mat(barve(2))./255)
	plot(potek,ampcos(:,3),'Color',cell2mat(barve(3))./255)
    plot(potek,ampsin(:,3),'Color',cell2mat(barve(4))./255)
   
end
legend(legenda)
grid on