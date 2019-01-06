setup; % This file should load the paths to the course files
clear all;
%prwaitbar off;
prwarning off;

% Check if data can be loaded from file, otherwise create data
% If data loaded is changed, the file should be removed before running
if isfile('workspace_ini.mat')           
    load('workspace_ini.mat');
else
    image_data = prnist([0:9],[1:2:1000]);
    tst = prnist([0:9], [2:2:1000]);
    size = [28 28];
    noRot = preprocessing(image_data,size,0);
    leftRot = preprocessing(image_data,size,-0.35);
    rightRot = preprocessing(image_data,size,0.35);

    tstNoRot = preprocessing(tst,size,0);
    tstLeftRot = preprocessing(tst,size,-0.35);
    tstRightRot = preprocessing(tst,size,0.35);
    save('workspace_ini.mat');
end

pixelclassification(noRot,leftRot,rightRot,tstNoRot,tstLeftRot,tstRightRot);

% e = nist_eval('preprocessing', wNoRot, 100);
% disp("wNoRot");
% disp(e);
% e = nist_eval('preprocessingAll', wMax, 100);
% disp("Max");
% disp(e);

