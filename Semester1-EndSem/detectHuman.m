function detectHuman(im, model, wSize)

topLeftRow = 1;
topLeftCol = 1;
fprintf('Detect Human\n');
fcount = 1;
% featureVector = [];
% boxPoint = [];
hold on;
    
[bottomRightCol, bottomRightRow] = size(im);

fprintf('Size of Image: (%d,%d)\n',size(im));
% this for loop scan the entire image and extract features for each sliding window
for y = topLeftCol:bottomRightCol-wSize(2)    
    for x = topLeftRow:bottomRightRow-wSize(1)
        p1 = [x,y];
        p2 = [x+(wSize(1)-1), y+(wSize(2)-1)];
        po = [p1; p2];
        figure; imshow(im); axis off;
        rectangle('Position',[p1(1),p1(2),p2(1),p2(2)],'LineWidth',1, 'EdgeColor','r');
        %hold on;
        fprintf('Testing for (%d,%d)\n',x,y);
        img = imcut(po,im);      
        [~,H] = Get_HOG_Descriptors(double(img));
        featureVector{fcount} = H;
        boxPoint{fcount} = [x,y];
        fcount = fcount+1;
        %x = x+1;
    end
end

P = cell2mat(featureVector);
[rowP,colP]=size(P);
lebel = ones(colP,1);
fprintf('P = %d,%d\n',size(P));
fprintf('lebel = %d,%d\n',size(lebel));
% P = featureVector;
% each row of P' correspond to a window
% [~, predictions] = svmclassify(P',lebel,model); % classifying each window
[err, predict_label] = svm_classify(P', lebel, model);
%fprintf('boxPoint\n');
%disp(boxPoint);
[a, indx]= max(predict_label);
%fprintf('indx\n');
%disp(indx);
bBox = cell2mat(boxPoint(indx));
%bBox = boxPoint(indx);
%fprintf('bBox\n');
%disp(bBox);
hold on;
rectangle('Position',[bBox(1),bBox(2),64,128],'LineWidth',1, 'EdgeColor','g');
end

