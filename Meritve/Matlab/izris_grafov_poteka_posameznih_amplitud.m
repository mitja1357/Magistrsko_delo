 


folder='2017_08_09';
eksc='xd';
st_harmonikov=3;
periode=2;
[amplitude,ekscentricnost]=izpis_amplitud_posameznih_harmonikov_ekscentricnost(folder,eksc,st_harmonikov*periode);


for i=1:st_harmonikov
    amplitude(:,i+1)=amplitude(:,periode*i+1);
end
amplitude=amplitude(:,1:(st_harmonikov+1));

amplitude(:,1)=amplitude(:,1)-amplitude(1,1); % enosmerna komponenta naj bo v prvi legi enaka 0;


%poisci barve  in uporabi le tisti cell kateri ima stevilo barv enako
%kolikor imam jaz plotov (st_harmonikov+1)

run Y:\Alic_Mitja\Magistrsko_delo\simulacije\Barve.m



for i=1:12
    if i== (st_harmonikov+1)
                
        eval(strcat('Barva=Barva',num2str(i),';')); 
        
    
    end
    
    eval(strcat('clear Barva',num2str(i),';'));
end


% narisi sliko in sestavi legendo


figure
hold on



leg= 'legend(';                 % definiraj string za legendo

for i=1:(st_harmonikov+1)
    color=Barva{i}./255;
    plot(ekscentricnost,amplitude(:,i),'Color',color);
    
    leg=strcat(leg,'H', num2str(i-1),','); 
    tmp=strcat('Har_ ', num2str(i-1));
    eval(strcat('H',num2str(i-1),'=tmp;')); %shrani string kateri naj se zapise v legendi v spremenljivko
end
leg=leg(1:end-1);               % izbrisi zadnjo vejico ki je v stringu
leg=strcat(leg,');');           % zakljuci legendo
eval(leg)                       % narisi legendo
legend('Location','NorthWest'); % postavi legendo
grid on

for i=0:st_harmonikov
    eval(strcat('clear H',num2str(i)));
end
clear color tmp i Barva leg


