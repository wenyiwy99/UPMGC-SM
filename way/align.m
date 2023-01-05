function [S_aligned] = align(S,Index,alpha)
num_view = length(S);
S_aligned = S{Index};
P = cell(1, num_view); 
P{Index(1)} = eye(size(S_aligned,1));
S_aligned = alpha(Index)*S{Index};

for iv = 1:num_view
    if iv ~= Index
    [P{iv}] = DSPFP(S{Index},S{iv});
    S_aligned = S_aligned+alpha(iv)*P{iv}'*S{iv}*P{iv};
    end
end
