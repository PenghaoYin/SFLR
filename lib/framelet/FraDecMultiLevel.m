function Dec=FraDecMultiLevel(A,D,L)
% 我觉得这就是W

% function Dec=FraDecMultiLevel(A,D,L)
% This function implement framelet decomposition up to level L.
% A ==== the data to be decomposed, which are in a square matrix.
% D ==== is the decomposition filter in 1D. 
% L ==== is the level of the decomposition.
% Dec ==== is the framlet coefficient.

[len,num] = size(A);
nD = size(D,1);
Dec = zeros(len*nD*L,num);
kDec=A;
for k=1:L
    Dec(len*nD*(k-1)+1: len*nD*k,:) = FraDec(kDec,D,k);
    kDec = Dec(len*nD*(k-1)+1:len*nD*(k-1)+len,:);
end

% [m,n]=size(A);
% kDec=A;
% Dec=[];
% SorAS=D{nD};
% for k=1:L
%     for i=nD-1:-1:1
%         M1=D{i};
%         for j=nD-1:-1:1
%             M2=D{j};
%             temp=ConvSymAsym(kDec,M1,SorAS(i),L);
%             temp=ConvSymAsym(temp',M2,SorAS(j),L);
%             temp=temp';
%             if (i==1)&(j==1)
%                 kDec=temp;
%             else
%                 Dec=[Dec;temp];
%             end
%         end
%     end
% end
% Dec=[Dec;kDec];