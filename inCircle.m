function result=inCircle(x, y, cX, cY, cR)
%ISCIRCLE    This program checks whether a point (x,y) lies inside,outside
%            or on a circle defined by a center and radius
%            https://www.mathworks.com/matlabcentral/answers/167735-how-to-determine-the-position-of-points-which-belong-to-a-circle
% 
%   Syntax: inCircle(x,y, cX, cY, cR), where the point is at (x, y)
%           and the circle is of radius cR and has a center at (cX, cY).
%           Program checks whether point (x,y) lies inside,outside or on the circle.
%           ans=0  ==> lie on the circle.
%           ans=-1  ==> lie outside the circle.
%           ans=1 ==> lie inside the circle.

dist = (x - cX)^2 + (y - cY)^2;
if dist < cR^2
    result = 1;
elseif dist > cR^2
    result = -1;
else
    result = 0;
end

