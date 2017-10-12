
tip1=cell(3,1);
tip1{1}='meritev';
tip1{2}='sim_lin_polje';
tip1{3}='sim_real_polje';


eks1=cell(5,1);
eks1{1}='xs';
eks1{2}='xd';
eks1{3}='ys';
eks1{4}='yd';
eks1{5}='zs';


oddaljenost= 0.25;

%for i=1:4
        tip=tip1{3};
        eks=eks1{2};
        narisi_grafe_meritve(tip, eks,oddaljenost)
%end
close all