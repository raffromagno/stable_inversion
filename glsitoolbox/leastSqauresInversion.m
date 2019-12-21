function [x,sp1] = leastSqauresInversion( Phi,Psi,n_cp,q,Ns,Bit,T)
%LEASTSQUARESINVERSION computes the least square solution of the
%approximated model stable inversion approach.
%Inputs:
%        Phi   :Matrix containing the coefficients values C(t)
%        Psi   :Vector containing the measurements values z(t)
%        n_cp  :number of control points/intervals
%        q     :numbwer of outputs
%        Ns    :total number of samples
%        Bit   :Basis Function vector
%        T     :Coordinate transformation matrix for smoothness constraints
%               in case of 3rd order polynomial basis functions
%Outputs:
%        x    :Estimated basis function coefficients
%        sp1  :Estimated Reference Inputs
%
%Author : Raffaele Romagnoli
%Date   : 01/03/2018
%% Singular Value Decomposition 
if nargin==6
   T=eye(size(Phi,1)); 
end
[U,S,V]=svd(T'*Phi*T);  
y=[];
c=U'*T'*Psi;
for k1=1:size(S,2)
    y=[y;c(k1)/S(k1,k1)];  
end
x1=(V*y);
x=T*x1;
%% Signals computation 
sp1=zeros(q,Ns);  
for i=1:Ns
    for k=1:q
        for j=1:n_cp
            sp1(k,i)=sp1(k,i)+Bit(i,j)*x(j+(k-1)*n_cp);              
        end
    end
end



