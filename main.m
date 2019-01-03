setup; % This file should load the paths to the course files
clear all;
%prwaitbar off;

b = preprocessing(prnist([0:9],[1:100:1000]));
%figure(2); show(b);
disp('Finished preprocessing b!');

w = b*svc(proxm('p',5)); % Trains a support vector machine
labels = b*w*labeld; % Shows the labels that the classifier assigns to objects from b
disp('Finished training b');

% Evaluate the performance of the classifier
e = nist_eval('preprocessing', w, 100);
disp(e);

%Uncomment this to see how rotation influences the images
%rotation(a);

%pixelclassification(a);

