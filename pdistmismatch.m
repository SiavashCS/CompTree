function [ dists ] = pdistmismatch( A,B )
%PDISTMISMATCH Summary of this function goes here
%   Detailed explanation goes here

dists = zeros(size(A,1),size(B,1));

for i=1:size(A,1)
    for j=1:size(B,1)
        dists(i,j) = sum (A(i,:)~=B(j,:));
    end
end

    

end

