function result = myZoom2(image)

[rows cols colormap] = size(image);
zooms = 2;

if (colormap == 3)
    zoom_image = zeros(2*rows,2*cols, size(image,3), class(image));
    red = image(:,:,1);
    blue = image(:,:,2);
    green = image(:,:,3);
    
    c_blue = [];
    d_blue = [];

    c_red = [];
    d_red = [];

    c_green = [];
    d_green = [];

    % for blue
    for row=1:rows
        for zoom=1:zooms
           c_blue = [c_blue ; blue(row,:)]; 
         end
    end

    for col=1:cols
        for zoom=1:zooms
            d_blue = [d_blue , c_blue(:,col)];
        end
    end

    % for green
    for row=1:rows
        for zoom=1:zooms
           c_green = [c_green ; green(row,:)]; 
         end
    end

    for col=1:cols
        for zoom=1:zooms
            d_green = [d_green , c_green(:,col)];
        end
    end

    % for red
    for row=1:rows
        for zoom=1:zooms
           c_red = [c_red ; red(row,:)]; 
         end
    end

    for col=1:cols
        for zoom=1:zooms
            d_red = [d_red , c_red(:,col)];
        end
    end

    zoom_image(:,:,1) = d_red;
    zoom_image(:,:,2) = d_green;
    zoom_image(:,:,3) = d_blue;
    
    result = zoom_image;
else
    c_grey = [];
    d_grey = [];

    % for blue
    for row=1:rows
        for zoom=1:zooms
           c_grey = [c_grey ; image(row,:)]; 
         end
    end

    for col=1:cols
        for zoom=1:zooms
            d_grey = [d_grey , c_grey(:,col)];
        end
    end
    
    result = d_grey;
end
 
end
