% radij po katerem se pelje sredisce
radij=sqrt(xs^2+ys^2);
% tocke x osi za kroznico
kroznica_x=linspace(-radij,radij,1000)+xd;
% tocke pozitivne y osi za kroznico
kroznica_y=sqrt(radij^2-(kroznica_x-xd).^2);


% doloci zgornji in spodnji del kroznice    
kroznica_y_a=kroznica_y+yd;
kroznica_y_b=-kroznica_y+yd;
% narisi kroznico
plot(kroznica_x,kroznica_y_a,'-g',kroznica_x,kroznica_y_b,'-g');
% narisi odmik od idealnega sredisca
plot([0,xd],[0,yd],'-g');
axis equal