function w = pixelclassification(noRot,leftRot,rightRot,mainAxisRot,tstNoRot,tstLeftRot,tstRightRot,tstMainAxisRot)

sampleSizes = [10];
clsf = svc(proxm('p',5))*classc;
combiner1 = votec;
combiner2 = meanc;
combiner3 = prodc;
combiner4 = maxc;
combiner5 = minc;
testCompl = [tstNoRot tstLeftRot tstRightRot tstMainAxisRot];
msg = "Testing svc with dataset rotated in different ways, combined with mean combiner";
[E,W] = testClassifier({noRot,leftRot,rightRot,mainAxisRot},testCompl,clsf,sampleSizes, ...
            msg,meanc);
w = W{1};

clsf2 = knnc([],1);
msg = "Testing knnc with dataset rotated in different ways, combined with mean";
testClassifier({noRot,leftRot,rightRot,mainAxisRot},testCompl,clsf2,sampleSizes,msg, ...
        {combiner1,combiner2,combiner3,combiner4,combiner5});