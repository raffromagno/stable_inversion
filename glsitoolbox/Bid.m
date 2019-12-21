%B-spline basis function
%
%   i - index of the interval
%   d - B-spline order
%   t - parameter
%  Ln - vector of the knot points
%  
% author: Raffaele Romagnoli
% date  : 13/04/2017
function  B=Bid(i,d,t,Ln)

if d==0
   if t>=Ln(i) && t<Ln(i+1)
      B=1;
   else
      B=0; 
   end
else
   if  (Ln(d+i)-Ln(i))==0 
       a=0;
   else
       a=((t-Ln(i))/(Ln(d+i)-Ln(i)));
   end
   if (Ln(d+i+1)-Ln(i+1))==0
       b=0;
   else
       b=((Ln(d+i+1)-t)/(Ln(d+i+1)-Ln(i+1)));
   end
   B=a*Bid(i,d-1,t,Ln)+...
          b*Bid(i+1,d-1,t,Ln);    
    
end
    