%% Resize Images for R-HOG Calculation

% Obtain Grayscale images of size 128*64 from Color Images 
% from Test\pos, Test\neg, Train\pos, Train\neg

directory = 'F:\INRIAPerson\INRIAPerson\Test\neg\';      % The directory of the current images

% directory = 'F:\INRIAPerson\INRIAPerson\Test\neg\';     
% directory = 'F:\INRIAPerson\INRIAPerson\Test\neg\';   
% directory = 'F:\INRIAPerson\INRIAPerson\Test\neg\';      

destination = 'F:\INRIAPerson\NewINRIAPerson\Test\neg\'; % The directory of the destination images
imageFile = [dir(fullfile(directory,'*.jpg')); dir(fullfile(directory,'*.png'))];  % to get all the images with .jpg and .png
for i = 1:length(imageFile)
    fileRead = strcat(directory,imageFile(i).name);    % exact image name with its directory
    [~,fileName,~] = fileparts(fileRead);              % to get just name of the image without its extension(like .jpg or .png)
    fileName = strcat(fileName,'.jpg');
    fileWrite = strcat(destination,fileName);
    x = imread(fileRead);                              % read the image file
    x = imresize(x,[128,64]);                          % resize the image file to 128X64
    x = rgb2gray(x);                                   % convert rgb to gray
    imwrite(x,fileWrite,'jpg');                        % writes to the destination folder 
end