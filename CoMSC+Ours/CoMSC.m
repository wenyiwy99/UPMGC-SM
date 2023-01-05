function [Z, obj1 ] = CoMSC(X, c, lambda_1, max_iter)
% Code-Reference:
%Jiyuan Liu:  [Multi-view Subspace Clustering via Co-training Robust Data Representation]
%(https://liujiyuan13.github.io/pubs/CoMSC_TNNLS.pdf), IEEE Transactions on Neural Networks and Learning Systems, TNNLS (Accepted Mar. 2021).
K = constr_K(X);
ker_num = size(K, 3);
smp_num = size(K, 1);

U = zeros(c, smp_num, ker_num);
for p=1:ker_num
    Utmp = my_kernel_kmeans(K(:,:,p), c);
    U(:,:,p) = Utmp';
end
beta = ones(ker_num, 1)/ker_num;
gamma = ones(ker_num, 1)/ker_num;

t = 0;
flag = 1;
while flag
    %% update Z
    Z = update_Z(U, beta, lambda_1);
    %% update U 
    U = update_U(K, Z, beta, gamma, c);
    %% update beta
    beta = update_beta(U, Z);
    %% update gamma
    gamma = update_gamma(K, U);
    t = t+1;
    [obj(t),~,~,~] = cal_obj(K, U, Z, beta, gamma, lambda_1);
    if t>=2 && (abs((obj(t-1)-obj(t))/(obj(t)))<1e-5 || t>max_iter)
        flag =0;
        obj1 =0;
        for p = 1:ker_num
            obj1 = obj1 + sum(sum((U(:,:,p)-U(:,:,p)*Z).^2));
        end
        PI = Z > 0;
        Z = Z.*PI;
        Z = abs( (Z + Z') / 2);
    end
end
  
  
end
