function [I_v,eye1,eye2,EyeMapL1,EyeMapL2,EyeMap1,EyeMap2] = detectEye(I)

I_g = I(1:ceil(size(I,1)/2),:,:);
I_g = I_g(ceil(size(I_g,1)/4):end,ceil(size(I_g,2)/12):end-ceil(size(I_g,2)/12),:);

LCbCr = rgb2ycbcr(I_g);
L = im2double(LCbCr(:,:,1));
Cb = im2double(LCbCr(:,:,2));
Cr = im2double(LCbCr(:,:,3));
Cr_b = ones(size(Cr)) - Cr;

EyeMap = ((Cb.^2)+(Cr_b.^2)+(Cb./Cr))./3;

% figure
% subplot(2,1,1)
% imshow(I_g)
% title('Cropped ROI for eye search')
% subplot(2,1,2)
% imshow(EyeMap,[])
% title('EyeMapC calculated from Cb and Cr values')


wsize = [ceil(size(I_g,1)/4),ceil(size(I_g,2)/6)];

row = [1:floor(wsize(1)/5):(size(I_g,1)-wsize(1))];
col = [1:floor(wsize(2)/5):(size(I_g,2)-wsize(2))];

d = zeros([length(row),length(col)]);

for i = 1:size(d,1)
    for j = 1:size(d,2)
      d(i,j) = sum(EyeMap(row(i):(row(i)+wsize(1)-1),col(j):(col(j)+wsize(2)-1)),'all');
    end 
end
d = d./(max(d,[],'all'));

S = zeros([(length(row)-5),(length(col)-5)]);
for i = 2:(length(row)-10)
    for j = 2:(length(col)-5)
        S(i,j) = d(i,j)+d((i+5),j)+d(i,(j+5))+d((i+5),(j+5))+d((i+10),j)+d((i+10),(j+5));
    end
end
[~,ind] = max(S,[],'all','linear');
[r,c] = ind2sub(size(S),ind);
I_v = I_g;
I_v = insertShape(I_v,'Rectangle',[col(c) row(r) 2*wsize(2) 3*wsize(1)],'Color','green');
 
if (row(r)+(3*wsize(1))) > size(I_g,1)
    r_limit = (row(r+10)+wsize(1));
else
    r_limit = (row(r)+(3*wsize(1)));
end

if (col(c)+(2*wsize(2))) > size(I_g,2)
    c_limit = (col(c+5)+wsize(2));
else
    c_limit = (col(c)+(2*wsize(2)));
end

eye1 = I_g(row(r):r_limit,col(c):c_limit,:);
EyeMapL1 = L(row(r):r_limit,col(c):c_limit,:);
EyeMap1 = EyeMap(row(r):r_limit,col(c):c_limit,:);

% I_v = insertShape(I_v,'Rectangle',[col(c) row(r) (col(c+5)-col(c)+wsize(2)) (row(r+10)-row(r)+wsize(1))]);
% figure
% imshow(I_v)

if c >= (length(col)/2)
   S(:,floor(length(col)/2):end)=0;
   [~,ind] = max(S,[],'all','linear');
   [r,c] = ind2sub(size(S),ind);
   I_v = insertShape(I_v,'Rectangle',[col(c) row(r) 2*wsize(2) 3*wsize(1)],'Color','green'); 
else
    S(:,1:floor(length(col)/2))=0; 
    [~,ind] = max(S,[],'all','linear');
    [r,c] = ind2sub(size(S),ind);
    I_v = insertShape(I_v,'Rectangle',[col(c) row(r) 2*wsize(2) 3*wsize(1)],'Color','green');
end

if (row(r)+(3*wsize(1))) > size(I_g,1)
    r_limit = (row(r+10)+wsize(1));
else
    r_limit = (row(r)+(3*wsize(1)));
end

if (col(c)+(2*wsize(2))) > size(I_g,2)
    c_limit = (col(c+5)+wsize(2));
else
    c_limit = (col(c)+(2*wsize(2)));
end
    
eye2 = I_g(row(r):r_limit,col(c):c_limit,:);
EyeMapL2 = L(row(r):r_limit,col(c):c_limit,:);
EyeMap2 = EyeMap(row(r):r_limit,col(c):c_limit,:);


% eye2 = I_g(row(r):(row(r)+(3*wsize(1))),col(c):(col(c)+(2*wsize(2))),:);
% EyeMapL2 = L(row(r):(row(r)+(3*wsize(1))),col(c):(col(c)+(2*wsize(2))),:);
% EyeMap2 = EyeMap(row(r):(row(r)+(3*wsize(1))),col(c):(col(c)+(2*wsize(2))),:);
end

