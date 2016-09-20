function new_img = stitch_images(I1, I2)

	% Return a new complete image that stitches the two input images together
	% If the two images cannot be stitched together, return 0
    im1 = rgb2gray(im2double(I1));
    im2 = rgb2gray(im2double(I2));
    [x1, y1, x2, y2] = get_matches(im1, im2, 1);
    [T,a,b] = get_transform(x1, y1, x2, y2);
    inlierNum = size(a,1);
    [r,c] = size(im1);
    figure, imshow([im1 im2]);hold on;
    x_1 = a(:,1);
    x_2 = b(:,1);
    x_2_2 = x_2 + c;
    y_1 = a(:,2);
    y_2 = b(:,2);
    for i = 1:inlierNum
        line([x_2_2(i) x_1(i)], [y_2(i) y_1(i)])
    end
    new_img = stitch(I1,I2,T);
    figure;imshow(new_img);
    
end