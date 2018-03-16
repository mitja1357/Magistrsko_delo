clear
ime='test5.csv';

            path='Y:\Alic_Mitja\Magistrsko_delo\simulacije\mat_datoteke\';
            filename=strcat(path,ime);
            
   
            matrika=csvread(filename,1,0);

            
            
            kot_ref=matrika(:,2);
            sinus=matrika(:,8)*80;
            cosinus=matrika(:,10)*80;
            cosinus1=cosinus(length(cosinus):-1:1);
            sinus1=sinus(length(sinus):-1:1);
            clear sinus cosinus
            
            referr=kot_ref-linspace(0,1,1000)';
            ref1=referr(1000:-1:1)+linspace(0,1,1000)';
            ref1=ref1.*360;      


novi_ref=linspace(0,360,1024);


for i=1:length(novi_ref)
najblizji=min(abs(ref1-novi_ref(i)));

najblizji_element=find((ref1==najblizji+novi_ref(i))|(ref1==-najblizji+novi_ref(i)));
vzemi=[najblizji_element-2 najblizji_element-1 najblizji_element najblizji_element+1];
if find((ref1==najblizji+novi_ref(i)))
  vzemi=vzemi+1;
end

if vzemi(1)<1
  vzemi=[1 2 3 4];
  end
  if vzemi(end)>length(novi_ref)
  vzemi=(length(novi_ref)-3):(length(novi_ref));
  end

koef_sin=polyfit(ref1(vzemi),sinus1(vzemi),3);
koef_cos=polyfit(ref1(vzemi),cosinus1(vzemi),3);

Sin(i)=koef_sin(1) .*novi_ref(i)^3 +koef_sin(2) .*novi_ref(i)^2 +koef_sin(3) .*novi_ref(i)+koef_sin(4);
Cos(i)=koef_cos(1) .*novi_ref(i)^3 +koef_cos(2) .*novi_ref(i)^2 +koef_cos(3) .*novi_ref(i)+koef_cos(4);


end

plot(novi_ref,Sin,novi_ref,Cos)










