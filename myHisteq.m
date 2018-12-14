function [ result ] = myHisteq( img , range )
%MYHISTEQ Summary of this function goes here
%   Detailed explanation goes here

% init image
[rows , cols , type] = size(img);
result = zeros(rows,cols, type, class(img));

% calculate distance between max - min for each layer
max_red = max(max(img(:,:,1)));
min_red = min(min(img(:,:,1)));
dist_red = max_red - min_red;

max_green = max(max(img(:,:,2)));
min_green = min(min(img(:,:,2)));
dist_green = max_green - min_green;

max_blue = max(max(img(:,:,3)));
min_blue = min(min(img(:,:,3)));
dist_blue = max_blue - min_blue;

% using comparision divided range and dist
comp_red = range / double(dist_red)
comp_green = range / double(dist_green)
comp_blue = range / double(dist_blue)

% dot product the matrix
layer_red = comp_red * img(:,:,1);
layer_green = comp_green * img(:,:,2);
layer_blue = comp_blue * img(:,:,3);

% assign each layer to result
result(:,:,1) = layer_red;
result(:,:,2) = layer_green;
result(:,:,3) = layer_blue;

end

