function [logp] = logtargetdist(y,x,w)
	%has w_0 bias term, 
	%this can be dealt with by adding an extra feature (with value 1) to the data
%use log to avoid numerical error

logp= sum(y.*log(sigmoid(x*w)) + (1-y).*log(1 - sigmoid(x*w))) + sum(log(normdist(w,zeros(length(w),1),ones(length(w),1))));
end