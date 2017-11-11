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

