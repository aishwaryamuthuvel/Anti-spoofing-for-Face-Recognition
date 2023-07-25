function [dist_mean] = GeoTransform(face1,face2)

P1 = detectSURFFeatures(im2double(rgb2gray(face1)));

P2 = detectSURFFeatures(im2double(rgb2gray(face2)));

[D1,P1] = extractFeatures(im2double(rgb2gray(face1)),P1,'Method','SURF');
[D2,P2] = extractFeatures(im2double(rgb2gray(face2)),P2,'Method','SURF');

M= matchFeatures(D1,D2,'MaxRatio',0.2,'Unique',true);

% itr=0;
% inlierpoints1 = M(1,:);
% per = 0;
% while ((length(inlierpoints1)/length(M))<0.5)
%     [tform,inlierpoints1,inlierpoints2] = estimateGeometricTransform(P1(M(:,1),:),P2(M(:,2),:),'projective');
%     itr = itr+1;
%     if per < (length(inlierpoints1)/length(M))
%         tform_best = tform;
%     end
%     per = length(inlierpoints1)/length(M);
%     if itr == 21
%         break;
%     end
% end 
% 
% outputView = imref2d(size(face1));
% face_trans = imwarp(face2,tform_best,'OutputView',outputView);

figure
subplot(1,2,1)
imshow(face1)
hold on
plot(P1,'ShowOrientation',false,'ShowScale',false)
title('Surf points detected in Image1')
hold off
subplot(1,2,2)
imshow(face2)
hold on
plot(P2,'ShowOrientation',false,'ShowScale',false)
title('Surf points detected in Image2')
hold off

figure
% subplot(2,1,1)
showMatchedFeatures(face1,face2,P1(M(:,1),:),P2(M(:,2),:),'Method','montage');
title('Matched Keypoints')
% figure
% % subplot(2,1,2)
% showMatchedFeatures(face1,face2,inlierpoints1,inlierpoints2,'Method','montage');
% title('Inlier Points mapped in the Geometric Transform')

pt1 = P1(M(:,1),:).Location;
pt2 = P2(M(:,2),:).Location;
dist_mean = mean(sqrt(sum(((pt1-pt2).^2),2)));
thresh = 30; 
if dist_mean>thresh
    disp('Face moved.')
end

end

