
function Ttotal = multipass(y)
%inputs
x= [0,0,0,0;20,0,0,0;20,20,0,0; 50,50,50,20;80,80,50,80;90,100,0,0;90,120,0,0]; 
D=150 ; 
numberofpasses = 112;
L=x(size(x,1),2)-x(1,2); 

%finding time for roughing passes
Tm2W=0;
for j =1:numberofpasses 
    if D> abs(x(size(x,1),1)-x(1,1))
        
     Tm2W= Tm2W + ((pi*(D-2*y(5)*j)*(L))/(y(1)*y(3)));
    else
        break
        
     end
        D=D-2*y(5)*j;
end
  
    
   Tm2=0;
for z =j:numberofpasses
    
Tm2= Tm2 + (pi*(D-2*y(5)*z)*(L-z*((x(size(x,1),2)-x(1,2))/numberofpasses)))/(y(1)*y(3)); 
end
Roughtime=Tm2+Tm2W;

%finding time for finishing
Tmfinishingtot =0;
for i=1:(size(x,1)-1)
    
     if x(i,1)-x(i+1,1)~=0 && x(i,2)-x(i+1,2)==0 &&x(i,3)==0 && x(i,4)==0
        hold on
%         disp('face turning');
        line([x(i,1),x(i,2)],[x(i+1,1),x(i+1,2)],'Color','red','LineStyle','--') %for plotting
        Tm1 = (pi*(x(i+1,1)^2-x(i,1)^2)/(1000*y(2)*y(4)*sin(pi/2)));
        
        %------------------------------------
    elseif x(i,1)-x(i+1,1) ==0 &&  x(i,2)-x(i+1,2)~=0 && x(i,3)==0 && x(i,4)==0
        hold on
%         disp('straight turning');
        line([x(i,2),x(i+1,2)],[x(i,1),x(i+1,1)],'Color','red') %for plotting
        Tm1 =(pi*abs(x(i,1)*(x(i,2)-x(i,1))))/(500*y(2)*y(4));
       
        %--------------------------------
     elseif abs(x(i,1)-x(i+1,1))>= 0 &&  x(i,2)-x(i+1,2)~=0 && abs(x(i+1,3))>=0 && x(i+1,4)~=0 &&   x(i+1,3)==x(i,1)
         hold on
%         disp('circular konkave turning');
        quarterCircle(x(i+1,3),x(i+1,4),x(i,1),x(i,2),x(i+1,1),x(i+1,2)) %for plotting
        Tm1 =((pi*abs(x(i,2)-x(i+1,4)))/(500*y(2)*y(4)))*abs(x(i+1,3)*(pi/2-0)-(x(i,2)-x(i+1,4))*(cos(pi/2)-cos(0)));
        
        %----------------------------------
     elseif abs(x(i,1)-x(i+1,1))>= 0 &&  x(i,2)-x(i+1,2)~=0 && abs(x(i+1,3))>=0 && x(i+1,4)~=0 && x(i+1,4)==x(i,2)
         hold on
%         disp('circular konveks turning');
        quarterCircle(x(i+1,3),x(i+1,4),x(i,1),x(i,2),x(i+1,1),x(i+1,2)) %for plotting
        Tm1 =((pi*abs(x(i,1)-x(i+1,3)))/(500*y(2)*y(4)))*abs(x(i+1,3)*(pi/2-0)-(x(i,1)-x(i+1,3))*(sin(pi/2)-sin(0)));
        
        %-------------------------------------
     elseif x(i,1)-x(i+1,1)~=0 && x(i,2)- x(i+1,2)~=0 &&x(i+1,3)==0 && x(i+1,4)==0
         hold on
%         disp('tapered turning');
        line([x(i,2),x(i+1,2)],[x(i,1),x(i+1,1)],'Color','yellow') %for plotting
        Tm1 = (pi/(1000*y(2)*y(4)))*((x(i+1,1)^2-x(i,1)^2))/sin(atan(abs(x(i+1,1)-x(i,1))/(abs(x(i+1,2)-x(i,2)))));
        
        Tmfinishingtot =Tmfinishingtot +Tm1;
    end
    

    Ttotal = (Tmfinishingtot + Roughtime);
     end
end

