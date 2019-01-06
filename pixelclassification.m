function pixelclassification(noRot,leftRot,rightRot,tstNoRot,tstLeftRot,tstRightRot)

sampleSizes = [10 20];
clsf = svc(proxm('p',5))*classc;
combiner1 = votec;
combiner2 = meanc;
testCompl = [tstNoRot tstLeftRot tstRightRot];
msg = "Testing svc with dataset rotated in different ways, combined with majority vote and mean";
[E,W] = testClassifier({noRot,leftRot,rightRot},testCompl,clsf,sampleSizes,msg,{combiner1,combiner2});

clsf2 = knnc([],1);
msg = "Testing knnc with dataset rotated in different ways, combined with mean";
testClassifier({noRot,leftRot,rightRot},testCompl,clsf2,sampleSizes,msg,combiner2);

% clsf3 = bpxnc([],[15 10]);
% msg = "Testing neural network on differently rotated datasets that are combined with mean";
% testClassifier({noRot,leftRot,rightRot},testCompl,clsf3,sampleSizes,msg,combiner2);