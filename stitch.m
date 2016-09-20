function [new_img] = stitch(im1, im2, T)

    % BUILD MASK
    [r1, c1, temp] = size(im2);
    [r2, c2, temp] = size(im1);
    mask1 = uint16(ones(r1,c1));
    mask2 = uint16(ones(r2,c2));
    % APPLY T TO im1
    [im1, X, Y] = imtransform(im1, T);
    mask2 = imtransform(mask2, T);
    % CALCULATE FINAL SIZE
    R=max([c1 c2 c1-X(1) c2+X(1)]);
    C=max([r1 r2 r1-Y(1) r2+Y(1)]);
    % CALCULATE TRANSLATION MATRIX
    H1 = eye(3);
    H2 = eye(3);
    if X(1) < 0
        H2(3,1)= abs(X(1));
    elseif X(1) > 0
        H1(3,1)= X(1);
    end
    if Y(1) < 0
        H2(3,2)= abs(Y(1));
    elseif Y(1) > 0
        H1(3,2)= Y(1);
    end
    % DO TRANSLATION
    T1 = maketform('projective',H1);
    T2 = maketform('projective',H2);
    im1 = imtransform(im1, T1, 'XDATA', [1 R], 'YDATA', [1 C]);
    mask2 = imtransform(mask2, T1, 'XDATA', [1 R], 'YDATA', [1 C]);
    im2 = imtransform(im2, T2, 'XDATA', [1 R], 'YDATA', [1 C]);
    mask1 = imtransform(mask1, T2, 'XDATA', [1 R], 'YDATA', [1 C]);
    % STITCHING!!!
    im1mask = uint16(mask2 > mask1);
    im2mask = uint16(mask1 > mask2);
    overlapmask = uint16(repmat(mask1 .* mask2,[1 1 3]));
    im1only = repmat(im1mask,[1 1 3]) .* uint16(im1);
    im2only = repmat(im2mask,[1 1 3]) .* uint16(im2) ;
    overlap = ( overlapmask .* uint16(im2) + overlapmask .* uint16(im1))/2;
    new_img = im1only + im2only + overlap;
    new_img = uint8(new_img);

end
