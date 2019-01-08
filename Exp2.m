clear;
close all;
addpath('Datasets/');
addpath('RCT/');

iterations = 5;
mkdir('Figs');
for data_num = 1:4
[ data, data_title,w_range,n0_range] = chooseDS(data_num);
n= size(data,1);
disp(['Running RCT on ',data_title,' with n=',num2str(n)]);
train = n - 1000;

[IDXTeTr, DistsTeTr] = knnsearch(data(1:train,:),data(train+1:end,:),'k',1);

queryTripletsRCTIT = zeros(iterations,length(w_range));
treeTripletsRCTIT = zeros(iterations,length(w_range));
ERRRCTIT = zeros(iterations,length(w_range));
RDERCTIT = zeros(iterations,length(w_range));

parfor w_it=1:length(w_range)
    for it=1:iterations
        w = w_range(w_it)
        % makes an RCT tree over data(1:train,:) with h=4 as stated in RCT
        % tree to be the most promising height 
        [RCT,treeTripletsRCTIT(it,w_it)] = RCTBuild(data(1:train,:),w,floor(log(train)/log(4)));
        
        % testing on train+1:n
        predictedNNRCT = zeros(1,n-train); 
        RCT.data = data; % addning test set to RCT structure for the evaluation phase
        tripsQuery = zeros(1,n-train);
        for q = train+1:n
            [predictedNNRCT(q-train), tripsQuery(q-train)]= RCTFindNN(RCT,q,1);
        end
        PRDistsTeTr = sqrt(sum((data(predictedNNRCT,:)-data(train+1:end,:)).^2,2));
        RDERCTIT(it,w_it) = sum(PRDistsTeTr./DistsTeTr-1)/(n-train);
        ERRRCTIT(it,w_it)  = sum(IDXTeTr~=predictedNNRCT')/(n-train);
        queryTripletsRCTIT(it,w_it) = mean(tripsQuery);
    end
end

ERRRCT = mean(ERRRCTIT);
RDERCT = mean(RDERCTIT);
queryTripletsRCT = mean(queryTripletsRCTIT);
treeTripletsRCT = mean(treeTripletsRCTIT);


%%
queryTripletsCTIT = zeros(iterations,length(n0_range));
treeTripletsCTIT = zeros(iterations,length(n0_range));
ERRCTIT = zeros(iterations,length(n0_range));
ERRDSCTIT = zeros(iterations,length(n0_range));

disp(['Running CompTree on ',data_title,' with n=',num2str(n)]);

parfor nit = 1:length(n0_range)
    n0 = n0_range(nit);
    
    for it=1:iterations
        
        [SetsCT, heiCT, treeTripletsCTIT(it,nit),SetsTest]= makeCTreeTrTe(data(1:train,:),1:train,n0,0,data(1+train:end,:),train+1:n);
        
        predictedNNCT = zeros(1,n);
        predictedDSCT = zeros(1,n);
        for i=1:length(SetsCT)
            dists = pdist2(data(SetsTest{i},:),data(SetsCT{i},:));
            [sortedDis,ind] = sort(dists,2);
            predictedNNCT(SetsTest{i})=SetsCT{i}(ind(:,1));
            queryTripletsCTIT(it,nit) = queryTripletsCTIT(it,nit) + (heiCT(i)-1+length(SetsCT{i}))*length(SetsTest{i});
            predictedDSCT(SetsTest{i}) = sortedDis(:,1);

        end
        
        ERRCTIT(it,nit) =  sum(predictedDSCT(1,train+1:end)'~=DistsTeTr(:,1))/ (n-train);
        ERRDSCTIT(it,nit) = sum(predictedDSCT(1,train+1:end)'./DistsTeTr(:,1)-1)/ (n-train);

    end

end
ERRCT = mean(ERRCTIT);
RDECT = mean(ERRDSCTIT);

querytripletsCT = mean(queryTripletsCTIT)/(n-train);
treeTripletsCT = mean(treeTripletsCTIT);

makeFigsCompRCT
savefig(['Figs/Exp2-',data_title,'.fig']);
save(['Figs/Exp2-',data_title,'.mat']);
end

clear all;
close all;
addpath('Datasets/');
addpath('RCT/');

iterations = 5;

for data_num = 5:5
[ data, data_title,w_range,n0_range] = chooseDS(data_num);% distMat = pdist2(data,data);
% data = data(1:28000,:);
n= size(data,1);
train = n - 1000;

[IDXTeTr, DistsTeTr] = knnsearch(data(1:train,:),data(train+1:end,:),'k',1,'dist',@pdistmismatchcol);


queryTripletsRCTIT = zeros(iterations,length(w_range));
treeTripletsRCTIT = zeros(iterations,length(w_range));
ERRRCTIT = zeros(iterations,length(w_range));
RDERCTIT = zeros(iterations,length(w_range));

parfor w_it=1:length(w_range)
    for it=1:iterations
        w = w_range(w_it)
        % makes an RCT tree over data(1:train,:) with h=4 as stated to be the most promising height 

        [RCT,treeTripletsRCTIT(it,w_it)] = RCTBuildDistF(data(1:train,:),w,floor(log(train)/log(4)),@pdistmismatch);

        % testing on train+1:n
        predictedNNRCT = zeros(1,n-train);
        RCT.data = data;
        tripsQuery = zeros(1,n-train);
        for q = train+1:n
            [predictedNNRCT(q-train), tripsQuery(q-train)]= RCTFindNNDistF(RCT,q,1,@pdistmismatch);
            
        end
        PRDistsTeTr = sum(data(train+1:end,:)~=data(predictedNNRCT,:),2); % changed to the distance sqrt(sum((dists(NN,:)-dists(train+1:end,:)).^2,2));
        RDERCTIT(it,w_it) = sum(PRDistsTeTr./DistsTeTr-1)/(n-train);
        ERRRCTIT(it,w_it)  = sum(PRDistsTeTr~=DistsTeTr)/(n-train);
        queryTripletsRCTIT(it,w_it) = mean(tripsQuery);
    end
end

ERRRCT = mean(ERRRCTIT);
RDERCT = mean(RDERCTIT);
queryTripletsRCT = mean(queryTripletsRCTIT);
treeTripletsRCT = mean(treeTripletsRCTIT);


%%
queryTripletsCTIT = zeros(iterations,length(n0_range));
treeTripletsCTIT = zeros(iterations,length(n0_range));

ERRCTIT = zeros(iterations,length(n0_range));
ERRDSCTIT = zeros(iterations,length(n0_range));


parfor nit = 1:length(n0_range)
    n0 = n0_range(nit)
        
    for it=1:iterations
        
        [SetsCT, heiCT, treeTripletsCTIT(it,nit),SetsTest]= makeCTreeTrTeDisF(data(1:train,:),1:train,n0,0,data(1+train:end,:),train+1:n,@pdistmismatch);
        
        predictedNNCT = zeros(1,n);
        predictedDSCT = zeros(1,n);
        for i=1:length(SetsCT)
            distsTeTr = pdistmismatch(data(SetsTest{i},:),data(SetsCT{i},:));
            [sortedDis,ind] = sort(distsTeTr,2);
            predictedNNCT(SetsTest{i})=SetsCT{i}(ind(:,1));
            queryTripletsCTIT(it,nit) = queryTripletsCTIT(it,nit) + (heiCT(i)-1+length(SetsCT{i}))*length(SetsTest{i});
            predictedDSCT(SetsTest{i}) = sortedDis(:,1);

        end
        
        ERRCTIT(it,nit) =  sum(IDXTeTr(:,1)'~=predictedNNCT(1,train+1:end))/ (n-train);
        ERRDSCTIT(it,nit) = sum(predictedDSCT(1,train+1:end)'./DistsTeTr(:,1)-1)/ (n-train);

    end

end
ERRCT = mean(ERRCTIT);
RDECT = mean(ERRDSCTIT);

querytripletsCT = mean(queryTripletsCTIT)/(n-train);
treeTripletsCT = mean(treeTripletsCTIT);

makeFigsCompRCT
savefig(['Figs/Exp2-',data_title,'.fig']);
save(['Figs/Exp2-',data_title,'.mat']);

end

for data_num = 6:7
[ dists, data_title,w_range,n0_range] = chooseDS(data_num);% distMat = pdist2(data,data);
n= size(dists,1);
train = n - 1000;


distsTeTr = dists(train+1:end,1:train);
[Mindists, MinInds] = sort(distsTeTr,2);
IDXTeTr = MinInds(:,1);
DistsTeTr = Mindists(:,1);

queryTripletsRCTIT = zeros(iterations,length(w_range));
treeTripletsRCTIT = zeros(iterations,length(w_range));
accRCTIT = zeros(iterations,length(w_range));
RDERCTIT = zeros(iterations,length(w_range));

parfor w_it=1:length(w_range)
    for it=1:iterations
        w = w_range(w_it)
        % makes an RCT tree over data(1:train,:) with h=4 as stated in RCT
        % tree to be the most promising height 
%         [RCT,treeTripletsRCTIT(it,w_it)] = RCTBuild(dists(1:train,:),w,floor(log(train)/log(4)));
        [RCT,treeTripletsRCTIT(it,w_it)] = RCTBuildDistM(dists(1:train,1:train),w,floor(log(train)/log(4)));

        % testing on train+1:n
        NN = zeros(1,n-train);
        RCT.data = dists;
        tripsQuery = zeros(1,n-train);
        for q = train+1:n
            [NN(q-train), tripsQuery(q-train)]= RCTFindNNDistM(RCT,q,1);
            
        end
        PRDistsTeTr = diag(dists(train+1:end,NN)); % changed to the distance sqrt(sum((dists(NN,:)-dists(train+1:end,:)).^2,2));
        RDERCTIT(it,w_it) = sum(PRDistsTeTr./DistsTeTr-1)/(n-train);
        accRCTIT(it,w_it)  = sum(PRDistsTeTr~=DistsTeTr)/(n-train);
        queryTripletsRCTIT(it,w_it) = mean(tripsQuery);
    end
end

accRCT = mean(accRCTIT);
RDERCT = mean(RDERCTIT);
queryTripletsRCT = mean(queryTripletsRCTIT);
treeTripletsRCT = mean(treeTripletsRCTIT);


%%
queryTripletsCTIT = zeros(iterations,length(n0_range));
treeTripletsCTIT = zeros(iterations,length(n0_range));

errCTIT = zeros(iterations,length(n0_range));
errDSCTIT = zeros(iterations,length(n0_range));
n0_range = n0_range ;

% [IDXTe_Te, NNDists] = knnsearch(data(1:train,:),data(1:train,:),'K',2);
% [IDXTeTr, DistsTeTr] = knnsearch(data(1:train,:),data(train+1:end,:),'k',1);

parfor nit = 1:length(n0_range)
    n0 = n0_range(nit)
        
    for it=1:iterations
        
        [SetsCT, heiCT, treeTripletsCTIT(it,nit),SetsTest]= makeCTreeTrTeDisM(dists(1:train,1:train),1:train,n0,0,dists(1+train:end,1:train),train+1:n);
        
        predictedNNCT = zeros(1,n);
        predictedDSCT = zeros(1,n);
        for i=1:length(SetsCT)
            distsTeTr = dists(SetsTest{i},SetsCT{i});
            [sortedDis,ind] = sort(distsTeTr,2);
            predictedNNCT(SetsTest{i})=SetsCT{i}(ind(:,1));
            queryTripletsCTIT(it,nit) = queryTripletsCTIT(it,nit) + (heiCT(i)-1+length(SetsCT{i}))*length(SetsTest{i});
            predictedDSCT(SetsTest{i}) = sortedDis(:,1);

        end
        
        errCTIT(it,nit) =  sum(IDXTeTr(:,1)'~=predictedNNCT(1,train+1:end))/ (n-train);
        errDSCTIT(it,nit) = sum(predictedDSCT(1,train+1:end)'./DistsTeTr(:,1)-1)/ (n-train);

    end

end
accCT = mean(errCTIT)
RDECT = mean(errDSCTIT)

querytripletsCT = mean(queryTripletsCTIT)/(n-train)
treeTripletsCT = mean(treeTripletsCTIT);

makeFigsCompRCT
savefig(['Figs/Exp2-',data_title,'.fig']);
save(['Figs/Exp2-',data_title,'.mat']);
end