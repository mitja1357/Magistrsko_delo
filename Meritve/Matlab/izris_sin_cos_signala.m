[sin,cos,ref]=uvoz_podatkov('brez_eks_sin.csv');
ref=ref*360;
plot(ref(1:end-1),sin(1:end-1))
hold on
plot(ref(1:end-1),cos(1:end-1),'r')
grid on
legend('B_{H1}','B_{H2}','Location','southeast')