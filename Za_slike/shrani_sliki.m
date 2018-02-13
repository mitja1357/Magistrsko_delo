% 
% tip1=cell(3,1);
% tip='meritev';
% tip1{2}='sim_lin_polje';
% tip1{3}='sim_real_polje';
% 

eks1=cell(2,1);
eks1{1}='xs';
eks1{2}='xd';
eks1{3}='ys';
eks1{4}='yd';
% eks1{5}='zs';


oddaljenost= 0:25e-3:500e-3;
% for j=1:3
%     eks=eks1{j};
for i=oddaljenost
%         tip=tip1{3};
%         eks=eks1{2};
        narisi_grafe_meritve('sim_lin_polje', 'xd',i)
end
% end
close all
test=0
hold off
plot(sim_lin_polje_xd_225u.napaka.*360)
hold on
sim_lin_polje_xd_225u.fi=[0,sim_lin_polje_xd_225u.fi(end-7:end)];
for i=length(amp):-1:1
   test=test+ amp(i).*cosd((i-1).*t+sim_lin_polje_xd_225u.fi(i)*360);
    
end
plot(test)