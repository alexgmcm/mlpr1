
plot(0:0.01:1,betapdf(0:0.01:1,ones(1,101)*2,ones(1,101)*2),'-k','linewidth',2);
ylabel('$P(\theta)$','interpreter','latex','fontsize',20);
xlabel('$\theta $','interpreter','latex','fontsize',20);
title('Beta prior $P(\theta)$, $\alpha=2, \beta=2$','interpreter','latex','fontsize',16);
print('-depsc2','/afs/inf.ed.ac.uk/user/s13/s1367329/Documents/mlpr/assignment/betapdf.eps');