% input matrix of size [p,m*n]
% output tensor of size [m,n,p]
function inversed_L_tensor = L_inverse_operator(matrix,m,n,p)

inversed_L_tensor = reshape(matrix',[m,n,p]);

end