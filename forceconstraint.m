
function [c,ceq]=forceconstraint(y)


%  x= [0,0,0,0;20,0,0,0;20,20,0,0; 50,50,50,20;80,80,50,80;90,100,0,0;90,120,0,0];

%y(1)=35; 
%  y=[40,40,0.2,0.01,0.69,1.4];
%options = optimoptions(@fmincon,'SpecifyConstraintGradient',true);
%calling min time function
%[vr,vs,fr,fs,dr,ds]
%  numberofpasses=112;
%  dr=(x(size(x,1),1)-x(1,1))/numberofpasses;
%  y0=[40,50,0.2,4,dr,0.9];
%  ub=[70;70;0.5;0.95;10;5];
%  lb=[30;50;0.2;0.05;6;3];
% Aeq=[0 0 0 0 numberofpasses 1];
% beq=(x(size(x,1),1)-x(1,1));
% A=[0 0 -1 1 0 0;0 0 0 0 -1 1;1 -1 0 0 0 0];
% b=[0;0;0];
% 
 Tt=5;
 p=1.4;%above v
 q=1.06;%above d
 r=1.05;%above f
 C =600;
% % D=300;
% [y,fval,exitflag]=multipass(y0)
% [y,fval,exitflag]=fmincon(@multipass,y0,A,b,Aeq,beq,lb,ub);
% ceq(1)=y(3)-(C/(Tt*y(1)^p*y(5)^q*(r-1)))^(1/r) %feed and speed and debt of cut equality
% ceq(2)=((x(size(x,1),1)-x(1,1))-y(6))/numberofpasses %debt of cut equality
% ceq(3)=y(1)-(C/(Tt*y(3)^r*y(5)^q*(p-1)))^(1/p)
%  
% %force constraint
% c(2)=y(3)-y(4) %fr bigger than fs
% c(3)=y(5)-y(6)%dr bigger than ds
%c(4)=y(2)-y(1) %vs bigger than vr
%c(5)=D/2-(x(size(x,1),1)-x(1,1))%HALF DÝAMETER bigger and equal to diff bw last and first cutting x location. 
rake=0.5;
ResultF=force(y,rake,2000,10,1200,8,800,3);
%c(1)=500-ResultF
c=ResultF-500

ceq=[y(3)-(C/(Tt*y(1)^p*y(5)^q*(r-1)))^(1/r) ;y(1)-(C/(Tt*y(3)^r*y(5)^q*(p-1)))^(1/p);y(4)-(C/(Tt*y(2)^p*y(6)^q*(r-1)))^(1/r);y(2)-(C/(Tt*y(4)^r*y(6)^q*(p-1)))^(1/p)]

%forceconstraint = @(y)deal(c(y),ceq(y));
%  if nargout > 2
%      gradc = [];
%     gradceq = [p*(1/r)*y(1)^(p*((-1-r)/r)-1),1;1,r*(1/p)*y(3)^((-1-p)/p)*r;q*(1/r)*y(5)^(q*((-1-r)/r)-1),q*(1/p)*y(5)^(q*((-1-p)/p)-1)];
% end
% end
%we called force function to have forces and we added constraints that
%force should not be bigger than 500. 
end
