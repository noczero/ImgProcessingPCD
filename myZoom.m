function [ result ] = myZoom( image )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

[ rows , cols , colormap ] = size(image);

% check if image is RGB
if(colormap == 3)
    red = image(:,:,1);
    green = image(:,:,2);
    blue = image(:,:,3);
end

count_k = 1;
count_l = 1;

zoom_scale = 2;
grey_tmp = zeros(rows,cols);
red_tmp = zeros(rows,cols);
green_tmp = zeros(rows,cols);
blue_tmp = zeros(rows,cols);
zoom_image = zeros(rows,cols, size(image,3), class(image));

for i=1:rows
    for t=1:zoom_scale
        for j=1:cols
            for t=1:zoom_scale
                
                % check RGB
                if (colormap == 3)
                    red_tmp(count_k,count_l) = red(i,j);
                    green_tmp(count_k,count_l) = green(i,j);
                    blue_tmp(count_k,count_l) = blue(i,j);
                else 
                    grey_tmp(count_k,count_l) = image(i,j);
                end
                count_l = count_l + 1;
            end
        end
        count_l = 1;
        count_k = count_k + 1;
    end
end

if (colormap == 3)
    zoom_image(:,:,1) = red_tmp;
    zoom_image(:,:,2) = green_tmp;
    zoom_image(:,:,3) = blue_tmp;
else
    zoom_image = grey_tmp;
    
end

result = zoom_image;
    
    
                
