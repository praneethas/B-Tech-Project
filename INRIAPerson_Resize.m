directory = 'F:\INRIAPerson\INRIAPerson\Test\neg\';   %%"The directory of the current images"
destination = 'F:\INRIAPerson\NewINRIAPerson\Test\neg\'; %%"The directory of the destination images"
imagefile = [dir(fullfile(directory,'*.jpg')); dir(fullfile(directory,'*.png'))];  %% to get all the images with .jpg and .png
for i = 1:length(imagefile)
    fileread = strcat(directory,imagefile(i).name);     %%exact image name with its directory
    [~,filename,~] = fileparts(fileread);              %% to get just name of the image without its extension(like .jpg or .png)
    filename = strcat(filename,'.jpg');
    filewrite = strcat(destination,filename);
    x = imread(fileread);                            %% read the image file
    y = imresize(x,[128,64]);                        %%resize the image file to 128X64
    z = rgb2gray(y);                                 %%convert rgb to gray
    imwrite(z,filewrite,'jpg');                      %%writes to the destination folder 
    %figure,imshow(x);
    %figure,imshow(y);
    %figure,imshow(z);
end