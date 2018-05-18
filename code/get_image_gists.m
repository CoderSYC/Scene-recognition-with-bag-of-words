function gist = get_image_gists(image_paths)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

clear param
param.imageSize = [256 256]; % set a normalized image size
param.orientationsPerScale = [8 8 8 8]; % number of orientations per scale (from HF to LF)
param.numberBlocks = 4;
param.fc_prefilt = 4;

% Pre-allocate gist:
Nfeatures = sum(param.orientationsPerScale)*param.numberBlocks^2;
gist = zeros([size(image_paths, 1) Nfeatures]); 

% Load first image and compute gist:

img = imresize(imread(image_paths{1}), param.imageSize);
[gist(1, :), param] = LMgist(img, '', param); % first call
% Loop:
for i = 2:size(image_paths, 1)
   img = imresize(imread(image_paths{i}),param.imageSize);
   gist(i, :) = LMgist(img, '', param); % the next calls will be faster
end

end

