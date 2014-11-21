function [histogramImageBlock, HOG_Descriptor] = Get_HOG_Descriptors(f, blockSize, cellSize, gradient, numBins)


if nargin<0
	error('Error: Minimum one argument should be there.\n');
    error('Usage: Get_HOG_Descriptors(f, blockSize, cellSize, numBins)\n');
    return ;
elseif nargin==1
	blockSize = [8 8];
	cellSize = [8 8];
	gradient = [-1 1];
	numBins = 9;
elseif nargin==2
	cellSize = [8 8];
	gradient = [-1 0 1];
	numBins = 9;
elseif nargin==3
	gradient = [-1 0 1];
	numBins = 9;
else
	if ndims(blockSize)~=2 || ndims(cellSize)~=2
		error('Error: Block Size should be 2');
		return ;
	end
	numBins = 9;
end

if(ndims(f)==3)
    f = rgb2gray(f);
end

[row,col] = size(f);
% 1px border for gradient calculation
if ((col ~= 66) || (row ~= 130))
    %fprintf('Images are not of size 128 * 64\n');
    %fprintf('Resizing Image to 128 * 64\n');
    f = imresize(f, [128, 64]);
    f = padarray(f, [1 1]);
end

if ((col == 64) && (row == 128))
    %fprintf('Padding Image for gradient calculation.\n');
    f = padarray(f, [1 1]);
end

%fprintf('Size of Image is (%d,%d)\n',size(f));
hx = gradient;
hy = gradient';

dx = imfilter(double(f), hx);
dy = imfilter(double(f), hy);

dx = dx(2 : (size(dx, 1) - 1), 2 : (size(dx, 2) - 1));
dy = dy(2 : (size(dy, 1) - 1), 2 : (size(dy, 2) - 1)); 

angle = atan2(dy, dx);
magnitude = ((dy.^2) + (dx.^2)).^(0.5);
% save('angle.mat','angle');
% save('magnitude.mat','magnitude');

% disp(angle);
% disp(magnitude);

HOG_Descriptor = [];
histogramImageBlock = zeros(16, 8, numBins);

for i = 0 : 15
    rowOffset = (i * cellSize) + 1;
    for j = 0 : 7
        colOffset = (j * cellSize) + 1;
        rowIndices = rowOffset : (rowOffset + cellSize(1) - 1);
        colIndices = colOffset : (colOffset + cellSize(2) - 1);
        blockAngles = angle(rowIndices, colIndices); 
        blockMagnitudes = magnitude(rowIndices, colIndices);
        histogramImageBlock(i + 1, j + 1, :) = Get_Histogram_Image_Block(blockMagnitudes(:), blockAngles(:), numBins, 'unsigned');
    end
end

for i = 1 : 15  
    for j = 1 : 7
        blockHistogram = histogramImageBlock(i : i + 1, j : j + 1, :);
        magnitude = norm(blockHistogram(:)) + 0.001;
        normalized = blockHistogram / magnitude;
        HOG_Descriptor = [HOG_Descriptor; normalized(:)];
    end
end