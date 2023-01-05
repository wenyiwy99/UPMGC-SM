clear
clc
warning off

data_path = '..\';

data_name = 'ORL_fea.mat';

%load data
load([data_path, data_name]);
rand('twister',5489);
k = length(unique(Y));
view_num = length(X);
smp_num = size(X{1}, 2);
addpath('../way/');
% disrupt the order
randIndex = zeros(view_num,smp_num);
for v = 1:view_num
    randIndex(v,:) = randperm(smp_num);
    X{v} = X{v}(:,randIndex(v,:));
end
X = normalize_data(X);
ker_num = view_num*5;

% parameters from CoMSC
cset = [1:1:20]*k;
len_cset = length(cset);
lambda_1_set = 2.^[-10:2:10];
len_lbd1 = length(lambda_1_set);
max_iter = 20;

best_acc = 0;
best_nmi = 0;
best_pur = 0;
S_temp = cell(1,view_num);

fprintf('CoMSC+Ours %s,', data_name);
for ic=1:length(cset)
    if cset(ic)>=smp_num
      break;
    end
    for il=1:len_lbd1
        obj = zeros(1,view_num);
        % CoMSC graph generation
        for v = 1:view_num
            [S_temp{v}, obj(v)] = CoMSC(X{v}, cset(ic), lambda_1_set(il),max_iter);
        end
        beta = 1./((sum(1./obj)*obj).^2);
        i_star = find(beta==max(beta));
        Y_temp = Y(randIndex(i_star,:));
        %graph matching 
        S_aligned = align(S_temp,i_star,beta);
        [U] = baseline_spectral_onkernel( S_aligned, k);
        [res, std] = myNMIACCwithmean(U,Y_temp,k);
        fprintf('\nc: %d, lambda1: %d,  acc: %f, af: %f, nmi: %f, n1: %f,pur: %f, p1: %f,',cset(ic), lambda_1_set(il), res(1), std(1), res(2),std(2),res(3),std(3));
    end
end

