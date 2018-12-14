function [img_result] = myBlur2(image)
    % MYBLUR2 Summary of this function goes here
    % Gaussian 2d filter, 
    [rows , cols , type] = size(image);
    res_img = zeros(rows,cols, type, class(image));
    %gaussian kernel
    N=5; %must be odd
    sigma=1;
    x=1:N;
    X=exp(-(x-((N+1)/2)).^2/(2*sigma^2));
    h=X'*X;
    h=h./sum(h(:));   
        
    if (type == 3)
        red = image(:,:,1);
        green = image(:,:,2);
        blue = image(:,:,3);
       
        
        % for red
        img_border_red = NaN(rows+N-1,cols+N-1); %add borders
        b=(N-1)/2 +1;
        img_border_red(b:b+rows-1,b:b+cols-1)=red;
        red_layer=zeros(size(red));
        for i = 1:rows
            for j = 1:cols
                red_layer(i,j)=sum(sum(img_border_red(i:i+N-1,j:j+N-1).*h,'omitnan'));
            end
        end
        
        res_img(:,:,1) = red_layer;
        
         % for green
        img_border_green = NaN(rows+N-1,cols+N-1); %add borders
        b=(N-1)/2 +1;
        img_border_green(b:b+rows-1,b:b+cols-1)=green;
        green_layer=zeros(size(green));
        for i = 1:rows
            for j = 1:cols
                green_layer(i,j)=sum(sum(img_border_green(i:i+N-1,j:j+N-1).*h,'omitnan'));
            end
        end
        
        res_img(:,:,2) = green_layer;
        
        % for blue
        img_border_blue = NaN(rows+N-1,cols+N-1); %add borders
        b=(N-1)/2 +1;
        img_border_blue(b:b+rows-1,b:b+cols-1)=blue;
        blue_layer=zeros(size(blue));
        for i = 1:rows
            for j = 1:cols
                blue_layer(i,j)=sum(sum(img_border_blue(i:i+N-1,j:j+N-1).*h,'omitnan'));
            end
        end
        
        res_img(:,:,3) = blue_layer;
        
        img_result = res_img; 
        
    else 
        % just grayscale 
        gray_layer = image;
        img_border = NaN(rows+N-1,cols+N-1); %add borders
        b=(N-1)/2 +1;
        img_border(b:b+rows-1,b:b+cols-1)=gray_layer;
        gray=zeros(size(gray_layer));
        for i = 1:rows
            for j = 1:cols
                gray(i,j)=sum(sum(img_border(i:i+N-1,j:j+N-1).*h,'omitnan'));
            end
        end
        
        img_result = gray;
    end

end