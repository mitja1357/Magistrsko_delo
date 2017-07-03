 clear all
 close all
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% dolocitev tock na katrih nardi fit %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

kot=pi/2*rand(10000,1)-pi/4;
radij=0.4*rand(10000,1)+2.2;

jx=radij.*cos(kot);
jy=radij.*sin(kot);

jz=atan(jy./jx);    %doloci vrednost v tockah

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% izracunaj polinom in %%%
%%% shrani spremenljivke %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n=3; %stopnja polinoma
p = polyfitn([jx,jy],jz,n); 

pot=p.ModelTerms;
k=p.Coefficients;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% narisi polinom na zeljenih tockah %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[X,Y] = meshgrid(0:0.01: 2.5,-2:0.01:2);
 
 kot=0; % ce zelis ravnino zasukat za kot v stopinjah
  for i=1:size(X,1)
     for j=1:size(X,2)        
         a(1,1)=X(i,j);
         a(2,1)=Y(i,j);
         b=[cosd(kot) sind(kot); -sind(kot) cosd(kot)]*a;
         X(i,j)=b(1);
         Y(i,j)=b(2);         
     end
  end 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %%% doloci vrednosti polinoma %%%
 %%%%%%%%%% v tockah %%%%%%%%%%%%%
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 Zapp=zeros(size(X));
 Z=zeros(size(X));
 for i=1:size(X,1)
     for j=1:size(X,2)
         Z(i,j)=atan2(Y(i,j),X(i,j));    
         dod=0;
         zapp=0;
         for l=1:max(size(k))
            dod=k(l)*((X(i,j)^pot(l,1)).*(Y(i,j)^pot(l,2)));
                zapp=zapp+dod;
         end
        Zapp(i,j)=zapp;
     end
 end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% izracun vrednosti polinoma v tockah %%%
%%%%%% s katerimi je bil izveden fit %%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 for l=1:max(size(k))
            dod=k(l)*((jx.^pot(l,1)).*(jy.^pot(l,2)));
                zapp=zapp+dod;
 end
offset=sum(zapp-jz)/max(size(jz))


%%%%%%%%%%%%%%%%%%%%%%%%%
%%% prikazi vrednosti %%%
%%%%%%%%%%%%%%%%%%%%%%%%%

fig_error=figure('Name',strcat('Error n = ',num2str(n)),'numbertitle','off','Position',[0   550   560   420]);
plot((zapp-jz-offset)*180/pi);
ylabel('Napaka approksimacije v ^\circ')

fig_tock_in_polinoma=figure('Name',strcat('Tocke in polinom n = ',num2str(n)),'numbertitle','off','Position',[560   550   560   420]);
scatter3(jx,jy,jz);
hold on
mesh(X,Y,Zapp)

