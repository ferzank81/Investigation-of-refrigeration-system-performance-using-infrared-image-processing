%NOTE:

%Please perform the following steps in order

%-----------------------------------------------------------
% 1. Select the thermal image you will work with by pressing the "Görüntü Aç" button.
% 2. Enter the "ALT" lower and "ÜST" upper values (tempuratures) written in the thermal image into the relevant text boxes.
% 3. After pressing the "Kes" button, click your mouse twice to determine the area you will work on.
% 4. Enter the segmentation number in the two text boxes and click the "Bölütleme" button.
% 5. After entering the Segmentation numbers to be analyzed, click the "Analize Baþla" button.
%------------------------------------------------------------

% For more descriptive and theoretical information, you can review the article below.

% KATIRCIOÐLU, F., CÝNGÝZ, Z., Yusuf, Ç. A. Y., GÜREL, A. E., SARIDEMÝR, S., & KOLÝP,A. (2020)
% R22 ve Alternatifleri R438A ile R417A Soðutucu Akýþkanlarý için Kýzýlötesi Görüntü Ýþleme Teknikleri Kullanarak, 
% Soðutma Sistem Performansýnýn Ýncelenmesi. Academic Platform Journal of Engineering and Science, 8(3), 500-513.

function [thermalImage] = sicaklik(image, alt, ust)

%===============================================================================
% Read in a demo image.
originalRGBImage = image;
grayImage = min(originalRGBImage, [], 3); % Useful for finding image and color map regions of image.

%=========================================================================================================
% Need to crop out the image and the color bar separately.
% Crop off the surrounding clutter to get the RGB image.
rgbImage = originalRGBImage;
% imcrop(originalRGBImage, [20, 40, 441, 259]);

% Next, crop out the colorbar.
colorBarRow1 = 31;
colorBarRow2 = 211;
colorBarCol1 = 307;
colorBarCol2 = 314;
% Crop off the surrounding clutter to get the colorbar.
colorBarImage = originalRGBImage(colorBarRow1 : colorBarRow2, colorBarCol1 : colorBarCol2, :);
b = colorBarImage(:,:,3);
% figure, imshow(colorBarImage);
%=========================================================================================================
% Get the color map from the color bar image.
storedColorMap = colorBarImage(:,1,:);
% Need to call squeeze to get it from a 3D matrix to a 2-D matrix.
% Also need to divide by 255 since colormap values must be between 0 and 1.
storedColorMap = double(squeeze(storedColorMap)) / 255;
% Need to flip up/down because the low rows are the high temperatures, not the low temperatures.
storedColorMap = flipud(storedColorMap);
% Convert the subject/sample from a pseudocolored RGB image to a grayscale, indexed image.
indexedImage = rgb2ind(rgbImage, storedColorMap);
%=========================================================================================================
% Now we need to define the temperatures at the end of the colored temperature scale.
% You can read these off of the image, since we can't figure them out without doing OCR on the image.
% Define the temperature at the top end of the scale.
% This will probably be the high temperature.
highTemp = ust;
% Define the temperature at the dark end of the scale
% This will probably be the low temperature.
lowTemp = alt;

% Scale the indexed gray scale image so that it's actual temperatures in degrees C instead of in gray scale indexes.
thermalImage = lowTemp + (highTemp - lowTemp) * mat2gray(indexedImage);
%=========================================================================================================
end


