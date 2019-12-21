
function [T,S]=null_space_3rd(n_int,Tt)
% NULL_SPACE_3RD computes the null space of continuity constraints matrix S
% of a 3rd order piece-wise polynomial function
% INPUTS:
%     n_int: number of intervals;
%     Tt   : final time instant;
% OUTPUTS:
%     T    : coordinate transformation matrix of the null space of S
%     S    : continutity constraints matrix
% Author: Raffaele Romagnoli
% Date  : 10/02/2018

d=3;                    %polynomial degree

%% Computation of the discontinuity points
Twin=Tt/(n_int);                  
intervals=zeros(1,n_int+1);
for i=2:n_int+1
       intervals(1,i)=(i-1)*Twin;
end

%% Computation of the continutiy constraints matrix
S=zeros(n_int-1*d,n_int*(d+1));
l=1;
m=1;
c=2*(d+1);
for i=2:size(intervals,2)-1    
    
    k=intervals(i);
    vect=[1 k k^2 k^3;...
          0  1 2*k 3*k^2;...
          0  0  2  6*k];  
    vect1=[vect -vect];
    S(l:l+d-1,m:m+c-1)=vect1;
    l=l+d;
    m=m+d+1;
end
%% Computation of the null space of S
T=null(S);