ref1 = meritev_xs.ref(1,:);
sinus1 = meritev_xs.sin(1,:);
cosinus1 = meritev_xs.cos(1,:);
novi_ref=linspace(0,360-360/1024,1024);
for i=1:length(novi_ref)
najblizji=min(abs(ref1-novi_ref(i)));

najblizji_element=find((ref1==najblizji+novi_ref(i))|(ref1==-najblizji+novi_ref(i)));
vzemi=[najblizji_element-2 najblizji_element-1 najblizji_element najblizji_element+1];
if min(vzemi)<1
    vzemi = vzemi +1-min(vzemi);
end

koef_sin=polyval(ref1(vzemi),sinus1(vzemi),3);
koef_cos=polyval(ref1(vzemi),cosinus1(vzemi),3);

Sin(i)=koef_sin(1) .*novi_ref(i)^3 +koef_sin(2) .*novi_ref(i)^2 +koef_sin(3) .*novi_ref(i)+koef_sin(4);
Cos(i)=koef_cos(1) .*novi_ref(i)^3 +koef_cos(2) .*novi_ref(i)^2 +koef_cos(3) .*novi_ref(i)+koef_cos(4);


end

plot(novi_ref,Sin,novi_ref,Cos)










