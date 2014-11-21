function [ model ] = trainSVM( fpos,fneg )
    trainMatrix = [fpos, fneg];
    fprintf('TRAINING SVM...\n');
    labelMatrix = [];
    fPosLen = size(fpos);
    fNegLen = size(fneg);
    fprintf('Making the label Matrix...\n');
    labelMatrix = [labelMatrix, ones(1, fPosLen(2))];
    labelMatrix = [labelMatrix, (-1)*ones(1, fNegLen(2))];
    fprintf('Learning Model...\n');
    trainMatrix = trainMatrix';
    labelMatrix = labelMatrix';
    fprintf('Size TrainMatrix of %d,%d\n',size(trainMatrix));
    fprintf('Size LabelMatrix of %d,%d\n',size(labelMatrix));
    model = svmlearn(trainMatrix, labelMatrix, '-t -g 0.3 -c 0.5 -v 3');
    fprintf('TRAINING COMPLETED!!!\n');
end

