function [EyeMapI] = EyeMap(Y,EMap)

IrisRad1 = round(size(EMap,2)/40);
B1 = strel('disk', IrisRad1);
B2 = strel('disk', round(IrisRad1/2));

L = imerode(Y,B2);
% figure
% imshow(L,[])
delta = mean(L,'all');

L = L + delta;

EyeMapI = imdilate(EMap,B1)./L;
% figure
% imshow(imdilate(EMap,B1),[])
end

