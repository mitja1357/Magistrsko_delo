% % % %close all
% % % if ishandle(5) && strcmp(get(5, 'type'), 'figure')
% % % 
% % %     close figure 5
% % % end


protokol=(kot_merjeni-theta)*180/pi;

stpoin=zeros(1,koliko_harmonikov*2+2);
stpoin(end)=1;

app=fit(theta',protokol',strcat('fourier',num2str(koliko_harmonikov)), 'StartPoint', stpoin);
eval(strcat('a',num2str(0),'=app.a',num2str(0),';'));
for i=1:koliko_harmonikov
    eval(strcat('a',num2str(i),'=app.a',num2str(i),';'));
    eval(strcat('b',num2str(i),'=app.b',num2str(i),';'));
end
absA=zeros(koliko_harmonikov+1,1);
kotA=absA;

absSin=zeros(koliko_harmonikov+1,1);
absCos=zeros(koliko_harmonikov+1,1);
for i=1:koliko_harmonikov
    eval(strcat('a=a',num2str(i),';'));
    eval(strcat('b=b',num2str(i),';'));
    eval(strcat('absA(',num2str(i+1),')=sqrt((',num2str(a),')^2+(',num2str(b),')^2);'));
    eval(strcat('kotA(',num2str(i+1),')=atan2(',num2str(a),',',num2str(b),')*180/pi;'));
    eval(strcat('absSin(',num2str(i+1),')=',num2str(b),';'));
    eval(strcat('absCos(',num2str(i+1),')=',num2str(a),';'));
end

%%% absA cos(theta-kotA *pi/180)


absA(1)=a0;
if slike
figure('Name',strcat('fouriejeva vrsta protokla, ',ime_slik),'numbertitle','off','Position',[560   550   560   420]);
bar(0:koliko_harmonikov,absA)
grid on
end



%{


figure
plot(theta,app(theta))
hold on
plot(theta,protokol)

       
figure
plot(theta,app(theta)-protokol')
%}