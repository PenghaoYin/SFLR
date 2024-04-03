function C=ConvSymAsym(A,M,L)


[Len,num]       = size(A);
nM      = length(M);
step    = 2^(L-1);
ker     = zeros(step*(nM-1)+1,1);
ker(1:step:step*(nM-1)+1,1)=M;
C=ifft(repmat(psf2otf(ker,Len),[1,num]).*fft(A,[],1),[],1);
 