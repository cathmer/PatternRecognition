setup; % This file should load the paths to the course files
clear all;
%prwaitbar off;
prwarning off;

% Check if data can be loaded from file, otherwise create data
% If data loaded is changed, the file should be removed before running
if isfile('workspace_ini.mat')           
    load('workspace_ini.mat');
else
    trn_data = prnist([0:9],[1:2:1000]);
    tst_data = prnist([0:9], [2:10:1000]);
    imgSize = [28 28];
    trn = preprocessing(trn_data,imgSize,0);
    trnLeftRot = preprocessing(trn_data,imgSize,-0.35);
    trnRightRot = preprocessing(trn_data,imgSize,0.35);
    trnMainAxisRot = preprocessing(trn_data,imgSize,0);
    tst = preprocessing(tst_data,imgSize,0);
    tstLeftRot = preprocessing(tst_data,imgSize,-0.35);
    tstRightRot = preprocessing(tst_data,imgSize,0.35);
    tstMainAxisRot = preprocessing(tst_data,imgSize,0);
    
    save('workspace_ini.mat');
end

w = pixelclassification(trn,trnLeftRot,trnRightRot,trnMainAxisRot,...
    tst,tstLeftRot,tstRightRot,tstMainAxisRot);
e = nist_eval('my_rep_pixels', w, 100);
disp("Pixels classified with 5th polynomial SVM");
disp(e);

w = hogClassification(trn,tst);
e = nist_eval('my_rep_hog', w, 100);
disp("HOG features with radial basis");
disp(e);

save('optimal_classifier.mat','w');

