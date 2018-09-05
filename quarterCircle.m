function quarterCircle(y1,x1,yStart,xStart,yEnd,xEnd)
%x1,y1 are coordinates of circle's center
%function uses start and end points to determine if it is going to draw an
%upper arc or lower arc (bottom or top of quarter circle)
if (y1 >= max(yStart,yEnd) && x1 >= max(xStart,xEnd))
    theta = pi:0.05:(3*pi/2); %left bottom circle
elseif (y1 <= min(yStart,yEnd) && x1 >= max(xStart,xEnd))
    theta = pi/2:0.05:pi;
elseif (y1 <= min(yStart,yEnd) && x1 <= min(xStart,xEnd))
    theta = 0:0.05:pi/2;
elseif (y1 >= max(yStart,yEnd) && x1 <= min(xStart,xEnd))
    theta = (3*pi/2):0.05:2*pi;
end
radius = norm([x1,y1]-[xStart,yStart]);
assert(radius > 0, 'Radius must be bigger than 0')
xunit = radius * cos(theta) + x1;
yunit = radius * sin(theta) + y1;
plot(xunit,yunit,'b')