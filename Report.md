# 翁啟文 <span style="color:red">(103061112)</span>

# HW3 / Seam Carving for Content-Aware Image Resizing

## Overview
The project is related to Seam carving algorithm. It is a method of image resizing to allow a resized image maintains more important features of the original image.  


## Implementation
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
  Having an energy gradient map, now we are going to find out the seam, which is composed of those pixels that are not relatively important. So we choose a path from the top to the bottom of the energy gradient map where the summation of this path is smallest. Before the action, we have to pad a large value (max "double-type" value) on both sides of the energy gradient map to avoid exceeding the matrix dimension during calculating. Use double for-loop to finish the task.
  ```Matlab
  M = padarray(energy, [0 1], realmax('double'));
  sz = size(M);
  %%%%%%%%%%%%%%%%%%
  % YOUR CODE HERE:
  %%%%%%%%%%%%%%%%%%
  for i = 2 : sz(1)
      for j = 2 : sz(2)-1
          M(i,j) = M(i,j) + min(M(i-1, j-1), min(M(i-1, j), M(i-1, j+1)));
      end
  end
  ```
### Results: 
