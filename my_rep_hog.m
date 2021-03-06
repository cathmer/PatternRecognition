% Preprocessing function used for pixel classification
function a = my_rep_hog(m)

% Preprocessing to make all the images square, resize them to 30x30 pixels
% and put an empty box around them. 
preproc = im_box([],0,1)*im_resize([], [28 28])*im_box([],1,0);
m = m * preproc;
% mLeft = mNoRot*im_rotate(-0.35);
% mRight = mNoRot*im_rotate(0.35);
% mMainaxisRot = mNoRot*im_rotate;

a = prdataset(m);

features = getHOGFeatures(a,[2 2]);
a = prdataset(double(features),getlabels(a));