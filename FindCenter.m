function [cen,I_v] = FindCenter(EyeMapI,EyeMapL,eye)
[ filtered_emap ] = frst2d( EyeMapI, [round(size(EyeMapI,2)/40):0.5:(4*round(size(EyeMapI,2)/20))], 1, 0.5, 'bright' );

% EyeMapL1 = EyeMapL;
IrisRad1 = round(size(EyeMapL,2)/40);
B1 = strel('disk', IrisRad1);

EyeMapL = imerode(EyeMapL,B1);

[ filtered_l ] = frst2d( EyeMapL, [round(size(EyeMapL,2)/40):0.5:(4*round(size(EyeMapL,2)/20))], 1, 0.5, 'dark' );
filtered = filtered_emap + filtered_l;
[~,ind] = max(filtered,[],'all','linear');
[r,c] = ind2sub(size(filtered),ind);
cen = [r,c];
I_v = insertMarker(eye,[c,r]);

% imshow(I_v)
% figure
% imshow(filtered_l,[])

% figure
% subplot(1,2,1)
% imshow(EyeMapI,[])
% title('EyeMapI')
% subplot(1,2,2)
% imshow(filtered_emap,[])
% title('FRST of EyeMapI')

% figure
% subplot(2,2,1)
% imshow(EyeMapL1,[])
% title('Y component of eye image')
% subplot(2,2,2)
% imshow(EyeMapL,[])
% title('Y after morphological erode')
% subplot(2,2,3)
% imshow(filtered_l,[])
% title('FRST of Y after morphological erode')
end

