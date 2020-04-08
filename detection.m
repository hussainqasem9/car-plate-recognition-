close all;
clear;
clc
[file,path]=uigetfile({'*.jpg;*.bmp;*.png;*.tif'},'Choose an image');
s=[path,file];
im=imread(s);
figure;
imshow(im);
im = imresize(im, [480 NaN]);
imgray = rgb2gray(im);



im = edge(imgray, 'sobel');
figure;
imshow(im);



im = imdilate(im, strel('diamond', 2));
figure;
imshow(im);
im = imfill(im, 'holes');
% figure;
imshow(im);
im = imerode(im, strel('diamond',9));
figure;
imshow(im);

Iprops=regionprops(im,'BoundingBox','Area', 'Image');
area = Iprops.Area;
count = numel(Iprops);
maxa= area;
boundingBox = Iprops.BoundingBox;
for i=1:count
   if maxa<Iprops(i).Area
       maxa=Iprops(i).Area;
       boundingBox=Iprops(i).BoundingBox;
   end
end 


%all above step are to find location of number plate
imbin = imbinarize(imgray);
im = imcrop(imbin, boundingBox);
figure;
imshow(im);


%resize number plate to 240 NaN
im = imresize(im, [200 NaN]);
  
    
   

%filter binary image  hussain qasem
%removes all connected components (objects) that have fewer than 50 pixels
im = bwareaopen(~im,50);
figure;
imshow(im);
    
% Perform a morphological close operation on the image   
im = imclose(im,ones(5)); 
figure;
imshow(im);




Iprops=regionprops(im,'BoundingBox','Area', 'Image');
count = numel(Iprops);
boundingBox = Iprops.BoundingBox;
for i=1:count
  
        boundingBox=Iprops(i).BoundingBox;
          im1= imcrop(im, boundingBox);
          im1 = imresize(im1, [100 NaN]);
          figure;
          imshow(im1);
    
     
end 

