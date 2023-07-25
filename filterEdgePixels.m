function [I_e] = filterEdgePixels(I)

I_e = zeros(size(I));
limit = prctile(sum(I,2),80);

I(:,1:100)=0;
I(:,540:end)=0;


for i = 50:(size(I,1)-50)
    if sum(I(i,:))<limit
        I_e(i,:)=I(i,:);
    end
end



end

