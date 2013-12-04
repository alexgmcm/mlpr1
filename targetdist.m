function p = targetdist(y,x,w)
	%has w_0 bias term, 
	%this can be dealt with by adding an extra feature (with value 1) to the data
%use log to avoid numerical error

p= y*log(w'*x) + (1-y)*log(1 - sigmoid(w'*x));
end