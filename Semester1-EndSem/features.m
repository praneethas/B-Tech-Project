function [fpos, fneg] = features(pathPos,pathNeg)
    
    fpos = [];
    fneg = [];
    % extract features for positive examples
    imlist = [dir(fullfile(pathPos,'*.jpg')); dir(fullfile(pathPos,'*.png'))];
    fprintf('There are %d,%d Positive Files\n',size(imlist));
    for i = 1:length(imlist)
        im = imread([pathPos imlist(i).name]);
        fprintf('HOG for imageP %d\n',i);
        [~,h] = Get_HOG_Descriptors(im);
        fpos = [fpos, h];
    end
    
    % extract features for negative examples
    imlist = [dir(fullfile(pathNeg,'*.jpg')); dir(fullfile(pathNeg,'*.png'))];
    fprintf('There are %d,%d Negative Files\n',size(imlist));
    for i = 1:length(imlist)
        im = imread([pathNeg imlist(i).name]);
        fprintf('HOG for imageN %d\n',i);
        [~,h] = Get_HOG_Descriptors(im);
        fneg = [fneg, h];
    end

end
