function [ gray_result ] = myGrayScale( myImg , prob_R , prob_G , prob_B )
% this function is to change image from 3 Layer RGB for just one layer
% named gray scale, for fasting computing in image processing
%   image contains the imread() result
%   prob_R is for how many value we needed for RED, higher values means we
%   want more detil
%   prob_G is for how many value we needed for green, higher values means we
%   want more detil
%   prob_B is for how many value we needed for blue, higher values means we
%   want more detil
% sum of three params must 1. for example 0.5,0.4,0.1 or same at all
% 0.33,0.33,0.33
    red = myImg(:,:,1);
    blue = myImg(:,:,2);
    green = myImg(:,:,3);
    
    gray_result = prob_R*red + prob_B*blue + prob_G*green;
    %%imshow(grayLayer);
    
end

