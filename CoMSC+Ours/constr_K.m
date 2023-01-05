function [K] = constr_K(X)
% X: d*n data matrix
smp_num = size(X, 2);
K = zeros(smp_num, smp_num, 5);
options.KernelType = 'Gaussian';
K(:,:,1) = construct_kernel(X', [], options);
options.KernelType = 'Polynomial';
options.d = 3;
K(:,:,2) = construct_kernel(X', [], options);
options.KernelType = 'Linear';
K(:,:,3) = construct_kernel(X', [], options);
options.KernelType = 'Sigmoid';
options.c = 0;
options.d = 0.1;
K(:,:,4) = construct_kernel(X', [], options);
options.KernelType = 'InvPloyPlus';
options.c = 0.01;
options.d = 1;
K(:,:,5) = construct_kernel(X', [], options);
K = kcenter(K);
K = knorm(K);
end

