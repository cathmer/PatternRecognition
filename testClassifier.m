% Function to test a classifier with training and test data and a vector
% sampleSizes that specifies different number of objects per class to test. 
% trn can be one dataset or a cell array of datasets. In the latter case, the
% different training sets are all trained with the classifier and then
% combined with the specified combiner. The message is displayed in the
% beginning to indicate what is being tested. Each classifier that is
% generated is tested on the test set.
function [E,W] = testClassifier(trn,tst,clsf,sampleSizes,message,combiner)

disp(message);
tic;
if exist("combiner",'var')
    W = trainClassifier(trn,clsf,sampleSizes,combiner);
else
    W = trainClassifier(trn,clsf,sampleSizes);
end

fprintf("All classifiers took %f seconds to complete\n", toc);
E = {};

for i=1:size(W,2)
    e = tst*W{1,i}*testc;
    E{i} = e;
    fprintf("The error(s) for size %d is(are): ", sampleSizes(i));
    disp(e);
end



