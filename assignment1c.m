load('dowfeatures.mat');



%Posterior for all days, all data, separate plots


theta=0:0.001:1;
ndays=7;
ptheta=zeros(ndays,length(theta));
dailyrtdata=cell(ndays,1);%retweet data for each day
for i=1:ndays
	dailyrtdata{i,:}=dowfeatures(dowfeatures(1:end, i+1),1); 
end

for j=1:ndays

	

	n=sum(dowfeatures(:,j+1));
	k=sum(dailyrtdata{j,1:end}); %number of retweeted tweets on single day

	%calculate pdf p(theta) across theta vals

	for i=1:length(theta)
		%posterior
		ptheta(j,i)= log(theta(i)^(k+1)) + log((1-theta(i))^(n-k+1)) - (betaln(k+2,n-k+2)); %use ln(p)
	end
end

hold off
MAPs=zeros(7,1);
MAPsindex=zeros(7,1);
for i=1:7

	plot(theta(:),exp(ptheta(i,:)),'k-','linewidth', 2);
	ylabel('$P(\theta \mid x)$','interpreter','latex','fontsize',20);
	xlabel('$\theta $','interpreter','latex','fontsize',20);

	switch i
		case 1
			title('Posterior distribution for Sunday');
			print('-depsc2','/afs/inf.ed.ac.uk/user/s13/s1367329/Documents/mlpr/assignment/sundayplot.eps');
		case 2
			title('Posterior distribution for Monday');
			print('-depsc2','/afs/inf.ed.ac.uk/user/s13/s1367329/Documents/mlpr/assignment/mondayplot.eps');
		case 3
			title('Posterior distribution for Tuesday');
			print('-depsc2','/afs/inf.ed.ac.uk/user/s13/s1367329/Documents/mlpr/assignment/tuesdayplot.eps');
		case 4
			title('Posterior distribution for Wednesday');
			print('-depsc2','/afs/inf.ed.ac.uk/user/s13/s1367329/Documents/mlpr/assignment/wednesdayplot.eps');
		case 5
			title('Posterior distribution for Thursday');
			print('-depsc2','/afs/inf.ed.ac.uk/user/s13/s1367329/Documents/mlpr/assignment/thursdayplot.eps');
		case 6
			title('Posterior distribution for Friday');
			print('-depsc2','/afs/inf.ed.ac.uk/user/s13/s1367329/Documents/mlpr/assignment/fridayplot.eps');
		case 7
			title('Posterior distribution for Saturday');
			print('-depsc2','/afs/inf.ed.ac.uk/user/s13/s1367329/Documents/mlpr/assignment/saturdayplot.eps');
		otherwise
        	warning('Unexpected day value. No plot saved.');
	end



%plot MAPs
[~, MAPsindex(i)]=max(exp(ptheta(i,:)));
MAPs(i)=theta(MAPsindex(i));

end
%legend('1 sample','100 samples','1000 samples');


hold off
bar(MAPs,0.1,'k')
set(gca,'XTickLabel',{'Sunday', 'Monday', 'Tuesday', 'Wednesday','Thursday','Friday','Saturday'});
title('MAP estimates for retweet probability on each day');
print('-depsc2','/afs/inf.ed.ac.uk/user/s13/s1367329/Documents/mlpr/assignment/MAPests.eps');


hold off
