function  [eye_p,area,x,y] = pupilArea1(eye,EyeMap,EyeMapL,cen)

wsize = round(max(size(eye))/10);
PupilMap = EyeMap(cen(1)-wsize:cen(1)+wsize,cen(2)-wsize:cen(2)+wsize);
PupilMapL = EyeMapL(cen(1)-wsize:cen(1)+wsize,cen(2)-wsize:cen(2)+wsize);

% figure
% imshow(EyeMapL,[])
% figure
% imshow(PupilMapL,[])

level = prctile(PupilMap,90,'all');
J_E = (PupilMap>level);
% figure
% imshow(J_E)
level = prctile(PupilMapL,10,'all');
J_L = (PupilMapL<level);
% figure
% imshow(J_L)
J = J_E + J_L;
J = J>0;

% figure 
% imshow(J)
s = regionprops(bwlabel(J),'Area','Centroid');

J_pupil = zeros(size(J));

for i = 1:length(s) 
    blob = ismember(bwlabel(J), i);
    blob = blob > 0;
    if blob(wsize+1,wsize+1)==1
        J_pupil = blob;
        break;
    end
end
% figure 
% imshow(J_pupil)

if sum(J_pupil,'all')==0
    error('Pupil not found')
else
s = regionprops(J_pupil, 'Orientation', 'MajorAxisLength','MinorAxisLength','Centroid');

phi = linspace(0,2*pi,50);
cosphi = cos(phi);
sinphi = sin(phi);

xbar = s.Centroid(1);
ybar = s.Centroid(2);

a = s.MajorAxisLength/2;
b = s.MinorAxisLength/2;

theta = pi*s.Orientation/180;
R = [ cos(theta)   sin(theta)
     -sin(theta)   cos(theta)];

xy = [a*cosphi; b*sinphi];
xy = R*xy;

x = xy(1,:) + xbar;
y = xy(2,:) + ybar;

% figure
% imshow(J_pupil)
% hold on
% plot(x,y,'r','LineWidth',2)
% hold off


% [columnsInImage, rowsInImage] = meshgrid(1:size(J_pupil,2), 1:size(J_pupil,1));
% J_pupil_fit = (rowsInImage - ybar).^2 ./ b^2 + (columnsInImage - xbar).^2 ./ a^2 <= 1;

end
% figure 
% imshow(J_pupil)

% area = sum(J_pupil,'all');
area = round(pi*a*b); 
eye_p = im2double(eye);

eye_p(cen(1)-wsize:cen(1)+wsize,cen(2)-wsize:cen(2)+wsize,1) = J_pupil + (eye_p(cen(1)-wsize:cen(1)+wsize,cen(2)-wsize:cen(2)+wsize,1).*(~J_pupil));
eye_p(cen(1)-wsize:cen(1)+wsize,cen(2)-wsize:cen(2)+wsize,2) = eye_p(cen(1)-wsize:cen(1)+wsize,cen(2)-wsize:cen(2)+wsize,2).*(~J_pupil);
eye_p(cen(1)-wsize:cen(1)+wsize,cen(2)-wsize:cen(2)+wsize,3) = eye_p(cen(1)-wsize:cen(1)+wsize,cen(2)-wsize:cen(2)+wsize,3).*(~J_pupil);

x_adj = (cen(2)-wsize)-1;
y_adj = (cen(1)-wsize)-1;
x = x + x_adj;
y = y + y_adj;
% figure
% imshow(eye)
% hold on
% plot(x,y,'r','LineWidth',2)
% hold off
% 
% figure
% imshow(eye_p)
end

