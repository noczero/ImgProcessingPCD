function [ result ] = myThreshold( image , threshold , replace)
    %   this function allows to segmentation image by a threshold
    %   input : image (gray scale), threshold, and replace (threshold to
    %   replace)

    [ rows , cols , type] = size(image);
    
    result = image;
    % check grayscale
    if (type == 1)
        % itreate over image
        for i=1:rows
            for j=1:cols
                % check current value bigger then threshold
                if (image(i,j) > threshold) 
                    result(i,j) = replace;
                else
                    result(i,j) = 0; %replace with black
                end
            end
        end
    else
        disp('Convert to grayscale');
    end
end

