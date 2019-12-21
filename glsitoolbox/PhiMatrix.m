function [ Phi ] = PhiMatrix( Cb,n_cp,q,Ns,Ts)
%PHIMATRIX generates the Phi matrix used for computing the
%Moore-Penrose pseudoinverse 
% Output:
%        Phi: matrix used for computing the pseudoinverse
% Inputs:
%        Cb : coefficient matrix computed by coeffMatrix.m
%       n_cb: number of basis functions
%          q: number of outputs
%         Ns: number of samples
%         Ts: sampling time
%%
new_q=q;Q=eye(q);
Phi=zeros(q*(n_cp)); 

for i=2:Ns
    l=(i-1)*new_q+1; 
    l1=(i-2)*new_q+1;
    %----------------------------------------------------------------------   
    a=Cb(l1:l1+new_q-1,:)'*Q*Cb(l1:l1+new_q-1,:);
    b=Cb(l:l+new_q-1,:)'*Q*Cb(l:l+new_q-1,:);
    %---------------------------------------------------------------------- 
    Phi=Phi+(a+b)*Ts/2;                                %Trapezoidal Rule 
end       

end

