%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%             Pattern recognition              %%
%%             Final assignment                 %%
%%                                              %% 
%%             Casper Athmer - xxxxxx           %% 
%%             Cas Bilstra   - xxxxxx           %%
%%             Peter Jamar   - 4128486          %%
%%                                              %%
%%             January 2019                     %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
setup; % This file should load the paths to the course files
%prwaitbar off;
prwarning off;
warning off

% Check if data can be loaded from file, otherwise create data
% If data loaded is changed, the file should be removed before running
if isfile('workspace_ini.mat')           
    load('workspace_ini.mat');
else
    trn_data = prnist([0:9],[1:100:1000]);
    tst_data = prnist([0:9], [2:100:1000]);
    imgSize = [28 28];
    trn = preprocessing(trn_data,imgSize,0);
%     trnLeftRot = preprocessing(trn_data,imgSize,-0.35);
%     trnRightRot = preprocessing(trn_data,imgSize,0.35);
%     trnMainAxisRot = preprocessing(trn_data,imgSize,0);
    tst = preprocessing(tst_data,imgSize,0);
%     tstLeftRot = preprocessing(tst_data,imgSize,-0.35);
%     tstRightRot = preprocessing(tst_data,imgSize,0.35);
%     tstMainAxisRot = preprocessing(tst_data,imgSize,0);
%     figure(1); show(trn_data);
%     figure(2); show(trn);
    
    save('workspace_ini.mat');
end

a= trn;
a = setprior(a,getprior(a));


m = im_moments(a,'zer',12);

w = featself(m,'maha-s');
trainsize = [2 4 9];
iter =1;

x = m*w;
randreset;
e1 = cell(1,numel(trainsize));
% prwaitbar calls are just used for reporting progress and may be skipped
[n,s,count] = prwaitbarinit('Processing %i curves:',2*numel(trainsize));
for j=1:numel(trainsize)
  e1{j} = clevalf(x,qdc([],[],1e-6),[1:15],ones(1,10)*trainsize(j),iter);
  count = prwaitbarnext(n,s,count);
end
plote(e1,'nolegend')
legend('train size: 20','train size: 30','train size: 50','train size: 100','train size: 500')
title('Feature curve for Satellite dataset, optimized feature order')
fontsize(14)
% set(gcf,'position',[ 680 558 808 420]);

%% Feature extraction






%%
% w = pixelclassification(trn,trnLeftRot,trnRightRot,trnMainAxisRot,...
%     tst,tstLeftRot,tstRightRot,tstMainAxisRot);
% e = nist_eval('my_rep_pixels', w, 100);
% disp("Pixels classified with 5th polynomial SVM");
% disp(e);
% 
% N = prmemory(100000000);
% 
% cellSize = [2 2];
% tic;
% trn = getHOGFeatures(trn,cellSize);
% tst = getHOGFeatures(tst,cellSize);
% fprintf("It took %f seconds to extract the HOG features\n", toc);
% % Extracting HOG features for 1000 elements per class takes less than 15
% % mins
% 
% sampleSizes = [1000];
% clsf2 = svc(proxm('r',5))*classc;
% msg = "Testing SVM with radial basis 5";
% [E,W] = testClassifier(trn,tst,clsf2,sampleSizes,msg);
% w = W{1};
% 
% % w = hogClassification(trn,tst);
% e = nist_eval('my_rep_hog', w, 100);
% disp("HOG features with radial basis");
% disp(e);
% 
% save('optimal_classifier.mat','w','-v7.3');