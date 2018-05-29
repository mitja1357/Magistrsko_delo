clear

dina_eks=[0.1;0.0];
stat_eks=[0.0;0.0];

theta=linspace(0,360,100);


r_mag=1;

sonda=[0.5;0]+stat_eks;

zacetno_stanje(1,:)=r_mag.*cosd(theta)+dina_eks(1);
zacetno_stanje(2,:)=r_mag.*sind(theta)+dina_eks(2);

prva_tocka=[-r_mag;0]+dina_eks;
drug_tocka=[r_mag;0]+dina_eks;

textN=[0;0.8.*r_mag]+dina_eks;
textS=[0;-0.8.*r_mag]+dina_eks;







f1=figure(1);
set(f1,'Position',[1,53,1920,952])
clf(f1)


for kot_vrtenja=1:length(theta)
    
    rot_matrika=[cosd(theta(kot_vrtenja)),-sind(theta(kot_vrtenja));...
                 sind(theta(kot_vrtenja)), cosd(theta(kot_vrtenja))];
    nov_prva=rot_matrika*prva_tocka;
    nov_drug=rot_matrika*drug_tocka;
    
    sredina_magneta(:,kot_vrtenja)=(nov_drug+nov_prva)./2;
    
    nov_tN=rot_matrika*textN;
    nov_tS=rot_matrika*textS;
   
    r0(:,kot_vrtenja)=[(-sredina_magneta(1,kot_vrtenja)+sonda(1));(-sredina_magneta(2,kot_vrtenja)+sonda(2))]; 
    
    for posamezna_tocka=1:length(zacetno_stanje)
        novo_stanje(:,posamezna_tocka)=rot_matrika*zacetno_stanje(:,posamezna_tocka);
    end
    
    vrt_sonde(:,kot_vrtenja)=[cosd(theta(kot_vrtenja)),sind(theta(kot_vrtenja)); ...
                -sind(theta(kot_vrtenja)),cosd(theta(kot_vrtenja))] * sonda-dina_eks;
            
    inverzni_kot(:,kot_vrtenja)=rot_matrika*vrt_sonde(:,kot_vrtenja);
    
    %% draw images
        
    ax(1)  = subplot(2,2,1);
    ax(2)  = subplot(2,2,3);
    ax(3) = subplot(2,2,2);
    ax(4) = subplot(2,2,4);
    
    
    subplot(2,2,1);
    plot([nov_prva(1),nov_drug(1)],[nov_prva(2),nov_drug(2)])
    hold on
    text(nov_tN(1),nov_tN(2),'N','rotation',theta(kot_vrtenja))
    text(nov_tS(1),nov_tS(2),'S','rotation',theta(kot_vrtenja))
    plot(novo_stanje(1,:),novo_stanje(2,:));
    
    plot([sonda(1),sredina_magneta(1,kot_vrtenja)],[sonda(2),sredina_magneta(2,kot_vrtenja)],'-r')
    plot(sonda(1),sonda(2),'*r')
    plot([0,sredina_magneta(1,kot_vrtenja)],[0,sredina_magneta(2,kot_vrtenja)],'-k')
    plot(sredina_magneta(1,1:2:kot_vrtenja),sredina_magneta(2,1:2:kot_vrtenja),'*k')

    axis image
    xlim([1.1*(-r_mag-sum(abs(dina_eks))), 1.1*(r_mag+sum(abs(dina_eks)))])
    ylim([1.1*(-r_mag-sum(abs(dina_eks))), 1.1*(r_mag+sum(abs(dina_eks)))])    
    grid on
    hold off
    
    
    
    subplot(2,2,3);
    plot(cosd(theta),sind(theta))
    hold on
    plot([-r_mag,r_mag],[0,0])
    text(0,0.8*r_mag,'N')
    text(0,-0.8*r_mag,'S')
    
    plot([0,vrt_sonde(1,kot_vrtenja)],[0,vrt_sonde(2,kot_vrtenja)],'-r')
    hold on
    plot(vrt_sonde(1,1:kot_vrtenja),vrt_sonde(2,1:kot_vrtenja),'*r')
    plot([0,-dina_eks(1)],[0,-dina_eks(2)],'-k')
    plot(-dina_eks(1),-dina_eks(2),'*k')

    grid on
    axis image
    xlim([1.1*(-r_mag-sum(abs(dina_eks))), 1.1*(r_mag+sum(abs(dina_eks)))])
    ylim([1.1*(-r_mag-sum(abs(dina_eks))), 1.1*(r_mag+sum(abs(dina_eks)))]) 
    hold off
        

    
      
    
    
    
    subplot(2,2,2);
    axis([0,360,-0.05+min([sonda(1)-sum(abs(dina_eks)),sonda(2)-sum(abs(dina_eks))]), ...
          0.05+max([sonda(1)+sum(abs(dina_eks)),sonda(2)+sum(abs(dina_eks))])]);
    grid on
    plot(theta(1:kot_vrtenja),r0(1,1:kot_vrtenja),'LineWidth',2);
    hold on
    plot(theta(1:kot_vrtenja),r0(2,1:kot_vrtenja),'-r','LineWidth',2);
    title('magnet vrtim')
    legend('x','y')
    
    
    
    
    subplot(2,2,4);
    axis([0,360,-0.05+min([sonda(1)-sum(abs(dina_eks)),sonda(2)-sum(abs(dina_eks))]), ...
          0.05+max([sonda(1)+sum(abs(dina_eks)),sonda(2)+sum(abs(dina_eks))])]);
    grid on
    plot(theta(1:kot_vrtenja),inverzni_kot(1,1:kot_vrtenja),'LineWidth',2);
    hold on
    plot(theta(1:kot_vrtenja),inverzni_kot(2,1:kot_vrtenja),'-r','LineWidth',2);
    title('senzor vrtim')
    legend('x','y')    
    
    
    set(ax([3,4]),'xtick',0:30:360)
    drawnow
    

    

    pause(0.01)

%% finish for
end



