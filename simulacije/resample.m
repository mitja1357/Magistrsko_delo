novi_ref=linspace(0,360,1024);
for i=1:length(novi_ref)
najblizji=min(abs(ref1-novi_ref(i)));

najblizji_element=find((ref1==najblizji+novi_ref(i))|(ref1==-najblizji+novi_ref(i)));
vzemi=[najblizji_element-2 najblizji_element-1 najblizji_element najblizji_element+1];
if find((ref1==najblizji+novi_ref(i)))
  vzemi=vzemi+1;
end

koef_sin=polyval(ref1(vzemi),sinus1(vzemi),3);
koef_cos=polyval(ref1(vzemi),cosinus1(vzemi),3);

Sin(i)=koef_sin(1) .*novi_ref(i)^3 +koef_sin(2) .*novi_ref(i)^2 +koef_sin(3) .*novi_ref(i)+koef_sin(4);
Cos(i)=koef_cos(1) .*koef_cos(i)^3 +koef_cos(2) .*koef_cos(i)^2 +koef_cos(3) .*koef_cos(i)+koef_cos(4);


end

plot(novi_ref,Sin,novi_ref,Cos)










