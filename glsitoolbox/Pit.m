
function [S]=Pit(n_int,t1,Tt,d)
% PIT generates the matrix S that contains the values of polynomial
% basis functions.
% where each column containts phi_i(t) for t=0 to Tt.  
% INPUT:
%           d:     polynomial's degree
%       n_int:     number of intervals 
%          t1:     time vector
%          Tt:     transient time
% OUTPUT:
%           S:     basis function matrix, each columns contains the i-th basis
%           function related to the i-th coefficient over the time interval
%           t1
% author: Raffaele Romagnoli
% date 3/5/2017


Ns=size(t1,2);                      
S=zeros(Ns,n_int*(d+1));
Twin=Tt/(n_int);                 


intervals=zeros(1,n_int+1);

for i=2:n_int+1
       intervals(1,i)=(i-1)*Twin;
end
% For every columns it starts from zeros and go till time t and then all
% zeros

l=1;
curr_int=1;
for i=1:Ns    
    if t1(i)>intervals(curr_int+1)
       l=l+d+1;
       curr_int=curr_int+1;
    end
    S(i,l:l+d)=[1 t1(i) t1(i)^2 t1(i)^3];
end
   