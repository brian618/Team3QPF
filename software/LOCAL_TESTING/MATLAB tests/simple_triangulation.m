% coords1.m
extents = [
-123.250812, 49.262161;		% (0,0)
-123.248334, 49.263114;		% (800,0)
-123.247403, 49.261765;		% (800,480)
-123.249801, 49.260998];	% (0,480)

screen = [
0,	 -  0;
800, -  0;
800, -  480;
0,	 -  480];

close all;

figure(1); % GPS Coordinates
hold on;
TRI = delaunayTriangulation(extents);
triplot(TRI);

% compute centroids and plot as black points
ct = tri_centroid(extents,TRI);
plot(ct2(:,2),ct2(:,1),'k*')

TRI2 = delaunay(extents(:,1),extents(:,2))

test_ = [-123.249718, 49.261797];
plot(-123.249718, 49.261797,'g*')

[cdist,nn] = nearestneighbour(test_,ct);
% distinguish nearest centroid
plot(ct(nn,1),ct(nn,2),'b*')

% compute barycentric components
B = cartesianToBarycentric(TRI,nn,test_)

% test output from C code
BTEST = [-0.387590 0.440460 0.947130];

TN = TRI.ConnectivityList(nn,:);
% Find interpolated point
bary_point = [dot(B,screen(TN,1)) dot(B,screen(TN,2))]

% TEST RANDOM POINT
test_eps = test_ + 1e-4*randn(1,2)
plot(test_eps(:,1),test_eps(:,2),'c*')


figure(2); % Screen Space
hold on;
plot(screen(:,1),screen(:,2),'r');
plot(bary_point(1),bary_point(2),'g*')
% bary_point = [dot(BTEST,screen(TN,1)) dot(BTEST,screen(TN,2))]
% plot(bary_point(1),bary_point(2),'c*')

% Interpolate random point
B = cartesianToBarycentric(TRI,nn,test_eps)
[cdist,nn] = nearestneighbour(test_eps,ct);
bary_point_eps = [dot(B,screen(TN,1)) dot(B,screen(TN,2))]

plot(bary_point_eps(:,1),bary_point_eps(:,2),'c*')





