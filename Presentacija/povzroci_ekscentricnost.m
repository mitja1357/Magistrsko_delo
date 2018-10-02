stat_eks = [0.0;+0.0];
dina_eks = [0.2;0.2];
n=37;
theta=linspace(0,360,n);

r_mag=1;

stat_eks_arr(1,:) = linspace(0,stat_eks(1),100);
stat_eks_arr(2,:) = linspace(0,-stat_eks(2),100); 
dina_eks_arr(1,:) = linspace(0,dina_eks(1),100); 
dina_eks_arr(2,:) = linspace(0,dina_eks(2),100); 
f1=figure(1);
set(f1,'Position',[100,50,700,700],'Color',[1,1,1])
clf(f1)
axis manual
axis([-2.5+stat_eks(1), 2.5+stat_eks(1),...
    -2.5+stat_eks(2), 2.5+stat_eks(2)])

limita = 1.1*(r_mag+sum(abs(dina_eks)));

cip=imread('cip.png');
for i = 1:100
    sonda1=[r_mag*0.75;0]+stat_eks_arr(:,i);
    sonda2 = sonda1 +[-r_mag*0.75; -r_mag*0.75];
    magnetna_ovojnica(1,:)=r_mag.*cosd(theta)+dina_eks_arr(1,i);
    magnetna_ovojnica(2,:)=r_mag.*sind(theta)+dina_eks_arr(2,i);

    prva_tocka_sredinske_crte=[-r_mag;0]+dina_eks_arr(:,i);
    drug_tocka_sredinske_crte=[r_mag;0]+dina_eks_arr(:,i);
    
    textN=[0;0.8.*r_mag]+dina_eks_arr(:,i);
    textS=[0;-0.8.*r_mag]+dina_eks_arr(:,i);

    % poisci sredino magnea
    sredinska_crta_magneta_prva=prva_tocka_sredinske_crte;
    sredinska_crta_magneta_drug=drug_tocka_sredinske_crte;
    sredina_magneta=dina_eks_arr(:,i);


    figure(f1);   
    imagesc([stat_eks_arr(1,i)-1.5 stat_eks_arr(1,i)+1.5],...
        [stat_eks_arr(2,i)-1.5 stat_eks_arr(2,i)+1.5], cip,'AlphaData', 1);
    hold on
    plot([drug_tocka_sredinske_crte(1),prva_tocka_sredinske_crte(1)], ...
        [sredinska_crta_magneta_prva(2),drug_tocka_sredinske_crte(2)],...
        'Linewidth', 3,...
    'Color',[0.600000023841858 0.600000023841858 0.600000023841858]);
    text(textN(1),textN(2),'S','FontSize', 20)
    text(textS(1),textS(2),'N','FontSize', 20)
    plot(magnetna_ovojnica(1,:),magnetna_ovojnica(2,:), 'Linewidth', 3,...
    'Color',[0.600000023841858 0.600000023841858 0.600000023841858]);
    
    plot(sonda1(1),sonda1(2),'-gx',...
    'LineWidth',2,...
    'MarkerSize',20,...
    'MarkerEdgeColor','b',...
    'MarkerFaceColor',[0.5,0.5,0.5])
    plot([sonda2(1),sonda2(1),sonda1(1)], ...
        [sonda2(2), sonda1(2),sonda1(2)], '.-k')
    plot(sonda2(1),sonda2(2),'-gx',...
    'LineWidth',2,...
    'MarkerSize',20,...
    'MarkerEdgeColor','b',...
    'MarkerFaceColor',[0.5,0.5,0.5])

    axis equal
    axis manual
    axis off
    axis([-1.5-abs(stat_eks(1)), 1.5+abs(stat_eks(1)),...
    -1.5-abs(stat_eks(2)), 1.5+abs(stat_eks(2))])

    hold off
    drawnow
end