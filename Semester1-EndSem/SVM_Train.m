clc
clear all

addpath './svm_mex601/matlab/';
addpath './svm_mex601/bin/';

pathPosTrain = './Train/pos/';   % positive example
pathNegTrain = './Train/neg/';   % negative example
myPathSaveVar = './MATFiles/';

%% Extracting Features and training
cd './MATFiles/';
if exist('trainPos.mat','file') && exist('trainNeg.mat','file')
    fprintf('Files already exist!!!\n');
    load trainPos;
    load trainNeg;
    cd '../';
else
    cd '../';
    fprintf('Calculating Positive and Negative Features\n');
    [trainPos, trainNeg] = features(pathPosTrain, pathNegTrain);  % extract features
    fprintf('Saving MAT Files\n');
    pathSave = strcat(myPathSaveVar,'trainPos.mat');
    save(pathSave, 'trainPos');
    pathSave= '';
    pathSave = strcat(myPathSaveVar,'trainNeg.mat');
    save(pathSave, 'trainNeg');
end
tstart=tic;
fprintf('Training Positive and Negative Features against Labels\n');
[ modelTrain ] = trainSVM(trainPos, trainNeg );          % train SVM
pathSave= '';
pathSave = strcat(myPathSaveVar,'modelTrain.mat');
save(pathSave, 'modelTrain');
tElapsed = toc(tstart);
fprintf('Time elapsed %d\n',tElapsed);


%% Extracting Features and testing
pathPosTest = './Test/pos/';       % positive example
pathNegTest = './Test/neg/';   % negative example
cd './MATFiles/';
if exist('testPos.mat','file') && exist('testNeg.mat','file')
    fprintf('Files already exist\n');
    load testPos;
    load testNeg;
    cd '../';
else
    cd '../';
    [testPos, testNeg] = features(pathPosTest, pathNegTest);  % extract features
    fprintf('Saving MAT Files\n');
    pathSave = strcat(myPathSaveVar,'testPos.mat');
    save(pathSave, 'testPos');
    pathSave= '';
    pathSave = strcat(myPathSaveVar,'testNeg.mat');
    save(pathSave, 'testNeg');
end
testMatrix = [testPos, testNeg];
fPosTestLen = size(testPos);
fNegTestLen = size(testNeg);
labelTest = [];
labelTest = [labelTest, ones(1, fPosTestLen(2))];
labelTest = [labelTest, (-1)*ones(1, fNegTestLen(2))];
testMatrix = testMatrix';
labelTest = labelTest';
fprintf('Size TestMatrix %d,%d\n',size(testMatrix));
fprintf('Size LabelTestMatrix %d,%d\n',size(labelTest));
[errTest, predictionsTest] = svm_classify(testMatrix, labelTest, modelTrain);