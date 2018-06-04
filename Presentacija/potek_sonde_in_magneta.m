function potek_sonde_in_magneta(varargin)

if nargin == 0
    error('rabis vhode');
elseif nargin == 1
    if ismatrix(varargin{1})
        if length(varargin{1}) > 2
            varargin{1}=varargin{1}(:);
            if size(varargin{1},2) ~= 1
                error('vhod mora bit vektor');
            else
                if length(varargin{1}) == 2
                    stat_eks = varargin{1};
                    dina_eks = [0;0];
                    warning('upostevan vhod je kot staticna ekscentricnost')
                elseif length(varargin{1}) == 4
                    stat_eks = varargin{1}([1,2],1);
                    dina_eks = varargin{1}([3,4],1);
                else
                    error('napacen vhod')
                end
            end
        end
    else
        error('rabis numericne podatke')
    end
elseif nargin == 2
    if ismatrix(varargin{1}) && ismatrix(varargin{2})
        if length(varargin{1}) ~= 2 && length(varargin{2}) ~= 2
            error('cudni podatki')
        else
            stat_eks = varargin{1};
            dina_eks = varargin{2};
        end
    else
        error('zrihti vhode')
    end
    
else
    error('zrihti vhode')
end

stat_eks = stat_eks(:);
dina_eks = dina_eks(:);
n=37;
theta=linspace(0,360,n);

r_mag=1;

sonda_do_osi_vrtenja=[r_mag/2;0]+stat_eks;

zacetno_stanje_magnetne_ovojnice(1,:)=r_mag.*cosd(theta)+dina_eks(1);
zacetno_stanje_magnetne_ovojnice(2,:)=r_mag.*sind(theta)+dina_eks(2);

prva_tocka_sredinske_crte=[-r_mag;0]+dina_eks;
drug_tocka_sredinske_crte=[r_mag;0]+dina_eks;

textN=[0;0.8.*r_mag]+dina_eks;
textS=[0;-0.8.*r_mag]+dina_eks;

f1=figure(1);
set(f1,'Position',[1,41,1920,964])
clf(f1)

sredina_magneta = zeros(2,length(theta));
r0 = zeros(2,length(theta));
vrt_sonde = zeros(2,length(theta));
inverzni_kot = zeros(2,length(theta));
    
limita = 1.1*(r_mag+sum(abs(dina_eks)));

minmax=[sonda_do_osi_vrtenja(1)-sum(abs(dina_eks)), ...
             sonda_do_osi_vrtenja(2)-sum(abs(dina_eks)), ...
             sonda_do_osi_vrtenja(1)+sum(abs(dina_eks)), ...
             sonda_do_osi_vrtenja(2)+sum(abs(dina_eks)) ... 
             ];
axis_potekov_os_sonda = [0,360, -0.05+min(minmax), 0.05+max(minmax)];
novo_stanje_magnetne_ovojnice = zeros(2, length(zacetno_stanje_magnetne_ovojnice));
for zasuk=1:length(theta)

    clf(f1)
    %%%%%%%%%%%%%%%%%%%%%%
    %%% magnet se vrti %%%
    %%%%%%%%%%%%%%%%%%%%%%
    
    % rotacijska matrika odvisna od thete
    rot_matrika=[cosd(theta(zasuk)),-sind(theta(zasuk));...
                 sind(theta(zasuk)), cosd(theta(zasuk))];
    % poisci sredino magnea
    sredinska_crta_magneta_prva=rot_matrika*prva_tocka_sredinske_crte;
    sredinska_crta_magneta_drug=rot_matrika*drug_tocka_sredinske_crte;
    
    sredina_magneta(:,zasuk)=rot_matrika*dina_eks;
    % pozicija napisa N, S
    nov_tN=rot_matrika*textN;
    nov_tS=rot_matrika*textS;
   % razdalja sonda - sredi magneta
    r0(:,zasuk)=-sredina_magneta(:,zasuk)+sonda_do_osi_vrtenja;
    
    % zavrti magnetno ovojnice
    
    for posamezna_tocka=1:length(zacetno_stanje_magnetne_ovojnice)
        novo_stanje_magnetne_ovojnice(:,posamezna_tocka)=rot_matrika* ...
            zacetno_stanje_magnetne_ovojnice(:,posamezna_tocka);
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% vrti sondo in os vrtenja %%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    vrt_sonde(:,zasuk) = [cosd(theta(zasuk)),sind(theta(zasuk)); ...
                -sind(theta(zasuk)),cosd(theta(zasuk))] * ...
                sonda_do_osi_vrtenja-dina_eks;
    % razdalja do osi vrtenja v k.s. magneta        
    inverzni_kot(:,zasuk)=rot_matrika*vrt_sonde(:,zasuk);
    
    %% draw images
        
    ax(1)  = subplot(2,2,1);
    ax(2)  = subplot(2,2,3);
    ax(3) = subplot(2,2,2);
    ax(4) = subplot(2,2,4);
    
    % k.s. osi vrtenja magnet se vrti kot je to videti v realnosti
    subplot(2,2,1);
    plot([sredinska_crta_magneta_prva(1),sredinska_crta_magneta_drug(1)],[sredinska_crta_magneta_prva(2),sredinska_crta_magneta_drug(2)])
    hold on
    text(nov_tN(1),nov_tN(2),'N','rotation',theta(zasuk))
    text(nov_tS(1),nov_tS(2),'S','rotation',theta(zasuk))
    plot(novo_stanje_magnetne_ovojnice(1,:),novo_stanje_magnetne_ovojnice(2,:));
    
    plot([sonda_do_osi_vrtenja(1),sredina_magneta(1,zasuk)],[sonda_do_osi_vrtenja(2),sredina_magneta(2,zasuk)],'-r')
    plot(sonda_do_osi_vrtenja(1),sonda_do_osi_vrtenja(2),'*r')
    plot([0,sredina_magneta(1,zasuk)],[0,sredina_magneta(2,zasuk)],'-k')
    plot(sredina_magneta(1,1:2:zasuk),sredina_magneta(2,1:2:zasuk),'*k')

    axis image
    xlim([-limita, limita])
    ylim([-limita, limita])   
    grid on
    hold off
    title('vrtenje v k.s. osi vrtenja')
    
    % k.s. magneta sonda in os vrtenja se vrtita okoli magneta
    subplot(2,2,3);
    plot(cosd(theta),sind(theta))
    hold on
    plot([-r_mag,r_mag],[0,0])
    text(0,0.8*r_mag,'N')
    text(0,-0.8*r_mag,'S')
    
    plot([0,vrt_sonde(1,zasuk)],[0,vrt_sonde(2,zasuk)],'-r')
    hold on
    plot(vrt_sonde(1,1:zasuk),vrt_sonde(2,1:zasuk),'*r')
    plot([0,-dina_eks(1)],[0,-dina_eks(2)],'-k')
    plot(-dina_eks(1),-dina_eks(2),'*k')

    grid on
    axis image

    xlim([-limita, limita])
    ylim([-limita, limita])
    hold off    
    title('vrtenje v k.s. magneta')

    
    % razdalja sonda os vrtenja v k.s. osi vrtenja po x in y
    
    subplot(2,2,2);
    
    plot(theta(1:zasuk),r0(1,1:zasuk),'LineWidth',2);
    hold on
    plot(theta(1:zasuk),r0(2,1:zasuk),'-r','LineWidth',2);
    axis(axis_potekov_os_sonda);
    grid on
    title('magnet vrtim')
    legend('x','y')
    
    % razdalja sonda os vrtenja v k.s. osi vrtenja  izpeljano iz vrtnja sonde 
    subplot(2,2,4);
    
    plot(theta(1:zasuk),inverzni_kot(1,1:zasuk),'LineWidth',2);
    hold on
    plot(theta(1:zasuk),inverzni_kot(2,1:zasuk),'-r','LineWidth',2);
    axis(axis_potekov_os_sonda);
    grid on
    title('senzor vrtim')
    legend('x','y')   
    
    set(ax([3,4]),'xtick',0:30:360)
    drawnow

%% finish for
end

end

