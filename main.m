setup; % This file should load the paths to the course files
clear all;
%prwaitbar off;
prwarning off;

image_data = prnist([0:9],[2:50:1000]);
tst = prnist([0:9], [1:25:1000]);
noRot = preprocessing(image_data);
leftRot = preprocessingLeftRot(image_data);
rightRot = preprocessingRightRot(image_data);
mainaxisRot = preprocessingMainaxisRot(image_data);

tstNoRot = preprocessing(tst);
tstLeftRot = preprocessingLeftRot(tst);
tstRightRot = preprocessingRightRot(tst);
tstMainaxisRot = preprocessingMainaxisRot(tst);

sampleSizes = [10 20];
clsf = svc(proxm('p',5))*classc;
msg = "Testing svc with non rotated dataset";
testClassifier(noRot,tstNoRot,clsf,sampleSizes,msg);

combiner1 = votec;
testCompl = [tstNoRot tstLeftRot tstRightRot tstMainaxisRot];
msg = "Testing svc with dataset rotated in different ways, combined with majority vote";
testClassifier({noRot,leftRot,rightRot,mainaxisRot},testCompl,clsf,sampleSizes,msg,combiner1);
combiner2 = meanc;
msg = "Testing svc with dataset rotated in different ways, combined with mean";
testClassifier({noRot,leftRot,rightRot,mainaxisRot},testCompl,clsf,sampleSizes,msg,combiner1);

trainedCombiner = [clsf nmc*classc]*fisherc;
msg = "Testing trained combiner on non-rotated dataset";
testClassifier(noRot,tstNoRot,trainedCombiner,sampleSizes,msg);

msg = "Testing trained combiner on differently rotated datasets that are combined with majority vote";
testClassifier({noRot,leftRot,rightRot,mainaxisRot},testCompl,trainedCombiner,sampleSizes,msg,combiner1);

% e = nist_eval('preprocessing', wNoRot, 100);
% disp("wNoRot");
% disp(e);
% e = nist_eval('preprocessingAll', wMax, 100);
% disp("Max");
% disp(e);

