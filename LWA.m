function [UMFYy,UMFYmu,LMFYy,LMFYmu] = LWA(UMFXx,UMFXmu,LMFXx,LMFXmu,UMFWw,UMFWmu,LMFWw,LMFWmu,n)

% to compute the LWA [1,2] for IT2 FSs (or the special cases of T1 FSs,
% intervals or numbers) whose FOUs have arbitrary shapes, i.e., an FOU may not be a 
% trapezoid determined by the nine parameters in Fig. 1 of Readme.doc.
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
% UMFXx and UMFXmu: x- and mu-coordinates of the UMF of X. Note that
% the two matrices must have the same size.
%
% LMFXx and LMFXmu: x- and mu-coordinates of the LMF of X. Note that
% the two matrices must have the same size.
%
% UMFWx and UMFWmu: x- and mu-coordinates of the UMF of W. Note that
% the two matrices must have the same size, and they must have the same
% number of rows as UMFXx.
%
% LMFWx and LMFWmu: x- and mu-coordinates of the LMF of W. Note that
% the two matrices must have the same size, and they must have the same
% number of rows as LMFXx.
%
% UMFYy and UMFYmu: y- and mu-coordinates of the UMF of the LWA
%
% LMFYy and LMFYmu: y- and mu-coordinates of the LMF of the LWA
%

%% check whether the size of the vectors match
if sum(size(UMFXx)~=size(UMFXmu)) |sum(size(LMFXx)~=size(LMFXmu))...
        | sum(size(UMFWw)~=size(UMFWmu)) | sum(size(LMFWw)~=size(LMFWmu))
    display('Error: The sizes of the input vectors do not match. Abort.');
    return
end

%% find the maximum length of the input vectors
[N,lengUMFX]=size(UMFXx);  %% N: number of rows
a=zeros(1,N);
b=zeros(1,N);
c=zeros(1,N);
d=zeros(1,N);

UMFYmu=[0:1/(n-1):1 1:-1/(n-1):0]; %% u-coordinates of the UMF of the LWA

%% %%%%%%%%%%%%%%%%%%%% UMF   %%%%%%%%%%%%%%%%%%%%
% alpha==0
for j=1:N  %% for each input, compute the alpha-cut
    %% a,b: alpha-cut on X
    temp=find(UMFXmu(j,:)>0);
    indexa=min(temp)-1;  %% locate the interval where UMFYmu(i) lies in
    a(j)=UMFXx(j,indexa);
    indexb=max(temp)+1;
    b(j)=UMFXx(j,indexb);
    %% c,d: alpha-cut on W
    temp=find(UMFWmu(j,:)>0);
    indexc=min(temp)-1;
    c(j)=UMFWw(j,indexc);
    indexd=max(temp)+1;
    d(j)=UMFWw(j,indexd);
end
UMFYy(1)=EKM(a,c,d,-1);
UMFYy(2*n)=EKM(b,c,d,1); %% KM algorithm to compute the alpha-cut on the UMF of the LWA

%% alpha>0
for i=2:n %% for each alpha-cut
    for j=1:N  %% for each input, compute the alpha-cut
        %% a,b: alpha-cut on X
        temp=find(UMFXmu(j,:)>=UMFYmu(i));
        indexa=min(temp);  %% locate the interval where UMFYmu(i) lies in
        a(j)=UMFXx(j,indexa-1)+(UMFXx(j,indexa)-UMFXx(j,indexa-1))...
            *(UMFYmu(i)-UMFXmu(j,indexa-1))/(UMFXmu(j,indexa)-UMFXmu(j,indexa-1));
        indexb=max(temp);
        b(j)=UMFXx(j,indexb)+(UMFXx(j,indexb+1)-UMFXx(j,indexb))...
            *(UMFYmu(i)-UMFXmu(j,indexb))/(UMFXmu(j,indexb+1)-UMFXmu(j,indexb));
        %% c,d: alpha-cut on W
        temp=find(UMFWmu(j,:)>=UMFYmu(i));
        indexc=min(temp);
        c(j)=UMFWw(j,indexc-1)+(UMFWw(j,indexc)-UMFWw(j,indexc-1))...
            *(UMFYmu(i)-UMFWmu(j,indexc-1))/(UMFWmu(j,indexc)-UMFWmu(j,indexc-1));
        indexd=max(temp);
        d(j)=UMFWw(j,indexd)+(UMFWw(j,indexd+1)-UMFWw(j,indexd))...
            *(UMFYmu(i)-UMFWmu(j,indexd))/(UMFWmu(j,indexd+1)-UMFWmu(j,indexd));
    end
    UMFYy(i)=EKM(a,c,d,-1);
    UMFYy(2*n+1-i)=EKM(b,c,d,1); %% EKM algorithm to compute the alpha-cut on the UMF of the LWA
end

%%%%%%%%%%%%%%%%%%%%%%% LMF %%%%%%%%%%%%%%%%%%%%%%%
hmin=min(min(max(LMFXmu,[],2)),min(max(LMFWmu,[],2)));  %% height of the LMF of the LWA
LMFYmu=[0:hmin/(n-1):hmin hmin:-hmin/(n-1):0]; %% u-coordinates of the LMF of the LWA

%% alpha==0
for j=1:N  %% for each input, compute the alpha-cut
    %% a,b: alpha-cut on X
    temp=find(LMFXmu(j,:)>0);
    indexa=min(temp)-1;  %% locate the interval where UMFYmu(i) lies in
    a(j)=LMFXx(j,indexa);
    indexb=max(temp)+1;
    b(j)=LMFXx(j,indexb);
    %% c,d: alpha-cut on W
    temp=find(LMFWmu(j,:)>0);
    indexc=min(temp)-1;
    c(j)=LMFWw(j,indexc);
    indexd=max(temp)+1;
    d(j)=LMFWw(j,indexd);
end
LMFYy(1)=EKM(a,c,d,-1);
LMFYy(2*n)=EKM(b,c,d,1);

%% alpha>0
for i=2:n
    %% a,b: alpha-cut on X
    for j=1:N  %% for each input, compute the alpha-cut
        %% a,b: alpha-cut on X
        temp=find(LMFXmu(j,:)>=LMFYmu(i));
        indexa=min(temp);  %% locate the interval where UMFYmu(i) lies in
        a(j)=LMFXx(j,indexa-1)+(LMFXx(j,indexa)-LMFXx(j,indexa-1))...
            *(LMFYmu(i)-LMFXmu(j,indexa-1))/(LMFXmu(j,indexa)-LMFXmu(j,indexa-1));
        indexb=max(temp);
        b(j)=LMFXx(j,indexb)+(LMFXx(j,indexb+1)-LMFXx(j,indexb))...
            *(LMFYmu(i)-LMFXmu(j,indexb))/(LMFXmu(j,indexb+1)-LMFXmu(j,indexb));
        %% c,d: alpha-cut on W
        temp=find(LMFWmu(j,:)>=LMFYmu(i));
        indexc=min(temp);
        c(j)=LMFWw(j,indexc-1)+(LMFWw(j,indexc)-LMFWw(j,indexc-1))...
            *(LMFYmu(i)-LMFWmu(j,indexc-1))/(LMFWmu(j,indexc)-LMFWmu(j,indexc-1));
        indexd=max(temp);
        d(j)=LMFWw(j,indexd)+(LMFWw(j,indexd+1)-LMFWw(j,indexd))...
            *(LMFYmu(i)-LMFWmu(j,indexd))/(LMFWmu(j,indexd+1)-LMFWmu(j,indexd));
    end
    LMFYy(i)=EKM(a,c,d,-1);
    LMFYy(2*n+1-i)=EKM(b,c,d,1);
end


