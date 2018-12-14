function [ result ] = myHistogram( img )
%MYHISTOGRAM Summary of this function goes here
% input RGB image
% output count of each value on RGB
result = zeros(3,256); % create array 3 element

% iterate for RGB
for layer = 1 : 3
    % iterate for index
    for idx = 1 : 256
        % save count to its index
        result(layer,idx) = nnz(img(:,:,layer) == idx-1);
    end
end

end

