% % % %close all
% % % if ishandle(5) && strcmp(get(5, 'type'), 'figure')
% % % 
% % %     close figure 5
% % % end


protokol=(kot_merjeni-theta)*180/pi;


app=fit(theta',protokol','fourier8', 'StartPoint', [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1]);
eval(strcat('a',num2str(0),'=app.a',num2str(0),';'));
for i=1:8
    eval(strcat('a',num2str(i),'=app.a',num2str(i),';'));
    eval(strcat('b',num2str(i),'=app.b',num2str(i),';'));
end
absA=zeros(9,1);
kotA=absA;

for i=1:8
    eval(strcat('a=a',num2str(i),';'));
    eval(strcat('b=b',num2str(i),';'));
    eval(strcat('absA(',num2str(i+1),')=sqrt((',num2str(a),')^2+(',num2str(b),')^2);'));
    eval(strcat('kotA(',num2str(i+1),')=atan2(',num2str(b),',',num2str(a),')*180/pi;'));
    
end

%%% absA cos(theta-kotA *pi/180)


absA(1)=a0;

figure('Name',strcat('fouriejeva vrsta protokla, ',ime_slik),'numbertitle','off','Position',[560   550   560   420]);
bar(0:8,absA)
grid on




%{


figure
plot(theta,app(theta))
hold on
plot(theta,protokol)

       
figure
plot(theta,app(theta)-protokol')
%}