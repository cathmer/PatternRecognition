function a = segment_digits

I = imread('handwritten_digits2.png'); % Read in image
I = rgb2gray(I);                        % convert image to grayscale
binaryImage = imbinarize(I,0.9);        % Convert to binary image

whiteRows = sum(binaryImage,2) == size(binaryImage,2); % Vector that is 1 for each row that has only white pixels
rowIndices = find(diff(whiteRows)~=0);  % Find the indices where the rows transition from nonwhite to white
a = prdataset; % Empty prdataset

% Loop through the rowIndices, indicating the start and end of row of each
% row box
for i=1:2:length(rowIndices)
    row = binaryImage(rowIndices(i):rowIndices(i+1),:);  % Create a new image which is one row
%     figure((i+1)/2); imshow(row);
    
    whiteColumns = sum(row,1) == size(row,1); % Find columns that are all white
    columnIndices = find(diff(whiteColumns)~=0); % Find the indices of the transition columns
    % TODO: Make it so that at least a number of consecutive columns are
    % white, e.g. only store indices where at least 10 consecutive columns
    % are white. Now if there is a small space in a digit, it will separate
    % the digit (which happens once). 
    
    % Loop through the columnIndices, to find each separate image
    for j=1:2:length(columnIndices)
        image = row(:,columnIndices(j):columnIndices(j+1)); % Create image
        image = im_resize(image,[64 64]); % Resize image
        
        b = im2feat(image); % Create prdataset from image
        a = [a b]; % Store image in prdataset
    end
end