load('test_neg'); 
load('test_pos');
load('train_neg');
load('train_pos');
true_negative = 0;
true_positive = 0;
false_negative = 0;
false_positive =0;
c1 = size(train_pos,2);    % to know the size of the array
c2 = size(train_neg,2);     % to know the size of the array
t1 = ones(1,c1);            %creates the ones array of size train_pos
t2 = zeros(1,c2);
input_label = [t1,t2];       % to concatenate the label vectors t1 and t2
c1 = size(test_pos,2);
c2 = size(test_neg,2);
t1 = ones(1,c1);
t2 = zeros(1,c2);
output_label = [t1,t2];
t = output_label';
test = [test_pos,test_neg];      % test matrix both neg and pos..
train = [train_pos,train_neg];   %train matrix both neg and pos..
SVMtrain = svmtrain(train,input_label);  % to train the svm with the train images 
SVMtest = svmclassify(SVMtrain,test');   %using the above train vector to clasify the images in test 
s = size(SVMtest,1);
for i=1:s                                  
    if(t(i)==0 && SVMtest(i)==0)
        true_negative = true_negative+1; %true negative
    end
    if(t(i)==1 && SVMtest(i)==1)  %true positive
        true_positive = true_positive+1;
    end
    if(t(i)==1 && SVMtest(i)==0)  %false positive
        false_positive = false_positive+1;
    end
    if(t(i)==0 && SVMtest(i)==1)   %false negative
        false_negative = false_negative+1;
    end
end

