function a = getHOGFeatures(dataSet,cellSize)

images = data2im(dataSet);
objects = [];

for i=1:size(images,4)
    features = extractHOGFeatures(images(:,:,1,i),'CellSize',cellSize);
    objects = [objects; features];
end

a = prdataset(double(objects),getlabels(dataSet));