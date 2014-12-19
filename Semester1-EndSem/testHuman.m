fprintf('Running Test\n');
wSize = [64, 128];
testImPath = './Test/borderHuman/';
imlist = dir([testImPath '*.jpg']);
for j = 1:length(imlist)
    f = imread([testImPath imlist(j).name]);
    g = f;
    if(ndims(g)==3)
        [~,~,f,~] = hsiImage(f);
    end
    f = imresize(f,[150,150]);
    g = imresize(g,[150,150]);
    figure; imshow(g); axis off; 
    topLeftRow = 1;
    topLeftCol = 1;
    fprintf('Detect Human\n');
    fcount = 1;
    [bottomRightCol, bottomRightRow] = size(f);
    for y = topLeftCol:bottomRightCol-wSize(2)    
        for x = topLeftRow:bottomRightRow-wSize(1)
            p1 = [x,y];
            p2 = [x+(wSize(1)-1), y+(wSize(2)-1)];
            po = [p1; p2];
            %rectangle('Position',[p1(1),p1(2),p2(1),p2(2)],'LineWidth',1, 'EdgeColor','r');
            %fprintf('Testing for (%d,%d)\n',x,y);
            img = imcut(po,f);      
            [~,H] = Get_HOG_Descriptors(img);
            featureVector{fcount} = H;
            boxPoint{fcount} = [x,y];
            fcount = fcount+1;
        end
    end
    P = cell2mat(featureVector);
    [rowP,colP]=size(P);
    lebel = ones(colP,1);
    %fprintf('P = %d,%d\n',size(P));
    %fprintf('lebel = %d,%d\n',size(lebel));
    [err, predict_label] = svm_classify(P', lebel, modelTrain);
    [a, indx]= max(predict_label);
    bBox = cell2mat(boxPoint(indx));
    rectangle('Position',[bBox(1),bBox(2),64,128],'LineWidth',1, 'EdgeColor','g'); 
    s = 'final_12';
    s = strcat(s,num2str(j));
    saveas(gcf, ['./Results/' s], 'png');
    
end