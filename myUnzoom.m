function [ result ] = myUnzoom( image )
%MYUNZOOM Summary of this function goes here
%   Detailed explanation goes here
[rows cols colormap] =size(image);

    % gray scale
    if (colormap == 1)
        for i = 1:2:rows
            for j = 1:2:cols
                zoom_out_image((i+1)/2,(j+1)/2)=image(i,j);
            end
        end

        result = zoom_out_image;
    else
        red = image(:,:,1);
        blue = image(:,:,2);
        green = image(:,:,3);

        red_layer = [];
        green_layer = [];
        blue_layer = [];

        zoom_out_image = zeros(0.5*rows,0.5*cols, size(image,3), class(image));
        for i = 1:2:rows
            for j = 1:2:cols
                red_layer((i+1)/2,(j+1)/2)=red(i,j);
            end
        end

        for i = 1:2:rows
            for j = 1:2:cols
                green_layer((i+1)/2,(j+1)/2)=green(i,j);
            end
        end

        for i = 1:2:rows
            for j = 1:2:cols
                blue_layer((i+1)/2,(j+1)/2)=blue(i,j);
            end
        end

        zoom_out_image(:,:,1) = red_layer;
        zoom_out_image(:,:,2) = green_layer;
        zoom_out_image(:,:,3) = blue_layer;
        
        result = zoom_out_image;
    end

end

