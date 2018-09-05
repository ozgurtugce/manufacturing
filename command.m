%optimization 
%inputs

numberofpasses=112;
x= [0,0,0,0;20,0,0,0;20,20,0,0; 50,50,50,20;80,80,50,80;90,100,0,0;90,120,0,0];
D=150;
%dr=(D/2)/numberofpasses;
Tt=5;
p=1.06;
q=1.4;
r=1.05;
C =600;
%[vr,vs,fr,fs,dr,ds]
y0=[40,50,0.2,0.09,0.66,0.5];
ub=[100,100,0.5,0.15,1,0.6];
lb=[30,50,0.1,0.05,0.6,0.4];
Aeq=[0 0 0 0 numberofpasses 1];
beq=(D/2);
A=[0 0 -1 1 0 0;0 0 0 0 -1 1;1 -1 0 0 0 0];
b=[0;0;0];

 %options=optimoptions(@fmincon, 'Algorithm','sqp');
%options = optimoptions(@fmincon,'SpecifyConstraintGradient',true);
% = optimoptions(@fmincon,'Algorithm','interior-point','Display','off');
%options = optimoptions(@fmincon,'Display','iter','Algorithm','sqp');
[y,fval,exitflag]=fmincon(@multipass,y0,A,b,Aeq,beq,lb,ub,@forceconstraint);

%additional time 
Th=1;
tetha=0.4;
Ts=C/(y(2)^p*y(4)^q*y(6)^r);
Tr=C/(y(1)^p*y(3)^q*y(5)^r);
Ttot=tetha*Tr+(1-tetha)*Ts;
TcTime=Tt/(Ttot/(fval))+Th;

%displaying results
%xlswrite('outputs.xlsx',y,fval)

%Vr=y(1), Vs=y(2), fr=y(3), fs=y(4), dr=y(5), ds=y(6)
disp(['optimum cutting time is'   num2str(TcTime+fval)])
disp(['optimum cutting speed is'   num2str(y(1))])
disp(['optimum feed is '   num2str(y(3))])
disp(['optimum finishing dept of cut is'   num2str(y(6))])
y


