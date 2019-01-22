clear all;
setup;
load('classifier.mat');
a = segment_digits; % Reads in handwritten_digits2.png and segments the numbers and does
% some preprocessing as well
b = getHOGFeatures(a,[2 2]); % Get the HOG Features
labels = b*w*labeld; % Retrieve the labels from the classifier
real_labels = getlab(b); % Retrieve the real labels
e = b*w*testc; % Get the error
confmat(real_labels,labels) % Print a confusion matrix