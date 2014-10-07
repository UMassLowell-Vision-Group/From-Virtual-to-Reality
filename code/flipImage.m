
% compute the bounding box of images rendered from 3ds max

function flipImage(inputDir)


filelist = dir([inputDir '/*.jpg']);

fprintf('%d jpg files \n', length(filelist));

for i = 1:length(filelist)
   inputImage = imread([inputDir '/' filelist(i).name]);
   imgFlipped = flipdim(inputImage,2);
   filename = strrep(filelist(i).name, '.jpg', '');
   imwrite(imgFlipped,[inputDir '/' filename '_flip.jpg'],'BitDepth',8);
end