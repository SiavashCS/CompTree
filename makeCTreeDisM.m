function [ Sets , heights, triplets] = makeCTreeDisM( dists,inds, n0, h )
%MAKETREE make a metric tree based on n*p "data" matrix, inds are the
%indexes of data opints to use (for recursion porpuse) and n0 is the
%maximum number of points allowed in each leaf
% output: Sets are cells containing the indices of points in each node of
% the tree, h is the height of the tree

n=size(dists,1);
if n<n0  % checking if a leaf is reached
    Sets = {inds};
    heights=h+1;
    triplets=0;
    return;
end

flag = 0;
while(flag==0) % empty cells shouldn't happen
    P = randperm(n,2);
    
    %% Choosing sets S1 and S2 based on the distance to P(1) and P(2)
    
    dists2 = dists(:,P);
    
    [~,minInd] = sort(dists2,2);
    S1 = find(minInd(:,1)==1);
    S2 = find(minInd(:,1)==2);
    if length(S1)>1 && length(S2)>1
        flag=1;
    end
    
end


[S1,h1,tr1] = makeCTreeDisM(dists(S1,S1),inds(S1),n0,h+1);
[S2,h2,tr2] = makeCTreeDisM(dists(S2,S2),inds(S2),n0,h+1);

Sets = [S1,S2];
heights = [h1,h2];
triplets = n + tr1+tr2;


end

