
function [phi]=phiMat(r,n_cp,Bit)
% PHIMAT generates the phi matrix that contains the basis functions related
% to a particular time instant taking into account the numer of inputs

% author: Raffaele Romagnoli
% date: 14/04/2017

phi=zeros(r,r*n_cp);
l=0;
for i=1:r
    phi(i,l+1:i*n_cp)=Bit;
    l=l+n_cp;
end
