directory1 = 'F:\INRIAPerson\NewINRIAPerson\New Train\pos\';
% to concatenate the descriptors of all the images of paticular file which are the output of Hog...

% this is for test neg images..
imageFile = dir(fullfile(directory1,'*.jpg'));
newtrain_pos = [];
for i = 1:length(imageFile)
    fileRead = strcat(directory1,imageFile(i).name);
    im = imread(fileRead);
    [hist,H]=Get_HOG_Descriptors(im);
    newtrain_pos  = [newtrain_pos,H];
end
save('newtrain_pos.mat','newtrain_pos');