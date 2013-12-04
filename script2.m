load('dowfeatures.mat')

%actually use boolean indices

d=dowfeatures(dowfeatures(1:1,3),1);
%d=dowfeatures(1:1,[1,3]);
z=linspace(0.00001,0.99,1000);
N=size(d,1);


%P(p|D) = \frac{ p^{n+1} (1-p)^{N-n+1}}{B(n+2, N-n+2)}
post=z;
for i=1:1000,
  p=z(i);
  n=sum(d);
  post(i)=((p^(n+1))*((1-p)^(N-n+1)))/beta(n+2, N-n+2);
end

plot(z, post)
title('monday n=1')
print('-depsc2', './n=1monday2.eps');









