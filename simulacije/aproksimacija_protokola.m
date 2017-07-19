% % % %close all
% % % if ishandle(5) && strcmp(get(5, 'type'), 'figure')
% % % 
% % %     close figure 5
% % % end


protokol=(kot_merjeni-theta)*180/pi;

[a0,absCos,absSin,absA,kotA]=fourier(theta,protokol,koliko_harmonikov,0);
amp=[a0,absA];
absCos=[a0,absCos];
absSin=[a0,absSin];




absA=[a0,absA];
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