function ResultF = force (y,rake,Ktc,Kte,Krc,Kre,Kfc,Kfe) 
%inputs.
numberofpasses = 112;
%x= [0,0,0,0;20,0,0,0;20,20,0,0; 50,50,50,20;80,80,50,80;90,100,0,0;90,120,0,0]; 
%dr=(D/2)/numberofpasses;
rake=0.5; %normal rake angle
Ktc=2000;
Kte=10;
Krc=1200;
Kre=8;
Kfc=800;
Kfe=3;
%y=[40;40;0.2;4;dr;0.9];


teta_end=asin((y(3)/2)/rake)+pi/2;
increment=0.01;
teta=0:increment:teta_end;
gama=teta-asin((y(3)/rake)*sin(pi-teta));
h=rake-sqrt(y(3)^2+rake^2-2*y(3)*rake*cos(gama));


K1=[Ktc;Krc;Kfc];
K2=[Kte;Kre;Kfe];

%Region I
if y(5)>rake
F=K1*(y(5)-rake)*y(3)+K2*(y(5)-rake);
else
    F=0;
end

%Region II
dF=K1*rake*increment*h+K2*rake*increment;

for i=1:teta 
    T=[1 0 0;0 cos(teta(i)) -sin(teta(i));0 sin(teta(i)) cos(teta(i))];
DF(:,i)=T*dF(:,i);
end

DFtot(1,1)=0;
DFtot(2,1)=0;
DFtot(3,1)=0;

for i=1:teta
DFtot(1,1)=DFtot(1,1)+DF(1,i);
DFtot(2,1)=DFtot(2,1)+DF(2,i);
DFtot(3,1)=DFtot(3,1)+DF(3,i);
end

Ftot = F+DFtot;
ResultF = sqrt((F(1)+DFtot(1))^2+(F(2)+DFtot(2))^2+(F(3)+DFtot(3))^2);
end

