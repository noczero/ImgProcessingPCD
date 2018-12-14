function [ result_image] = myBlur( img )
%MYBLUR Summary of this function goes here
%   Detailed explanation goes here

    [ rows, cols] = size(img);
    res_img = zeros(rows,cols);
    res_img = img;
    for i=4:rows-4
       for j=4:cols-4
           sum = 0;
           for k=-3:4
             for l=-3:4
                 a = img(i+k, j+l);
                 sum = sum + a;
             end           
           end
           b = sum / 49;
           res_img(i,j) = b;
       end
    end
    
    result_image = res_img;

end

