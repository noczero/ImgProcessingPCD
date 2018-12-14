function [ result ] = myRegionGrowth( image, x , y , threshold )
    %   myRegionGrowth allows to segmentation by growing the seed
    %   input : image (grayscale) , x , y (position) , threshold (+-
    %   threhold)

    [rows , cols] = size(image);
    
    black_layer = false(rows,cols);
    dup_black = black_layer;
    black_layer(uint8(x),uint8(y)) = 1;
    % itreate until if no new pixel added
    while(sum(black_layer(:)) ~= sum(dup_black(:)))
        dup_black = black_layer;
        % Evaluate image intensity at seed/line points
        current_value = image(black_layer);
        % Calculate mean intensity at seed/line points
        calculate_val = mean(current_value);
        % Grow seed 1 pixel, and remove previous seed (so you'll get only new pixel perimeter)
        process_seed = imdilate(black_layer,strel('disk',1,0)) - black_layer;
        % Evaluate image intensity over the new perimeter
        new_seed = find(process_seed);
        new_perimeter = image(new_seed);
        
        % If image intensity over new perimeter is greater than the mean intensity of previous perimeter (minus tolerance), than this perimeter is part of the segmented object
        black_layer(new_seed(new_perimeter > calculate_val - threshold  & new_perimeter < calculate_val + threshold )) = 1;
        % Repeat while there's new pixel in seed, stop if no new pixel were added

    end
    
    result = black_layer;

end

