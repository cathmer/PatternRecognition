% Preprocessing function used for pixel classification
function a = preprocessing(m,size,rotationAngle)

% Preprocessing to make all the images square, resize them to 30x30 pixels
% and put an empty box around them. 
preproc = im_box([],0,1)*im_resize([], size)*im_box([],1,0)*im_rotate(rotationAngle);
m = m * preproc;
a = prdataset(m);