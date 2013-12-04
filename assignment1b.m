load('dowfeatures.mat');



%Posterior for Monday
samplesize=[1 100 1000];
%change to 100, 1000 etc. to incorporate more data points
theta=0:0.001:1;
ptheta=zeros(length(samplesize),length(theta));
montweets=dowfeatures(dowfeatures(1:end, 3),1); %retweet data for monday (logical indexing)
for j=1:length(samplesize)

	n=samplesize(j); %number of tweets on Monday (in sample)


	k=sum(montweets(1:n)); %number of retweeted tweets on monday (in sample) 

	%calculate pdf p(theta) across theta vals

	for i=1:length(theta)
		%posterior
		ptheta(j,i)=(theta(i)^(k+1)*(1-theta(i))^(n-k+1))/(beta(k+2,n-k+2));
	end
end

plot(theta(:),ptheta(1,:),'r-', 'linewidth', 2);
hold on
plot(theta(:),ptheta(2,:),'b-','linewidth', 2);
plot(theta(:),ptheta(3,:),'k-','linewidth', 2);
ylabel('$P(\theta \mid x)$','interpreter','latex','fontsize',20);
xlabel('$\theta $','interpreter','latex','fontsize',20);
legend('1 sample','100 samples','1000 samples');
title('Posterior distribution for Monday');
print('-depsc2','/afs/inf.ed.ac.uk/user/s13/s1367329/Documents/mlpr/assignment/qb1plot.eps');
%hold off



hold off


