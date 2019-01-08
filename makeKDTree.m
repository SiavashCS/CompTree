function [ Sets , heights ] = makeKDTree( data,inds, n0 ,h)
%   constructs a KD-Tree based on n*p "data" matrix
%   input: 
%     data : n*p data points (n is the number of points)
%     inds : the indices of data opints to use (for recursion porpuse)
%     n0 : the maximum number of points allowed in each leaf
%     h : height of tree (in which this tree would be a subtree!)   
%   output:
%     Sets : cells containing the indices of points in each node 
%     h : array containing the height of the nodes
%     data: distance matric n*n in case of datasets without vector representation (data_num 6-7)


n=size(data,1);
d=size(data,2);
if n<n0  % checking if a leaf if reached
    Sets = {inds};
    heights=h+1;

    return;
end
S1=[];S2=[];
while(length(S1) <2 || length(S2)<2)

dim = randperm(d,1);
basis = zeros(d,1); % the vector to project on
basis(dim,1) = 1;
Prdata = data*basis;
med = median(Prdata);

% Choosing sets S1 and S2 based on the median of projection
S1 = find(Prdata<med);
S2 = find(Prdata>=med);
end
[S1,h1] = makeKDTree(data(S1,:),inds(S1),n0,h+1);
[S2,h2] = makeKDTree(data(S2,:),inds(S2),n0,h+1);

Sets = [S1,S2];
heights = [h1,h2];



end

