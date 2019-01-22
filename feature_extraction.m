function [x,b] = feature_extraction(a)

c = data2im(a);             % convert dataset to images for display
x = im_moments(a,'zer',12);      % compute Zerniki moments



b = data2im(x);             % unpack dataset with results  

end