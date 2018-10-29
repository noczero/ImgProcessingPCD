function [ res ] = myShifting( img , type , shift_val )
%MYSHIFTING Summary of this function goes here
%   Detailed explanation goes here
    
    [rows , cols , w ] = size(img);
    newCol = cols + 10;
    % right
    if(type == '1') 
        result_img(1:rows, 1+shift_val:cols+shift_val,:) = img;
    % left
    elseif (type == '2')
        result_img(1:rows, 1:cols-shift_val,:) = img;
    % up
    elseif (type == '3')
        result_img(1:rows+shift_val , 1:cols,:) = img;
    % down
    elseif (type == '4')
        result_img(1+shift_val:rows+shift_val , 1:cols , :) = img;
    end

    res = result_img;
end

