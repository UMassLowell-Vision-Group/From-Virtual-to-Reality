
% compute the bounding box of images rendered from 3ds max

function computerBB(inputDir, outputDir, cls)

filelist = dir([inputDir '/*.jpg']);

fprintf('%d jpg files \n', length(filelist));

cls = strrep(cls, '_', '');

for i = 1:length(filelist)
   inputImage = imread([inputDir '/' filelist(i).name]);
   noneZero = inputImage~=255;
   noneZero = noneZero(:,:,1) | noneZero(:,:,2) | noneZero(:,:,3);
   columnIndex = find(max(noneZero)==1);
   rowIndex = find(max(transpose(noneZero))==1);
   
   % shifted bbox
   xmin = columnIndex(1);
   ymin = rowIndex(1);
   xmax = columnIndex(length(columnIndex));
   ymax = rowIndex(length(rowIndex));
   xlength = xmax - xmin;
   ylength = ymax - ymin;
   % shifted bbox
   %xmin = max(xmin + round(xlength * 0.01 * randi([-10,10])), 1);
   %xmax = min(xmax + round(xlength * 0.01 * randi([-10,10])), size(inputImage,2));
   %ymin = max(ymin + round(ylength * 0.01 * randi([-10,10])), 1);
   %ymax = min(ymax + round(ylength * 0.01 * randi([-10,10])), size(inputImage,1));
   
   imshow(inputImage(ymin:ymax,xmin:xmax,:));
   filename = strrep(filelist(i).name, '.jpg', '');
   if ~exist(outputDir, 'dir')
       mkdir(outputDir);
       %mkdir([outputDir '_BBox']);
   end
   imwrite(inputImage(ymin:ymax,xmin:xmax,:),[outputDir '/' filename '_BB.jpg'],'BitDepth',8);

   
   docNode = com.mathworks.xml.XMLUtils.createDocument('annotation');
   docRootNode = docNode.getDocumentElement;
   
   folderElement = docNode.createElement('folder');
   folderElement.appendChild(docNode.createTextNode(cls));
   docRootNode.appendChild(folderElement);
   
   filenameElement = docNode.createElement('filename');
   filenameElement.appendChild(docNode.createTextNode([filename '.jpg']));
   docRootNode.appendChild(filenameElement);
   
   sourceElement = docNode.createElement('source');
   databaseElement = docNode.createElement('database');
   databaseElement.appendChild(docNode.createTextNode('photorealistic rendering'));
   sourceElement.appendChild(databaseElement);
   docRootNode.appendChild(sourceElement);
   
   sizeElement = docNode.createElement('size');
   widthElement = docNode.createElement('width');
   widthElement.appendChild(docNode.createTextNode(num2str(size(inputImage,2))));
   heightElement = docNode.createElement('height');
   heightElement.appendChild(docNode.createTextNode(num2str(size(inputImage,1))));
   depthElement = docNode.createElement('depth');
   depthElement.appendChild(docNode.createTextNode(num2str(3)));
   sizeElement.appendChild(widthElement);
   sizeElement.appendChild(heightElement);
   sizeElement.appendChild(depthElement);
   docRootNode.appendChild(sizeElement);
   
   segmentedElement = docNode.createElement('segmented');
   segmentedElement.appendChild(docNode.createTextNode(num2str(0)));
   docRootNode.appendChild(segmentedElement);
   
   objectElement = docNode.createElement('object');
   nameElement = docNode.createElement('name');
   nameElement.appendChild(docNode.createTextNode(cls));
   poseElement = docNode.createElement('pose');
   poseElement.appendChild(docNode.createTextNode('Unspecified'));
   truncatedElement = docNode.createElement('truncated');
   truncatedElement.appendChild(docNode.createTextNode(num2str(0)));
   difficultElement = docNode.createElement('difficult');
   difficultElement.appendChild(docNode.createTextNode(num2str(0)));
   bndboxElement = docNode.createElement('bndbox');
   xminElement = docNode.createElement('xmin');
   xminElement.appendChild(docNode.createTextNode(num2str(xmin)));
   yminElement = docNode.createElement('ymin');
   yminElement.appendChild(docNode.createTextNode(num2str(ymin)));
   xmaxElement = docNode.createElement('xmax');
   xmaxElement.appendChild(docNode.createTextNode(num2str(xmax)));
   ymaxElement = docNode.createElement('ymax');
   ymaxElement.appendChild(docNode.createTextNode(num2str(ymax)));
   bndboxElement.appendChild(xminElement);
   bndboxElement.appendChild(yminElement);
   bndboxElement.appendChild(xmaxElement);
   bndboxElement.appendChild(ymaxElement);
   objectElement.appendChild(nameElement);
   objectElement.appendChild(poseElement);
   objectElement.appendChild(truncatedElement);
   objectElement.appendChild(difficultElement);
   objectElement.appendChild(bndboxElement);
   docRootNode.appendChild(objectElement);
   
   xmlFileName = [outputDir '/' filename,'.xml'];
   xmlwrite(xmlFileName,docNode);
end