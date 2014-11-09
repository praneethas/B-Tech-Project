directory1 = 'F:\INRIAPerson\NewINRIAPerson\Test\neg\';
directory2 = 'F:\INRIAPerson\NewINRIAPerson\Test\pos\';
directory3 = 'F:\INRIAPerson\NewINRIAPerson\Train\neg\';
directory4 = 'F:\INRIAPerson\NewINRIAPerson\Train\pos\';
% to concatenate the descriptors of all the images of paticular file which are the output of Hog...

% this is for test neg images..
imageFile = dir(fullfile(directory1,'*.jpg'));
test_neg = [];
for i = 1:length(imageFile)
    fileRead = strcat(directory1,imageFile(i).name);
    im = imread(fileRead);
    [hist,H]=Get_HOG_Descriptors(im);
    test_neg  = [test_neg,H];
end
save('test_neg.mat','test_neg');

% this is for test pos images..
imageFile = dir(fullfile(directory2,'*.jpg'));
test_pos = [];
for i = 1:length(imageFile)
    fileRead = strcat(directory2,imageFile(i).name);
    im = imread(fileRead);
    [hist,H]=Get_HOG_Descriptors(im);
    test_pos  = [test_pos,H];
end
save('test_pos.mat','test_pos');

% this is for train neg images..
imageFile = dir(fullfile(directory3,'*.jpg'));
train_neg = [];
for i = 1:length(imageFile)
    fileRead = strcat(directory3,imageFile(i).name);
    im = imread(fileRead);
    [hist,H]=Get_HOG_Descriptors(im);
    train_neg  = [train_neg,H];
end
save('train_neg.mat','train_neg');

% this is for train pos images..
imageFile = dir(fullfile(directory4,'*.jpg'));
train_pos = [];
for i = 1:length(imageFile)
    fileRead = strcat(directory4,imageFile(i).name);
    im = imread(fileRead);
    [hist,H]=Get_HOG_Descriptors(im);
    train_pos  = [train_pos,H];
end
save('train_pos.mat','train_pos')

    

