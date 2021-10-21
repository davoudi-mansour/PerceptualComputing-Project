function Y = LWA9(X,W)

% to compute the LWA [1,2] for IT2 FSs which are each defined by nine
% parameters in Fig. 1 of Readme.doc. The output is also an IT2 FS 
% described by nine parameters.
%
% [1] Dongrui Wu and Jerry M. Mendel, "Aggregation using the linguistic 
% weighted average and interval type-2 fuzzy sets," IEEE Trans. on Fuzzy 
% Systems, vol. 15, no. 6, pp. 1145--1161, 2007.
%
% [2] Dongrui Wu and Jerry M. Mendel, "Corrections to 'Aggregation using 
% the linguistic weighted average and interval type-2 fuzzy sets'," IEEE 
% Trans. on Fuzzy Systems, in press.
%
% Dongrui WU (dongruiw@usc.edu), 5/12/2008
%
% X: the matrix containing the FOUs for the subcriteria. Each FOU
% is determined by 9 parameters.
% W: the matrix containing the FOUs for the weights. Each FOU is determined
% by 9 parameters. Note that each line of W1 is corresponding to the
% weight for the corresponding line in X1.
%
% UMFYy and UMFYu: y- and u-coordinates of the UMF of the LWA
%
% LMFYy and LMFYu: y- and u-coordinates of the LMF of the LWA

[M,N]=size(X);
UMFXx=X(:,1:4);
LMFXx=X(:,5:8);
UMFWw=W(:,1:4);
LMFWw=W(:,5:8);

UMFXu=zeros(M,4);
LMFXu=zeros(M,4);
UMFWu=zeros(M,4);
LMFWu=zeros(M,4);

for i=1:M
    UMFXu(i,:) =[0 1 1 0];
    UMFWu(i,:) =[0 1 1 0];
    LMFXu(i,:) =[0 X(i,9) X(i,9) 0];
    LMFWu(i,:) =[0 W(i,9) W(i,9) 0];
end

[UMFYy,UMFYu,LMFYy,LMFYu] = LWA(UMFXx,UMFXu,LMFXx,LMFXu,UMFWw,UMFWu,LMFWw,LMFWu,2);

Y=[UMFYy,LMFYy,max(LMFYu)];

