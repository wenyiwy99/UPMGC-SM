clear
clc
warning off

data_name = 'BBCSport3_fea';

load(['..\', data_name]);
addpath('../way/');
addpath('./funs/');
rand('twister',5489);
k = length(unique(Y));
view_num = length(X);
smp_num = size(X{1}, 2);

% disrupt the order
randIndex = zeros(view_num,smp_num);
for iv = 1:view_num
    randIndex(iv,:) = randperm(smp_num);
    X{iv} = X{iv}(:,randIndex(iv,:));
end
X = normalize_data(X);

S_temp = cell(1,view_num);
obj =zeros(1,view_num);
X_temp = cell(1,1);
fprintf('GMC+Ours %s',data_name);
% GMC graph generation
for v = 1: view_num
    X_temp{1} = X{v};
    [S_temp{v},obj(v)] = GMC(X_temp, k); % k: the number of clusters
end
i_star = find(obj==min(obj));
Y_temp = Y(randIndex(i_star,:));
beta = 1./((sum(1./obj)*obj).^2);
%graph matching 
S_aligned = align(S_temp,i_star,beta);
[U] = baseline_spectral_onkernel( S_aligned , k);
[res, std] = myNMIACCwithmean(U,Y_temp,k);
fprintf('\nacc: %f, af: %f, nmi: %f, n1: %f,pur: %f, p1: %f,', res(1), std(1), res(2),std(2),res(3),std(3));




