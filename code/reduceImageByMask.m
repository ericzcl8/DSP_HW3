function imageReduced = reduceImageByMask( image, seamMask, isVertical )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Removes pixels by input mask
% Removes vertical line if isVertical == 1, otherwise horizontal
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if (isVertical)
        imageReduced = reduceImageByMaskVertical(image, seamMask);
    else
        imageReduced = reduceImageByMaskHorizontal(image, seamMask');
    end;
end

function imageReduced = reduceImageByMaskVertical(image, seamMask)
    % Note that the type of the mask is logical and you 
    % can make use of this.
    
    %%%%%%%%%%%%%%%%%%
    % YOUR CODE HERE:
    %%%%%%%%%%%%%%%%%%
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
    %%%%%%%%%%%%%%%%%%
    % END OF YOUR CODE
    %%%%%%%%%%%%%%%%%%
end

function imageReduced = reduceImageByMaskHorizontal(image, seamMask)
    %%%%%%%%%%%%%%%%%%
    % YOUR CODE HERE:
    %%%%%%%%%%%%%%%%%%
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
    %%%%%%%%%%%%%%%%%%
    % END OF YOUR CODE
    %%%%%%%%%%%%%%%%%%
end
