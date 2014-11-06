function [H] = Get_Histogram_Image_Block(blockMagnitudes, blockAngles, numBins, mode)

if strcmp(mode,'signed')
    binSize = 2*pi / numBins;
end
if strcmp(mode,'unsigned')
    binSize = pi / numBins;
    blockAngles(blockAngles < 0) = blockAngles(blockAngles < 0) + pi;
end


minAngle = 0;


leftBinIndex = round((blockAngles - minAngle) / binSize);
rightBinIndex = leftBinIndex + 1;

% disp(leftBinIndex');
% disp(rightBinIndex');
% save('leftBinIndex.mat','leftBinIndex');
% save('rightBinIndex.mat','rightBinIndex');
% save('blockAngles.mat','blockAngles');

leftBinCenter = ((leftBinIndex - 0.5) * binSize) - minAngle;
% save('leftBinCenter.mat','leftBinCenter');

rightPortions = blockAngles - leftBinCenter;
leftPortions = binSize - rightPortions;
rightPortions = rightPortions / binSize;
leftPortions = leftPortions / binSize;
% save('leftPortions.mat','leftPortions');
% save('rightPortions.mat','rightPortions');

leftBinIndex(leftBinIndex == 0) = numBins;
rightBinIndex(rightBinIndex == (numBins + 1)) = 1;

H = zeros(1, numBins);

for i=1:numBins
    pixels = (leftBinIndex == i);
    H(1, i) = H(1, i) + sum(leftPortions(pixels)' * blockMagnitudes(pixels));
    pixels = (rightBinIndex == i);
    H(1, i) = H(1, i) + sum(rightPortions(pixels)' * blockMagnitudes(pixels));
end    

end