niters=10000;
x=zeros(niters+1,2);
%initialise rngs
rand('state',2);
randn('state',2);
randnormvalues=randn(niters,1);
randvalues=rand(niters,1);
xprime = [0 0];
alpha = [0 0];
stds=[1,3];
r=[0 0];
acceptance=[0 0];


for i =1:niters
	for j=1:2
		xprime(j)=(randnormvalues(i)*stds(j))+x(i,j);
		alpha(j)=approxdist(xprime(j))/approxdist(x(i,j));

			%gaussian proposal dists are symmetric so hastings correction is always 1

		r(j)=min([1, alpha(j)]);
		u=randvalues(i);
		if u<r(j)
			x(i+1,j)=xprime(j);
			acceptance(j)=acceptance(j)+1;

		else
			x(i+1,j)=x(i,j);
			
		end
	end
end
acceptance=acceptance/niters; %get rate
hist(x(:,1),50);
set(get(gca,'child'),'FaceColor','k','EdgeColor','k');
ylabel('No. of samples','interpreter','latex','fontsize',20);
xlabel('$x$','interpreter','latex','fontsize',20);
xlim([0 100]);
title('Histogram of samples (50 bins), proposal distribution: $\mathcal{N}(x,\sigma^2=1)$','interpreter','latex','fontsize',12);
print('-depsc2','/afs/inf.ed.ac.uk/user/s13/s1367329/Documents/mlpr/assignment/q2sdist1.eps');

hold off;
hist(x(:,2),50);
set(get(gca,'child'),'FaceColor','k','EdgeColor','k');
ylabel('No. of samples','interpreter','latex','fontsize',20);
xlabel('$x$','interpreter','latex','fontsize',20);
xlim([0 100]);
title('Histogram of samples (50 bins), proposal distribution: $\mathcal{N}(x,\sigma^2=9)$','interpreter','latex','fontsize',12);
print('-depsc2','/afs/inf.ed.ac.uk/user/s13/s1367329/Documents/mlpr/assignment/q2sdist2.eps');
hold off;

plot(1:100,approxdist(1:100),'-k','linewidth',2);
ylabel('$p(x)$','interpreter','latex','fontsize',20);
xlabel('$x$','interpreter','latex','fontsize',20);
xlim([0 100]);
title('Target distribution: $p(x)=0.8\mathcal{N}(\mu_1=50,\sigma_1^2=9)+0.2\mathcal{N}(\mu_2=70,\sigma_2^2=9)$','interpreter','latex','fontsize',12);
print('-depsc2','/afs/inf.ed.ac.uk/user/s13/s1367329/Documents/mlpr/assignment/q2tdist.eps');



hold off;

