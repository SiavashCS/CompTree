% This code is provided as the supplementary material for the
% AISTAT17 paper "Comparison Based Nearest Neighbor Search". The script
% makes 4 nearest neighbor tree structures (KD-Tree,RP-Tree, PA-Tree,
% Comp-Tree) on 4 Euclidean datasets mentioned in the paper. Figure are
% plotted separately and saved in corresponding files.

clear all;
close all;
addpath('Datasets/');
mkdir('Figs');
%%
for data_num = 1:4
    
    [ data, data_title ] = chooseDS( data_num ); % choosing a data set
    iterations = 5; %number of repetitions of tree constructions
    n0_range = 2.^[5:10]; %max # of nodes in the leaves
    n= size(data,1);
    disp(['Making trees on ',data_title,' with n=',num2str(n)]);

    hei = zeros(iterations,length(n0_range));
    % average err prob of trees
    errRP = zeros(iterations,length(n0_range));
    errMT = zeros(iterations,length(n0_range));
    errKD = zeros(iterations,length(n0_range));
    errPA = zeros(iterations,length(n0_range));
    % average distance error of the trees
    errDSRP = zeros(iterations,length(n0_range));
    errDSMT = zeros(iterations,length(n0_range));
    errDSKD = zeros(iterations,length(n0_range));
    errDSPA = zeros(iterations,length(n0_range));
    % average height of the trees
    maxHeightRP = zeros(iterations,length(n0_range));
    maxHeightMT = zeros(iterations,length(n0_range));
    maxHeightKD = zeros(iterations,length(n0_range));
    maxHeightPA = zeros(iterations,length(n0_range));
    [IDX, NNDists] = knnsearch(data,data,'K',2); % computing NN and actual distance for evaluation of trees
    %%
    for nit = 1:length(n0_range)
        n0 = n0_range(nit)
        disp(['making trees for ',data_title,', n_0 = ',num2str(n0)])
        for it=1:iterations
            
            [SetsRP, heiRP]= makeRPTree(data,1:n,n0,0); % making RP-tree
            maxHeightRP(it,nit) = max(heiRP)-1;
            
            [SetsCT, heiCT]= makeCTree(data,1:n,n0,0); % making Comp-tree
            maxHeightMT(it,nit) = max(heiCT)-1;
            
            [SetsKD, heiKD]= makeKDTree(data,1:n,n0,0); % making KD-tree
            maxHeightKD(it,nit) = max(heiKD)-1;
            
            [SetsPA, heiPA]= makePATree(data,1:n,n0,0); % making PA-tree
            maxHeightPA(it,nit) = max(heiPA)-1;
            
            predictedNNRP = zeros(1,n);
            predictedNNMT = zeros(1,n);
            predictedNNKD = zeros(1,n);
            predictedNNPA = zeros(1,n);
            
            predictedDSRP = zeros(1,n);
            predictedDSMT = zeros(1,n);
            predictedDSKD = zeros(1,n);
            predictedDSPA = zeros(1,n);
            
            for i=1:length(SetsCT)
                dists = pdist2(data(SetsCT{i},:),data(SetsCT{i},:));
                [sortedDis,ind] = sort(dists);
                predictedNNMT(SetsCT{i})=SetsCT{i}(ind(2,:));
                predictedDSMT(SetsCT{i}) = sortedDis(2,:);
            end
            
            for i=1:length(SetsRP)
                dists = pdist2(data(SetsRP{i},:),data(SetsRP{i},:));
                [sortedDis,ind] = sort(dists);
                predictedNNRP(SetsRP{i})=SetsRP{i}(ind(2,:));
                predictedDSRP(SetsRP{i}) = sortedDis(2,:);
            end
            
            for i=1:length(SetsKD)
                dists = pdist2(data(SetsKD{i},:),data(SetsKD{i},:));
                [sortedDis,ind] = sort(dists);
                predictedNNKD(SetsKD{i})=SetsKD{i}(ind(2,:));
                predictedDSKD(SetsKD{i}) = sortedDis(2,:);
            end
            
            for i=1:length(SetsPA)
                dists = pdist2(data(SetsPA{i},:),data(SetsPA{i},:));
                [sortedDis,ind] = sort(dists);
                predictedNNPA(SetsPA{i})=SetsPA{i}(ind(2,:));
                predictedDSPA(SetsPA{i}) = sortedDis(2,:);
            end
            
            errRP(it,nit) = 1 - sum(IDX(:,2)==predictedNNRP(:))/ n;
            errMT(it,nit) = 1 - sum(IDX(:,2)==predictedNNMT(:))/ n;
            errKD(it,nit) = 1 - sum(IDX(:,2)==predictedNNKD(:))/ n;
            errPA(it,nit) = 1 - sum(IDX(:,2)==predictedNNPA(:))/ n;
            
            errDSRP(it,nit) = (sum(predictedDSRP(:)./NNDists(:,2))-n)/ n;
            errDSMT(it,nit) = (sum(predictedDSMT(:)./NNDists(:,2))-n)/ n;
            errDSKD(it,nit) = (sum(predictedDSKD(:)./NNDists(:,2))-n)/ n;
            errDSPA(it,nit) = (sum(predictedDSPA(:)./NNDists(:,2))-n)/ n;
            
        end
    end
    makeFigsTrees
    savefig(['Figs/Exp1-',data_title,'.fig']);
    save(['Figs/Res_',data_title,'.mat']);
end
%%

