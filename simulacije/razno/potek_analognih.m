
%% vhodni parametri
% ce popravljas fazo nastavi amplitude harmominkoma
offset_cos = 0.0;
offset_sin = 0.0;

delta_amp_1_harm = 0.0;
delta_faza_1_harm_deg = 0;

amp_cos_2_harm = 0.0;
amp_sin_2_harm = 0.0;
delta_faza_2_harm_deg = 0;

amp_cos_3_harm = 0.0;
amp_sin_3_harm = 0.0;
delta_faza_3_harm_deg = 0;

amp_cos_4_harm = 0.0;
amp_sin_4_harm = 0.0;
delta_faza_4_harm_deg = 0;


arr_poteka_parametra=linspace(-1,1,1000);
kateri_parameter_spreminjam='offset_cos';





%%

theta = linspace(0,360,8192);
arr_protocol=zeros(length(arr_poteka_parametra),8192);
for i=1:length(arr_poteka_parametra)
    eval(strcat(kateri_parameter_spreminjam,'=arr_poteka_parametra(i);'))
    
    Cos(i,:) = offset_cos + ...
        1*cosd(theta) + ...
        amp_cos_2_harm*cosd(2*theta) + ...
        amp_cos_3_harm*cosd(3*theta) + ...
        amp_cos_4_harm*cosd(4*theta);
    Sin(i,:) = offset_sin + ...
        (1 + delta_amp_1_harm)*sind(theta + delta_faza_1_harm_deg) + ...
        amp_sin_2_harm*sind(2*theta + delta_faza_2_harm_deg) + ...
        amp_sin_3_harm*sind(3*theta + delta_faza_3_harm_deg) + ...
        amp_sin_4_harm*sind(4*theta + delta_faza_4_harm_deg);
    
    arr_theta(i,:) = theta;
    
end
kot=atan2d(Sin,Cos);
protocol=kot-arr_theta;


protocol(protocol>90)= protocol(protocol>90)-180;
protocol(protocol<-90)= protocol(protocol<-90)+180;






%% Grafièni prikaz analognih
figure
subplot(2,1,1)
plot(theta,Cos)
legend('Cos')

subplot(2,1,2)
plot(theta,Sin)

%% Grafièni prikaz error
figure
plot(theta,protocol')
grid on
legend('err')
%% Izpis povprecja in p2p napake
disp(strvcat({'meritve napake','displace       mean        peak2peak',...
    num2str([arr_poteka_parametra(:), mean(protocol,2), max(protocol,[],2)-min(protocol,[],2)])}))


%% Find analog harmonik
aha = mojfft(protocol);
amp_prot = aha{1,1};
faza_prot_deg = aha{1,2};
if strfind(kateri_parameter_spreminjam,'sin')
    
    fft_Sin = mojfft(Sin);
else
    fft_Sin = mojfft(Cos);
end



finding_error_harmonic=fft_Sin{1}(end,[1,3:end]);
index_max=find(abs(finding_error_harmonic)==max(abs(finding_error_harmonic)));

if abs(finding_error_harmonic(index_max))-finding_error_harmonic(index_max+1)>0.1
    if index_max >1
        prevaldujoc_harmonik=index_max+1;
    else
        prevaldujoc_harmonik=1;
    end
else
    prevaldujoc_harmonik=2;
end


%% Error se pojavi na prevaldujoc_harmonik-1 in prevaldujoc_harmonik+1
% narisi te dva poteka
if prevaldujoc_harmonik==1
    figure
plot(arr_poteka_parametra,amp_prot(:,prevaldujoc_harmonik+1),'-b')
title(['potek ',kateri_parameter_spreminjam, ' z napako v ', num2str(prevaldujoc_harmonik), ' harmoniku napake'])
legend(num2str(prevaldujoc_harmonik))
else
    



figure
plot(arr_poteka_parametra,amp_prot(:,prevaldujoc_harmonik-1),'-b')
hold on
plot(arr_poteka_parametra,amp_prot(:,prevaldujoc_harmonik+1),'-r')
grid on
title(['potek ',kateri_parameter_spreminjam, ' z napako v ', num2str(prevaldujoc_harmonik-2),' in ', num2str(prevaldujoc_harmonik),' harmoniku napake'])
legend(num2str([prevaldujoc_harmonik-2;prevaldujoc_harmonik]))
end


