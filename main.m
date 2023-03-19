img1 = imread('Test Images/123.jpg');
img2 = imresize(img1, [584 565]);
img3 = im2double(img2);
img4 = rgb2lab(img3);
fill = cat(3, 1,0,0);
img5 = bsxfun(@times, fill, img4);
img6 = reshape(img5, [], 3);
[C, S] = pca(img6);
S = reshape(S, size(img4));
S = S(:, :, 1);
grayimg = (S-min(S(:)))./(max(S(:))-min(S(:)));
imgenhance = adapthisteq(grayimg, 'numTiles', [8 8], 'nBins', 128);
filteravg = fspecial('average', [9 9]);
filtercoffee = imfilter(imgenhance, filteravg);
figure, imshow(filtercoffee)
title('Filtered Image')
subimage = imsubtract(filtercoffee,imgenhance);

level = Threshold_Level(subimage);

Binary_Image = im2bw(subimage, level-0.008);
figure, imshow(Binary_Image)
title('Binary Image')

Resultant_Image = bwareaopen(Binary_Image, 100);
figure, imshow(Resultant_Image)
title('Final Image')




