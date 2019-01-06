function [E,W] = pixelclassification(noRot,leftRot,rightRot,tstNoRot,tstLeftRot,tstRightRot)

sampleSizes = [10 20];
clsf = svc(proxm('p',5))*classc;
combiner1 = votec;
combiner2 = meanc;
combiner3 = prodc;
combiner4 = maxc;
combiner5 = minc;
testCompl = [tstNoRot tstLeftRot tstRightRot];
msg = "Testing svc with dataset rotated in different ways, combined with multiple combiners";
[E,W] = testClassifier({noRot,leftRot,rightRot},testCompl,clsf,sampleSizes, ...
            msg,{combiner1,combiner2,combiner3,combiner4,combiner5});

clsf2 = knnc([],1);
msg = "Testing knnc with dataset rotated in different ways, combined with mean";
testClassifier({noRot,leftRot,rightRot},testCompl,clsf2,sampleSizes,msg, ...
        combiner1);

% clsf3 = bpxnc([],[15 10]);
% msg = "Testing neural network on differently rotated datasets that are combined with mean";
% testClassifier({noRot,leftRot,rightRot},testCompl,clsf3,sampleSizes,msg,combiner2);