function [ I ] = preProc( input )
%preProc smoothes the image
%   This function applies a circular averaging filter to the image

global parameter;

filter = fspecial('disk', parameter.diskFilterRadius);
I = imfilter(input, filter);

if parameter.showBlurredImage
    figure, imshow(I);
    title('Blurred image');
end

if parameter.showBlurredImageHistogram
    figure, imhist(I);
    title('Histogram of Blurred Image');
end

end