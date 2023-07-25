% close all
% clear all
%%
I1 = imread('Image9.jpeg');
% I2 = imread('Image10.jpeg');
% figure()
% imshow(I)

face = detectFace(I1);
% face2 = detectFace(I2);
% figure
% imshow(face)

% face = GeoTransform(face1,face2);
%%
[I_v,eye1,eye2,EyeMapL1,EyeMapL2,EyeMap1,EyeMap2] = detectEye(face);
%%
% figure
% imshow(I_v)
% figure
% subplot(1,2,1)
% imshow(eye1)
% title('Left Eye and pupil center')
% subplot(1,2,2)
% imshow(eye2)
% title('Right Eye and pupil center')
%%
% figure
% imshow(eye1)
% figure
% imshow(eye2)
% figure
% imshow(EyeMapL1,[])
% figure
% imshow(EyeMapL2,[])
% figure
% imshow(EyeMap1,[])
% figure
% imshow(EyeMap2,[])
%%
EyeMapI1 = EyeMap(EyeMapL1,EyeMap1);

EyeMapI2 = EyeMap(EyeMapL2,EyeMap2);

% figure
% subplot(1,2,1)
% imshow(EyeMapI1,[])
% title('EyeMapI - Left eye')
% subplot(1,2,2)
% imshow(EyeMapI2,[])
% title('EyeMapI - Right eye')

%%
[cen1,I_v1] = FindCenter(EyeMapI1,EyeMapL1,eye1);
% figure
% imshow(filtered1,[])
% figure
% imshow(I_v1)
%%
[cen2,I_v2] = FindCenter(EyeMapI2,EyeMapL2,eye2);
% figure
% imshow(filtered2,[])
% figure
% subplot(1,2,1)
% imshow(I_v1)
% title('Left Eye and pupil center')
% subplot(1,2,2)
% imshow(I_v2)
% title('Right Eye and pupil center')
%%
[eye_p1,area1,x1,y1] = pupilArea1(eye1,EyeMap1,EyeMapL1,cen1);
% figure
% imshow(eye_p1)
area1
%%
[eye_p2,area2,x2,y2] = pupilArea1(eye2,EyeMap2,EyeMapL2,cen2);
% figure
% imshow(eye_p2)
area2
%%
% figure
% subplot(1,2,1)
% imshow(eye_p1)
% title('Left Eye pupil')
% subplot(1,2,2)
% imshow(eye_p2)
% title('Right Eye pupil')
%%
figure
% subplot(4,2,1)
% imshow(face)
% subplot(4,2,2)
% imshow(I_v)
subplot(2,2,1)
imshow(eye1)
hold on
plot(x1,y1,'b','LineWidth',2)
hold off
title(['Right eye area: ' num2str(area1)])
subplot(2,2,2)
imshow(eye_p1)
hold on
plot(x1,y1,'b','LineWidth',2)
hold off
subplot(2,2,3)
imshow(eye2)
hold on
plot(x2,y2,'b','LineWidth',2)
hold off
title({['Input Image 1'],['Left eye area: ' num2str(area2)]})
subplot(2,2,4)
imshow(eye_p2)
hold on
plot(x2,y2,'b','LineWidth',2)
hold off
% subplot(4,2,7)
% imshow(I1)