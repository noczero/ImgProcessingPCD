function [ result_img ] = myEdgeDetection( image )
%   myEdgeDetection Summary of this function goes here
%   Detailed explanation goes here
    [rows , cols , type] = size(image);
    res_img = zeros(rows,cols, type, class(image));
    
     % RGB
     if (type == 3)
        B=myGrayScale(image,0.33,0.33,0.33);
        I=double(B);

        for i=1:size(I,1)-2
            for j=1:size(I,2)-2
            %Sobel mask for x-direction:
            mx=((2*I(i+2,j+1)+I(i+2,j)+I(i+2,j+2))-(2*I(i,j+1)+I(i,j)+I(i,j+2)));
            %Sobel mask for y-direction:
            my=((2*I(i+1,j+2)+I(i,j+2)+I(i+2,j+2))-(2*I(i+1,j)+I(i,j)+I(i+2,j)));

            B(i,j)=sqrt(mx.^2+my.^2);
            end
        end

        Thresh=100;
        B=max(B,Thresh);
        B(B==round(Thresh))=0;
        B=uint8(B);
        
        result_img = B;
     else
        % gray scale
         B = image;
         I=double(B);

        for i=1:size(I,1)-2
            for j=1:size(I,2)-2
            %Sobel mask for x-direction:
            mx=((2*I(i+2,j+1)+I(i+2,j)+I(i+2,j+2))-(2*I(i,j+1)+I(i,j)+I(i,j+2)));
            %Sobel mask for y-direction:
            my=((2*I(i+1,j+2)+I(i,j+2)+I(i+2,j+2))-(2*I(i+1,j)+I(i,j)+I(i+2,j)));

            B(i,j)=sqrt(mx.^2+my.^2);
            end
        end

        Thresh=100;
        B=max(B,Thresh);
        B(B==round(Thresh))=0;
        B=uint8(B);
        
        result_img = B;
         
     end

end

