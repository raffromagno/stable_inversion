% Sinc basis functions
%
% author: Raffaele Romagnoli
% date 3/5/2017

function [S]=Sit(n_cp,t1,Tt)

Tt_1=Tt-5;                    %Avoid truncation issues

step_in=Tt_1/(n_cp);
Ns=size(t1,2);


S=zeros(Ns,n_cp);

l=0;
for i=1:n_cp
    shift=l*ones(1,Ns);
    S(:,i)=sinc(t1-shift);
    l=l+step_in;

end
   