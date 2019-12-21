function [ Psi ] = PsiVector( Cb,zd,n_cp,q,Ns,Ts)
%PSIMATRIX computation of the Psi vector used for computing of the
%least square (LS) solution of the general approximated model stable inversion
%method.
% Output:
%        Psi: vector used for computing the LS solution
% Inputs:
%        Cb : coefficient matrix computed by coeffMatrix.m
%        zd : measurement vector computed by measVector.m
%       n_cb: number of basis functions
%          q: number of outputs
%         Ns: number of samples
%         Ts: sampling time
% Author: Raffaele Romagnoli
% Date  : 01/03/2018
%% 
new_q=q;Q=eye(q);
Psi=zeros(q*(n_cp),1);
for i=2:Ns
    l=(i-1)*new_q+1; 
    l1=(i-2)*new_q+1;
    %----------------------------------------------------------------------   
    c=Cb(l1:l1+new_q-1,:)'*Q*zd(l1:l1+new_q-1);
    d=Cb(l:l+new_q-1,:)'*Q*zd(l:l+new_q-1);
    %----------------------------------------------------------------------                                 
    Psi=Psi+(c+d)*Ts/2;   %Trapezoidal Rule
    %---------------------------------------------------------------------- 
end       

end

