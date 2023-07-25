close all
clear all
%%

I1 = imread('Image9.jpeg');
% figure()
% imshow(I1)

face1 = detectFace(I1);
% figure
% imshow(face1)
I2 = imread('Image8.jpeg');
% figure()
% imshow(I2)

face2 = detectFace(I2);
% figure
% imshow(face2)
%%
figure
subplot(2,2,1)
imshow(I1)
title('Image Captured in Light Setting 1')
subplot(2,2,2)
imshow(I2)
title('Image Captured in Light Setting 2')
subplot(2,2,3)
imshow(face1)
title('Face 1')
subplot(2,2,4)
imshow(face2)
title('Face 2')
%%
figure
subplot(2,2,1)
imshow(face1)
title('Face 1')
subplot(2,2,3)
imshow(face2)
title('Face 2')
subplot(2,2,4)
imshow(face_trans)
title('Face 2 after Geometric Transform')

%%
P1 = detectSURFFeatures(im2double(rgb2gray(face1)));
figure
imshow(face1)
hold on
plot(P1)
hold off

%%
I2 = imread('Image10.jpeg');
% figure()
% imshow(I2)

face2 = detectFace(I2);
% figure
% imshow(face2)

P2 = detectSURFFeatures(im2double(rgb2gray(face2)));
figure
imshow(face2)
hold on
plot(P2)
hold off

%%
[D1,P1] = extractFeatures(im2double(rgb2gray(face1)),P1,'Method','SURF');
[D2,P2] = extractFeatures(im2double(rgb2gray(face2)),P2,'Method','SURF');

[M,matchmetric]= matchFeatures(D1,D2,'MaxRatio',0.25,'Unique',true,'Metric','SSD');%,'MatchThreshold',100,'MaxRatio',1);
figure
showMatchedFeatures(face1,face2,P1(M(:,1),:),P2(M(:,2),:),'Method','blend');

thresh = 0.5; 
if mean(matchmetric)>thresh
    disp('Face moved. Try again')
end

itr=0;
while ((length(inlierpoints1)/length(M))<0.5 | itr <10)
    [tform,inlierpoints1,inlierpoints2] = estimateGeometricTransform(P1(M(:,1),:),P2(M(:,2),:),'affine');
    itr = itr+1;
end 
outputView = imref2d(size(face1));
Ir = imwarp(face2,tform,'OutputView',outputView);
figure 
imshow(Ir);

