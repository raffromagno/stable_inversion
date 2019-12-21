function [Cb] = coeffMatrix(sys,n_cp,tau,Ns,Ts,Bit)
%COEFFMATRIX computes the least squares coefficient matrix that contains 
% for all t the values of the convolution integral: 
%                int_[0,t]{C*e^(t-tau)B*phi(tau)} 
%computed over a  finite approximation [0,T_t] of the infinite time 
%interval [0,+inf].
% Output: 
%        Cb: coefficients matrix
% Inputs:
%       sys: considered system
%      n_cp: number of basis functions
%       tau: time vector
%        Ns: number of samples
%        Ts: sampling time
%       Bit: basis function matrix
% Author: Raffaele Romagnoli
% Date: 01/03/2018

Acl=sys.a;Bcl=sys.b;Ccl=sys.c;               % system's matrices
n=size(Acl,1);r=size(Bcl,2);q=size(Ccl,1);   % # states, #inputs, # outputs


%% Computation of the linear integral operator over [0,T_t]

Cb=zeros(q*Ns,r*n_cp);   
count=0;
l=1;
% Convolution integral
for j=2:Ns
    tp=tau(j);                                   
    integ=zeros(q,r*n_cp);
    for i=2:j 
        CAB=Ccl*expm(Acl*(tp-tau(i)))*Bcl;
        CAB_1=Ccl*expm(Acl*(tp-tau(i-1)))*Bcl;
        Bit_1=phiMat(r,n_cp,Bit(i,:));
        Bit_2=phiMat(r,n_cp,Bit(i-1,:));
        integ=integ+(CAB*Bit_1+CAB_1*Bit_2)*Ts/2; % Trapezoidal rule
    end    
    Cb(l:l+q-1,:)=integ;             % store computed data                                
    l=l+q;                           % index update
    %% Progress status dispaly
    fprintf(1, repmat('\b',1,count)); %delete line before
    count = fprintf('Processing...: %3.2f %%',(j/Ns)*100);    
end

end

