% input tensor of size [m,n,p]
% output matrix of size [p,m*n]
function L_tensor = L_operator(tensor)

[m, n, p] = size(tensor);

reshaped_matrix = reshape(tensor,[m*n,p]);
L_tensor = reshaped_matrix';

end