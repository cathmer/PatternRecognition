function a = segment_digits

I = imread('handwritten_digits2.png'); % Read in image
I = rgb2gray(I);                        % convert image to grayscale
binaryImage = imbinarize(I,0.9);        % Convert to binary image
figure(1); imshow(binaryImage);

whiteRows = sum(binaryImage,2) == size(binaryImage,2); % Vector that is 1 for each row that has only white pixels
rowIndices = find(diff(whiteRows)~=0);  % Find the indices where the rows transition from nonwhite to white
a = prdataset; % Empty prdataset

% Loop through the rowIndices, indicating the start and end of row of each
% row box
for i=1:2:length(rowIndices)
    row = binaryImage(rowIndices(i):rowIndices(i+1),:);  % Create a new image which is one row
    
    whiteColumns = sum(row,1) == size(row,1); % Find columns that are all white
    columnIndices = find(diff(whiteColumns)~=0); % Find the indices of the transition columns
    
    % The below code is a not very pretty way to check if there is at
    % least 15 consecutive white rows for every index. This is to prevent
    % that when there is a small space in a number, it segments the number
    % into two numbers. It works for the current image. 
    n = 15; % Number of consecutive white rows required
    finalColumnIndices = []; 
    previous = true;
    for j=1:length(columnIndices)
        index = columnIndices(j);
        hasNWhiteColumns = true;
        if previous == false
            previous = true;
            hasNWhiteColumns = false;
        elseif whiteColumns(index) == 0 % The current column is black, meaning it is switchint to white
            % Check here if at least the following n columns are also white
            for h=1:n
                if whiteColumns(index + h) == 0
                    hasNWhiteColumns = false;
                    previous = false;
                end
            end
        end
        
        if hasNWhiteColumns == true
            finalColumnIndices = [finalColumnIndices index];
        end
    end
    
    columnIndices = finalColumnIndices;
    
    % Loop through the columnIndices, to find each separate image
    for j=1:2:length(columnIndices)
        image = double(~row(:,columnIndices(j):columnIndices(j+1))); % Create image
        image = im_box(image,0); % Remove empty (black) rows around image)
        image = im_box(image,0,1); % Make image square
        image = im_resize(image,[28 28]); % Resize image
        image = im_box(image,1,0); % Put bounding box around image
        
        a = [a; im2obj(image)]; % Store image in prdataset
    end
end

labels = char(ones(10,1)*'digit_1');
labels = [labels; char(ones(10,1)*'digit_2')];
labels = [labels; char(ones(10,1)*'digit_3')];
labels = [labels; char(ones(10,1)*'digit_4')];
labels = [labels; char(ones(10,1)*'digit_5')];
labels = [labels; char(ones(10,1)*'digit_6')];
labels = [labels; char(ones(10,1)*'digit_7')];
labels = [labels; char(ones(10,1)*'digit_8')];
labels = [labels; char(ones(10,1)*'digit_9')];

a = setlabels(a,labels);
figure(2); show(a);