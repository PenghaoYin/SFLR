function U = HU_HP(lrms,pan,paras)

%% Initial parameters
alpha = paras.alpha;
beta = paras.beta;
gamma1 = paras.gamma1;
gamma2 = paras.gamma2;
gamma3 = paras.gamma3;
gamma4 = paras.gamma4;
level = 1; frame = 1;

max_iter = 200; tol = 2e-5;

M = interp23tap(lrms,paras.ratio);
[m,n,p] = size(M);
Nways = [m,n,p];
P = hist_mapping(lrms, pan, paras.ratio, paras.sz/paras.ratio);
par = FFT_kernel(paras.ratio,paras.sensor,Nways);

A = diag(-ones(1, p)) + diag(ones(1, p-1), 1); % differential through dimension z

%% Initial Multipliers
[D,R] = GenerateFrameletFilter(frame);
U = rand(Nways); 
U1 = rand(Nways);
U2 = rand(Nways);
[r,~] = size(FraDecMultiLevel(rand(p,m*n),D,level));
G = rand(r,m*n);
B = rand(p,m*n);
Lambda1 = rand(Nways); 
Lambda2 = rand(Nways); 
Lambda3 = rand(r,m*n); 
Lambda4 = rand(p,m*n); 
%% Start Iterations
for iter = 1:max_iter
    temp_U = U;

    % Update U1
    LU1 = (1/(gamma1+gamma3))*(gamma1*L_operator(U-Lambda1)+...
        gamma3*FraRecMultiLevel(G+FraDecMultiLevel(L_operator(P),D,level)+Lambda3,R,level));
    U1 = L_inverse_operator(LU1,m,n,p);

    % Update U2
    LU2 = pinv(gamma2*eye(size(A'*A))+gamma4*(A'*A))*(gamma2*L_operator(U-Lambda2)+gamma4*A'*(B+Lambda4));
    U2 = L_inverse_operator(LU2,m,n,p);

    % Update G
    Y = FraDecMultiLevel(L_operator(U1-P),D,level)-Lambda3;
    G = sign(Y).*max((abs(Y)-alpha/gamma3),0);
    
    % Update B
    [U_, S_, V_] = svd(A*L_operator(U2)-Lambda4,'econ');
    D_Sigma = max(S_-beta/gamma4,0);
    B = U_*D_Sigma*V_';

    % Update U
    temp = zeros(m,n,p);
    for band = 1:p
        denominator = par.fft_B(:,:,band).*par.fft_BT(:,:,band)+(gamma1+gamma2);
        numerator = par.fft_BT(:,:,band).*fft2(M(:,:,band))+gamma1*fft2(U1(:,:,band) ...
            +Lambda1(:,:,band))+gamma2*fft2(U2(:,:,band)+Lambda2(:,:,band));
        temp(:,:,band) = real(ifft2(numerator./denominator));
    end
    U = temp;


    % Update Multipliers
    Lambda1 = Lambda1 + U1 - U;
    Lambda2 = Lambda2 + U2 - U;
    Lambda3 = Lambda3 + G - FraDecMultiLevel(L_operator(U1-P),D,level);
    Lambda4 = Lambda4 + B - A*L_operator(U2);

    rel_err = norm(Unfold(U-temp_U,Nways,3),'fro')/norm(Unfold(temp_U,Nways,3),'fro');
    if rel_err < tol
        disp(iter);
        break;
    end
end

end