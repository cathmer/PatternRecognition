function w = hogClassification(trn,tst)

cellSize = [2 2];
tic;
trn = getHOGFeatures(trn,cellSize);
tst = getHOGFeatures(tst,cellSize);
fprintf("It took %f seconds to extract the HOG features\n", toc);

sampleSizes = [10];
clsf1 = svc(proxm('p',5))*classc;
msg = "Testing SVM with polynomial 5";
testClassifier(trn,tst,clsf1,sampleSizes,msg);

clsf2 = svc(proxm('r',4))*classc;
msg = "Testing SVM with radial basis 4";
testClassifier(trn,tst,clsf2,sampleSizes,msg);

clsf2 = svc(proxm('r',5))*classc;
msg = "Testing SVM with radial basis 5";
[E,W] = testClassifier(trn,tst,clsf2,sampleSizes,msg);
w = W{1};