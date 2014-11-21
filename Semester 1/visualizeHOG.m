fprintf('Running Test\n');
wSize = [64, 128];
testImPath = './Test/borderHuman/';
imlist = dir([testImPath '*.png']);
for j = 1:length(imlist)
   f = imread([testImPath imlist(j).name]); 
   if(ndims(f)==3)
        f = rgb2gray(f);
    end
    f = imresize(f,[200,150]);
    figure; imshow(f); axis off; 
    [h, H] = Get_HOG_Descriptors(f, [8 8], [8 8], [-1 0 1], 8);
    im = Visualize_HOG_Features(h);
    figure; imshow(im); axis off; 
end