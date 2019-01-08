function [ data, data_title,w_range,n0_range ] = chooseDS( data_num )
%   chooses among various datasets
%   input: 
%     data_num : the ID of dataset to choose ranging 1-7     
%   output:
%     data: data point n*p in case of datasets with vector representation (data_num 1-5)
%     data: distance matric n*n in case of datasets without vector representation (data_num 6-7)
%     n: num
%     data_title: title of the dataset
%     w_range: adjusted w_range for the RCT algorithm
%     n0_range: adjusted n0_range for the comparison tree algorithm

switch data_num
    
    case 1
        load('MNIST.mat');
        data = fea; data_title= 'MNIST';w_range = 2:7;n0_range = [500:500:3000];
    case 2
        load('gisset.mat');
        data = gissete; data_title= 'Gisette';w_range = 2:2:16;n0_range = [250:1000:8000];
    case 3
        load('coverType.mat');
        data = covtype; data_title= 'CoverType';w_range = 2:7;n0_range = [250:500:3000];
    case 4
        load('CorelCleaned.mat');
        data = corel; data_title= 'Corel';w_range = 2:7;n0_range = [250:500:3000];
    case 5
        load('chessKKR');
        data_title= 'Chess';w_range = 2:8;n0_range = 2.^[7:11];
    case 6
        load('coauthorPhys');
        data = dists; data_title= 'CoAuth';w_range = 2:7;n0_range = [500:500:3000];
    case 7
        load('mscdists');
        data = dists; data_title= 'MSC';w_range = 2:3:15;n0_range = [500:500:4000];
end

end

