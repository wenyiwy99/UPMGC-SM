clear
clc
warning off



data_name = '3Sources_fea';

load(['../', data_name]);
rand('twister',5489);
k = length(unique(Y));
view_num = length(X);
smp_num = size(X{1}, 2);
addpath('../way/');

% disrupt the order
randIndex = zeros(view_num,smp_num);
for iv = 1:view_num
    randIndex(iv,:) = randperm(smp_num);
    X{iv} = X{iv}(:,randIndex(iv,:));
end




% parameters from LSR
lambdaset = [0.004,0.4];

S_temp = cell(1,view_num);
obj =zeros(1,view_num);
lbd_len = length(lambdaset);
fprintf('LSR+Ours %s', data_name);
for j = 1:lbd_len
    % LSR graph generation
    for i = 1: view_num
        [S_temp{i},obj(i)] = LSR(X{i} , lambdaset(j)) ; 
    end
    i_star = find(obj==min(obj));
    beta = 1./((sum(1./obj)*obj).^2);
    Y_temp = Y(randIndex(i_star,:));
    
    S_aligned = align(S_temp,i_star,beta);
    U = baseline_spectral_onkernel(S_aligned , k);
    [res, std] = myNMIACCwithmean(U,Y_temp,k);
    fprintf('\nacc: %f, af: %f, nmi: %f, n1: %f,pur: %f, p1: %f,', res(1), std(1), res(2),std(2),res(3),std(3));
end