warning('off','all')

% PART 1
dataDir = fullfile('..','data');
imName1 = 'uttower_left.jpg';
imName2 = 'uttower_right.jpg';
I1 = imread(fullfile(dataDir, imName1));
I2 = imread(fullfile(dataDir, imName2));

stitch_images(I1,I2);

% PART 2
%'ledge','hill','pier'
dataDir = fullfile('..','data','hill');
imName1 = '1.jpg';
imName2 = '2.jpg';
imName3 = '3.jpg';

I1 = imread(fullfile(dataDir, imName1));
I2 = imread(fullfile(dataDir, imName2));
I3 = imread(fullfile(dataDir, imName3));

stitch_multiple_images({I1, I2, I3});

dataDir = fullfile('..','data','ledge');
imName1 = '1.jpg';
imName2 = '2.jpg';
imName3 = '3.jpg';

I1 = imread(fullfile(dataDir, imName1));
I2 = imread(fullfile(dataDir, imName2));
I3 = imread(fullfile(dataDir, imName3));

stitch_multiple_images({I1, I2, I3});

dataDir = fullfile('..','data','pier');
imName1 = '1.jpg';
imName2 = '2.jpg';
imName3 = '3.jpg';

I1 = imread(fullfile(dataDir, imName1));
I2 = imread(fullfile(dataDir, imName2));
I3 = imread(fullfile(dataDir, imName3));

stitch_multiple_images({I1, I2, I3});
