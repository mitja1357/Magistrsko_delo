% stat_eks = [0.0;0.0];
% dina_eks = [0.2;-0.3];

stat_eks = [0.0;0.0];
dina_eks = [0.2;-0.3];
n=100;
theta=linspace(0,360,n);

r_mag=1;
barva_magneta = [0.5686274766922 0.521568655967712 0.458823531866074];
barvaHall = [144,75,223]./255;

stat_eks_arr(1,:) = linspace(0,stat_eks(1),100);
stat_eks_arr(2,:) = linspace(0,stat_eks(2),100); 
dina_eks_arr(1,:) = linspace(0,dina_eks(1),100); 
dina_eks_arr(2,:) = linspace(0,dina_eks(2),100); 
f1=figure(1);
set(f1,'Position',[100,50,700,700],'Color',[1,1,1])
clf(f1)
axis manual
axis([-2.5+stat_eks(1), 2.5+stat_eks(1),...
    -2.5+stat_eks(2), 2.5+stat_eks(2)])

gif = 1;

limita = 1.1*(r_mag+sum(abs(dina_eks)));
velikost_cipa = 1.3;
cip=imread('cip.png');
%%
for i = 1:100
    sonda1=[r_mag*0.75;0]+stat_eks_arr(:,i);
    sonda2 = sonda1 +[-r_mag*0.75; +r_mag*0.75];
    magnetna_ovojnica(1,:)=r_mag.*cosd(theta)+dina_eks_arr(1,i);
    magnetna_ovojnica(2,:)=r_mag.*sind(theta)+dina_eks_arr(2,i);

    prva_tocka_sredinske_crte=[-r_mag;0]+dina_eks_arr(:,i);
    drug_tocka_sredinske_crte=[r_mag;0]+dina_eks_arr(:,i);
    
    textN=[0;0.8.*r_mag]+dina_eks_arr(:,i);
    textS=[0;-0.8.*r_mag]+dina_eks_arr(:,i);

    sredina_magneta=dina_eks_arr(:,i);
  
    image([stat_eks_arr(1,i)-velikost_cipa stat_eks_arr(1,i)+velikost_cipa],...
    [stat_eks_arr(2,i)-velikost_cipa stat_eks_arr(2,i)+velikost_cipa], cip,'AlphaData', 0.8);
    set(gca,'YDir','normal')

    hold on
    plot([drug_tocka_sredinske_crte(1),prva_tocka_sredinske_crte(1)], ...
        [prva_tocka_sredinske_crte(2),drug_tocka_sredinske_crte(2)],...
        'Linewidth', 3,...
    'Color',barva_magneta);
    
    text(textN(1),textN(2),'N','FontSize', 20)
    text(textS(1),textS(2),'S','FontSize', 20)
    plot(magnetna_ovojnica(1,:),magnetna_ovojnica(2,:), 'Linewidth', 3,...
    'Color',barva_magneta);
    plot(sonda1(1),sonda1(2),'-gx',...
    'LineWidth',4,...
    'MarkerSize',30,...
    'MarkerEdgeColor',barvaHall,...
    'MarkerFaceColor',barvaHall)
    plot([sonda2(1),sonda2(1),sonda1(1)], ...
        [sonda2(2), sonda1(2),sonda1(2)], '.-k')
    plot(sonda2(1),sonda2(2),'-gx',...
    'LineWidth',4,...
    'MarkerSize',30,...
    'MarkerEdgeColor',barvaHall,...
    'MarkerFaceColor',barvaHall)
    
    plot([dina_eks_arr(1,i), 0],...
        [dina_eks_arr(2,i), 0],...
        '-r','LineWidth',1)
    
    plot([0, stat_eks_arr(1,i)],...
        [0, stat_eks_arr(2,i)],...
        '-m','LineWidth',1)
    
    
    axis equal
    axis manual
    axis off
    axis([-1.5-abs(stat_eks(1)), 1.5+abs(stat_eks(1)),...
    -1.5-abs(stat_eks(2)), 1.5+abs(stat_eks(2))])

    hold off
    drawnow
    
    % gif
    if gif
        filename = 'premik_iz_izhodisca';
        frame = getframe(f1); 
        im = frame2im(frame);
        [imind,cm] = rgb2ind(im,65536); 
        if i == 1
            imwrite(imind,cm, strcat(filename,'.gif'),'gif', 'Loopcount',inf);

        else
            imwrite(imind,cm, strcat(filename,'.gif'),'gif','WriteMode','append');
            if i == 100
                saveas(gcf,strcat(filename,'.png'))
                saveas(gcf,filename,'epsc')
            end
        end
    end
    
end

%%
f1=figure(1);
set(f1,'Position',[100,50,700,700],'Color',[1,1,1])

for j = 1: 100
    barvaHall1 = barvaHall+(1-barvaHall).*(j)/100;
    imagesc([stat_eks_arr(1,i)-velikost_cipa stat_eks_arr(1,i)+velikost_cipa],...
        [stat_eks_arr(2,i)-velikost_cipa stat_eks_arr(2,i)+velikost_cipa], cip,'AlphaData', 0.8* (100-j)/100);
    set(gca,'YDir','normal')
    hold on
    plot([drug_tocka_sredinske_crte(1),prva_tocka_sredinske_crte(1)], ...
        [prva_tocka_sredinske_crte(2),drug_tocka_sredinske_crte(2)],...
        'Linewidth', 3,...
    'Color',barva_magneta);
    text(textN(1),textN(2),'N','FontSize', 20)
    text(textS(1),textS(2),'S','FontSize', 20)
    plot(magnetna_ovojnica(1,:),magnetna_ovojnica(2,:), 'Linewidth', 3,...
    'Color',barva_magneta);
    plot(sonda1(1),sonda1(2),'-gx',...
    'LineWidth',4,...
    'MarkerSize',30,...
    'MarkerEdgeColor',barvaHall,...
    'MarkerFaceColor',barvaHall)
    plot([sonda2(1),sonda2(1)], ...
        [sonda2(2), sonda1(2)], '.-k', 'Color', [0,0,0]+(1-[0,0,0]).*(j)/100)
    plot([sonda2(1),sonda1(1)], ...
        [sonda1(2), sonda1(2)], '.-k')
    plot([dina_eks_arr(1,i), 0],...
        [dina_eks_arr(2,i), 0],...
        '-r','LineWidth',1)
    
    plot([0, stat_eks_arr(1,i)],...
        [0, stat_eks_arr(2,i)],...
        '-m','LineWidth',1)
    plot(sonda2(1),sonda2(2),'-gx',...
    'LineWidth',4,...
    'MarkerSize',30,...
    'MarkerEdgeColor',barvaHall1,...
    'MarkerFaceColor',barvaHall1)

    axis equal
    axis manual
    axis off
    axis([-1.5-abs(stat_eks(1)), 1.5+abs(stat_eks(1)),...
    -1.5-abs(stat_eks(2)), 1.5+abs(stat_eks(2))])

    hold off
    drawnow
    
     
    if gif
        filename = 'odstrani_cip';
        frame = getframe(f1); 
        im = frame2im(frame);
        [imind,cm] = rgb2ind(im,65536); 
        if j == 1
            imwrite(imind,cm, strcat(filename,'.gif'),'gif', 'Loopcount',100);

        else
            imwrite(imind,cm, strcat(filename,'.gif'),'gif','WriteMode','append');
        end
        if j == 100
            saveas(gcf,strcat(filename,'.png'))
            saveas(gcf,filename,'epsc')
        end
        
    end
end

%%
clf

for zasuk=1:length(theta)-1

    rot_matrika=[cosd(theta(zasuk)),-sind(theta(zasuk));...
                 sind(theta(zasuk)), cosd(theta(zasuk))];
    % poisci sredino magnea
    sredinska_crta_magneta_prva=rot_matrika*prva_tocka_sredinske_crte;
    sredinska_crta_magneta_drug=rot_matrika*drug_tocka_sredinske_crte;
    
    sredina_magneta(:,zasuk)=rot_matrika*dina_eks;
    % pozicija napisa N, S
    nov_tN=rot_matrika*textN;
    nov_tS=rot_matrika*textS;

    
    for posamezna_tocka=1:length(magnetna_ovojnica)
        novo_stanje_magnetne_ovojnice(:,posamezna_tocka)=rot_matrika* ...
            magnetna_ovojnica(:,posamezna_tocka);
    end
   
    % draw images
    
    plot([sredinska_crta_magneta_prva(1),sredinska_crta_magneta_drug(1)],...
        [sredinska_crta_magneta_prva(2),sredinska_crta_magneta_drug(2)], ...
         'Linewidth', 3,...
    'Color',barva_magneta);
    hold on
    text(nov_tN(1),nov_tN(2),'N','rotation',theta(zasuk),'FontSize', 20)
    text(nov_tS(1),nov_tS(2),'S','rotation',theta(zasuk),'FontSize', 20)
    plot(novo_stanje_magnetne_ovojnice(1,:),novo_stanje_magnetne_ovojnice(2,:),...
        'Linewidth', 3,...
    'Color',barva_magneta);
    
    plot([0,sredina_magneta(1,zasuk)],...
        [0,sredina_magneta(2,zasuk)],'-r', 'Linewidth', 1)
    plot([stat_eks_arr(1,i),sonda1(1)],...
        [stat_eks_arr(2,i),sonda1(2)],'-k', 'Linewidth', 1)
    plot(sonda1(1),sonda1(2),'-gx',...
    'LineWidth',4,...
    'MarkerSize',30,...
    'MarkerEdgeColor',barvaHall,...
    'MarkerFaceColor',barvaHall)
    
    
    plot([0, stat_eks_arr(1,i)],...
        [0, stat_eks_arr(2,i)],...
        '-m','LineWidth',1)
    axis equal
    axis manual
    axis off
    axis([-1.5-abs(stat_eks(1)), 1.5+abs(stat_eks(1)),...
    -1.5-abs(stat_eks(2)), 1.5+abs(stat_eks(2))])

    hold off
    drawnow
    
    if gif
        filename = 'vrti_magnet';
        frame = getframe(f1); 
        im = frame2im(frame);
        [imind,cm] = rgb2ind(im,65536); 
        if zasuk == 1
            imwrite(imind,cm, strcat(filename,'.gif'),'gif', 'Loopcount',inf);
        else
            imwrite(imind,cm, strcat(filename,'.gif'),'gif','WriteMode','append');
        end
        if zasuk == 100
            saveas(gcf,strcat(filename,'.png'))
            saveas(gcf,filename,'epsc')
        end
    end
end














