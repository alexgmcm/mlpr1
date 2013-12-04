%profile on;
load('features.mat');
rand('state',2);
randn('state',2);
nsamps=20000;
burnin=5000;
nsamps=nsamps+burnin;
SPLIT_INDEX = floor(size(features,1) * (4 /5));


ytrain=features(1:SPLIT_INDEX,1); %retweet data
ytest=features((SPLIT_INDEX+1):end,1);

xtrain=features(1:SPLIT_INDEX,2:end); %features
xtrain=[ones(size(xtrain,1),1 ) xtrain]; %add dummy feature to deal with bias term w0

xtest=features((SPLIT_INDEX+1):end,2:end); %features
xtest=[ones(size(xtest,1),1 ) xtest]; %add dummy feature to deal with bias term w0

clear features;

w=zeros(size(xtrain,2),nsamps+1); %initialise weights to 0, including w0

accept=0;
j=1;
for i= 1:nsamps
%use multivariate gaussian with N(x,I) as proposal
%therefore each weight is sampled from an independent gaussian w/variance 1
	if mod(i,200)==0
		i/200 %progress meter
	end
	wprime=w(:,i);
	wprime(j)=wprime(j)+randn;
	logalpha=logtargetdist(ytrain,xtrain,wprime) - logtargetdist(ytrain,xtrain,w(:,i));
	%logalpha=logtargetdist(ytrain,xtrain(:,j),wprime(j)) - logtargetdist(ytrain,xtrain(:,j),w(j,i));
	%faster but less accurate ~0.5% difference - deals with each weight entire individually is that valid?
	logr=min(0,logalpha);
	logu=log(rand);
	if logu <= logr %then accept
		w(:,i+1)=wprime;
		accept=accept+1;
	else %reject
		w(:,i+1)=w(:,i);
	end
	j=j+1;
	if j > size(w,1)
		j=1;
	end
	
end

accept=accept/nsamps; %acceptance rate



%%%plot classification accuracy
% j=1;
% classaccuracy=zeros(201,1);
% for i=1:100:20001;
% 	wtest=w(:,i);
% 	prediction=(sigmoid(xtest*wtest))>=0.5;
% 	classaccuracy(j)=sum((ytest==prediction))/length(ytest);
% 	j=j+1;
% end

%%%% PART B PLOTS %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%
% hold off;
% plot(1:100:20001,classaccuracy,'-k','linewidth',2);
% xlim([0 20001]);
% ylabel('Classification Accuracy','interpreter','latex','fontsize',14);
% xlabel('Sample No.','interpreter','latex','fontsize',14);
% title('Classification accuracy at each 100 training samples','interpreter','latex','fontsize',12);
% print('-depsc2','/afs/inf.ed.ac.uk/user/s13/s1367329/Documents/mlpr/assignment/classacc1.eps');

% hold off;

% %plot three weights, remember w(1) is bias term
% plot(1:size(w,2),w(2,:),'-k','linewidth',2);
% xlim([0 20001]);
% ylabel('Weight on No. of friends','interpreter','latex','fontsize',14);
% xlabel('Sample No.','interpreter','latex','fontsize',14);
% title('Weight value versus sample number','interpreter','latex','fontsize',12);
% print('-depsc2','/afs/inf.ed.ac.uk/user/s13/s1367329/Documents/mlpr/assignment/friendsweight.eps');

% hold off;

% plot(1:size(w,2),w(7,:),'-k','linewidth',2);
% xlim([0 20001]);
% ylabel('Weight on No. of URLs','interpreter','latex','fontsize',14);
% xlabel('Sample No.','interpreter','latex','fontsize',14);
% title('Weight value versus sample number','interpreter','latex','fontsize',12);
% print('-depsc2','/afs/inf.ed.ac.uk/user/s13/s1367329/Documents/mlpr/assignment/urlsweight.eps');

% hold off;


% plot(1:size(w,2),w(59,:),'-k','linewidth',2);
% xlim([0 20001]);
% ylabel('Weight on final bag of words','interpreter','latex','fontsize',14);
% xlabel('Sample No.','interpreter','latex','fontsize',14);
% title('Weight value versus sample number','interpreter','latex','fontsize',12);
% print('-depsc2','/afs/inf.ed.ac.uk/user/s13/s1367329/Documents/mlpr/assignment/bowweight.eps');
% hold off;




%%% PART C CODE %%%
%%%%%%%%%%%%%%%%%%%
%remember w(1) is bias
bar(2:59, (sum(w(2:59,burnin:end),2)./(size(w,2)-burnin)),0.5,'k');
xlim([2 59]);
ylabel('Final posterior mean of the weight','interpreter','latex','fontsize',16);
xlabel('Feature id','interpreter','latex','fontsize',16);

print('-depsc2','/afs/inf.ed.ac.uk/user/s13/s1367329/Documents/mlpr/assignment/finpost.eps');


% %%%%%%%%EXTRA ROC CODE%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% finpostweights=(sum(w(1:59,burnin:end),2)./(size(w,2)-burnin));
% [X,Y,T,AUC,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(ytest,sigmoid(xtest*finpostweights),1) %classifier ROC
% [X2,Y2,T2,AUC2,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(ytest,zeros(length(ytest,1),1) %ROC of worthless classifier (always 0)
% %should just be straight line y=x but worth checking as MATLAB can do it in milliseconds
% plot(X,Y,'-k','linewidth',2);
% hold on;
% plot(X2,Y2,'--k','linewidth',2);
% legend('My classifier','Useless classifier (Always 0)');
% ylabel('True positive rate (sensitivity)','fontsize',16);
% xlabel('False positive rate (1-specificity)','fontsize',16);
% title('ROC Curves','fontsize',16)
% print('-depsc2','/afs/inf.ed.ac.uk/user/s13/s1367329/Documents/mlpr/assignment/roc.eps');