# 翁啟文 <span style="color:red">(103061112)</span>

# HW3 / Seam Carving for Content-Aware Image Resizing

## Overview
The project is related to Seam carving algorithm. It is a method of image resizing to allow a resized image maintains more important features of the original image.  


## Implementation
1. In energyRGB.m:  
  First of all, we have to convert a source image to energy function (gradient map). So we simply add up pixel values of three channel, and apply gradient filters used in the previous lab. After that, we sum up Ix and Iy to get the energy gradient map of the source image.
  ```Matlab
  function res = energyRGB(I)
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % Sum up the enery for each channel 
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  dx = [-1 0 1; -1 0 1; -1 0 1]; % horizontal gradient filter 
  dy = dx'; % vertical gradient filter
  Ix = imfilter(I, dx);
  Iy = imfilter(I, dy);
  res = abs(Ix(:,:,1))+abs(Ix(:,:,2))+abs(Ix(:,:,3))+abs(Iy(:,:,1))+abs(Iy(:,:,2))+abs(Iy(:,:,3)); 
  end
  ```
  2. In findOptSeam.m:  
  Having an energy gradient map, now we are going to find out the Optimal seam, which is composed of those pixels that are not relatively important. So we choose a path from the top to the bottom of the energy gradient map where the summation of this path is smallest. Before the action, we have to pad a large value (max "double-type" value) on both sides of the energy gradient map to avoid exceeding the matrix dimension during calculating. Use double for-loop to finish the task.
  ```Matlab
  M = padarray(energy, [0 1], realmax('double'));
  sz = size(M);
  for i = 2 : sz(1)
      for j = 2 : sz(2)-1
          M(i,j) = M(i,j) + min(M(i-1, j-1), min(M(i-1, j), M(i-1, j+1)));
      end
  end
  ```
  Next, we choose the smallest value in the bottom row of M as a start point, and find the path to go back the top row of the M from the bottom. Note that the number of M's column is bigger than the source image by two since we pads 1 column of MAX on the both side of the source image. Finally, we get a mask for futher use.
  ```Matlab
    seamEnergy_temp = seamEnergy;
    idx_temp = idx;
    for k = sz(1) :-1: 1
        if M(k ,idx_temp-1)==seamEnergy_temp
            idx_temp = idx_temp - 1;
        elseif M(k ,idx_temp)==seamEnergy_temp
            idx_temp = idx_temp;
        else
            idx_temp = idx_temp + 1;
        end
        optSeamMask(k , idx_temp-1) = 1;   //idx_temp is subtracted by 1.
        seamEnergy_temp = seamEnergy_temp - energy( k ,idx_temp-1);
    end
    optSeamMask = ~optSeamMask;  //Mask
  ```
  3. In reduceImageByMask.m:
    We delete unwanted pixels in the source image according to the mask obtained at previous step. There are some elements equal to 1 in the optSeamMask, which means these locations in the source image will be removed. Finally, we squeeze out these empty elements horizontally or vertically, depending on the type of the optimal seam (vertical seam or horizontal seam).
    ```Matlab
    %%For vertical seam removing
    imageReduced_r = (image(:,:,1))';
    imageReduced_g = (image(:,:,2))';
    imageReduced_b = (image(:,:,3))';
    imageReduced_r(seamMask'==0) = [];
    imageReduced_g(seamMask'==0) = [];
    imageReduced_b(seamMask'==0) = [];
    nrow = size(image, 1);
    ncol = size(image, 2)-1;
    imageReduced_r_a = (reshape(imageReduced_r,ncol,nrow))';
    imageReduced_g_a = (reshape(imageReduced_g,ncol,nrow))';
    imageReduced_b_a = (reshape(imageReduced_b,ncol,nrow))';
    imageReduced (:,:,1) = imageReduced_r_a;
    imageReduced (:,:,2) = imageReduced_g_a;
    imageReduced (:,:,3) = imageReduced_b_a;
    
    
    
    %%For vertical seam removing
    imageReduced_r = (image(:,:,1));
    imageReduced_g = (image(:,:,2));
    imageReduced_b = (image(:,:,3));
    imageReduced_r(seamMask==0) = [];
    imageReduced_g(seamMask==0) = [];
    imageReduced_b(seamMask==0) = [];   
    nrow = size(image, 1)-1;
    ncol = size(image, 2);
    imageReduced_r_a = reshape(imageReduced_r,nrow,ncol);
    imageReduced_g_a = reshape(imageReduced_g,nrow,ncol);
    imageReduced_b_a = reshape(imageReduced_b,nrow,ncol);
    imageReduced (:,:,1) = imageReduced_r_a;
    imageReduced (:,:,2) = imageReduced_g_a;
    imageReduced (:,:,3) = imageReduced_b_a;
    ```
### Results: 
