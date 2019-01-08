function [ dists ] = pdistmismatchcol( A,B )
%PDISTMISMATCH Summary of this function goes here
%   Detailed explanation goes here

dists = zeros(size(B,1),1);

    for j=1:size(B,1)
        dists(j,1) = sum (A(1,:)~=B(j,:));
    end


    

end

