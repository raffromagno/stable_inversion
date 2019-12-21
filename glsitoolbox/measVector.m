function [ e_s ] = measVector(sys,Ns,z_d)
%MEASVECTOR generates the measurement vector in the suitable form to be
%used for the pseudoinversion computation
%Output:
%        e_s: measurement vector
%Input :
%        z_d: (desired output) - (unforced response) - (forced ss response) 
%
%Author: Raffaele Romagnoli
%Date: 01/03/2018

Ccl=sys.c;
q=size(Ccl,1);

%% Computation of the measurement vector e_s
   
e_s=zeros(q*Ns,1);
l=1;
for j=2:Ns
    e_s(l:l+q-1,:)=z_d(:,j); 
    l=l+q;    
end

end

