setup; % This file should load the paths to the course files
prwaitbar off;

a = prnist([0:9],[1:100:1000]);
%figure(1); show(a);

b = preprocessing(prnist([0:9],[1:100:1000]));
%figure(2); show(b);

w = svc(b); % Trains a support vector machine
labels = b*w*labeld; % Shows the labels that the classifier assigns to objects from b

% Evaluate the performance of the classifier
e = nist_eval('preprocessing', w, 10);
disp(e);

%Uncomment this to see how rotation influences the images
%rotation(a);

%pixelclassification(a);

