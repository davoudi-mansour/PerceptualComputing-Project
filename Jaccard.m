function S=Jaccard(A,B)

% to compute the Jaccard similarity measure [1] between two IT2 FSs. It is
% used in example4.m.
%
% [1] Dongrui Wu and Jerry M. Mendel, "A comparative study of ranking
% methods, similarity measures and uncertainty measures for interval 
% type-2 fuzzy sets," submitted to Information Sciences, 2008.
%
% Dongrui WU (dongruiw@usc.edu), 5/12/2008
%
% A, B: IT2 FSs each defined by nine parameters (see Fig. 1 in Readme.doc)
%

N=200;
left=0;
right=10;
dx=(right-left)/N;

for j=1:N+1
    x=left+(j-1)*dx;
    if x<=A(1)| x>=A(4);
        upperA(j)=0;
    elseif  x<A(2)
        upperA(j)=(x-A(1))/(A(2)-A(1));
    elseif x<=A(3)
        upperA(j)=1;
    else 
        upperA(j)=(A(4)-x)/(A(4)-A(3));
    end
    
    if x<=A(5) | x>=A(8)
        lowerA(j)=0;
    elseif x<A(6)
        lowerA(j)=A(9)*(x-A(5))/(A(6)-A(5));
    elseif x<A(7)
        lowerA(j)=A(9);
    else
        lowerA(j)=A(9)*(A(8)-x)/(A(8)-A(7));
    end

    if x<=B(1)| x>=B(4)
        upperB(j)=0;
    elseif  x<B(2)
        upperB(j)=(x-B(1))/(B(2)-B(1));
    elseif  x<=B(3)
        upperB(j)=1;
    else 
        upperB(j)=(B(4)-x)/(B(4)-B(3));
    end
    
    if x<=B(5) | x>=B(8)
        lowerB(j)=0;
    elseif x<B(6)
        lowerB(j)=B(9)*(x-B(5))/(B(6)-B(5));
    elseif x<=B(7)
        lowerB(j)=B(9);
    else
        lowerB(j)=B(9)*(B(8)-x)/(B(8)-B(7));
    end   
end 

S=sum([min([upperA;upperB]), min([lowerA;lowerB])])/sum([max([upperA;upperB]), max([lowerA;lowerB])]);



