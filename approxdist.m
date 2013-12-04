function [p] =approxdist(x)

p=(0.8*normdist(x,50,3)) + (0.2*normdist(x,70, 3 ));






end