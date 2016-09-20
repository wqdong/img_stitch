function new_img = stitch_multiple_images(images)

	% Given a set of images in any order, stitch them together into a final panorama
	% Example call: stitch_multiple_images({img1, img2, img3})
    I1 = images{1};
    I2 = images{2};
    I3 = images{3};
    im1 = rgb2gray(im2double(I1));
    im2 = rgb2gray(im2double(I2));
    im3 = rgb2gray(im2double(I3));
    [x12_1, y12_1, x12_2, y12_2] = get_matches(im1, im2, 0);
    [x13_1, y13_1, x13_3, y13_3] = get_matches(im1, im3, 0);
    [x23_2, y23_2, x23_3, y23_3] = get_matches(im2, im3, 0);
    num12 = size(x12_1,1);
    num13 = size(x13_1,1);
    num23 = size(x23_2,1);
    minNum = min([num12 num13 num23]);
    if num12 == minNum
        disp(' IM3 IN THE MIDDLE')
        [x1, y1, x2, y2] = get_matches(im2, im3, 1);
        [x1, y1, x2, y2] = get_matches(im1, im3, 1);
        [T,a,b] = get_transform(x1, y1, x2, y2);
        one = stitch(I1,I3,T);
        figure;imshow(one);
        gray = rgb2gray(im2double(one));
        [x1, y1, x2, y2] = get_matches(im2, gray, 1);
        [T2,a,b] = get_transform(x1, y1, x2, y2);
        new_img = stitch(I2, one,T2);
        figure;imshow(new_img);
        disp('STITCH(I2,STITCH(I1,I3))')
    elseif num13 == minNum
         disp(' IM2 IN THE MIDDLE')
        [x1, y1, x2, y2] = get_matches(im3, im2, 1);

        [x1, y1, x2, y2] = get_matches(im1, im2, 1);
        [T,a,b] = get_transform(x1, y1, x2, y2);
        one = stitch(I1,I2,T);
        figure;imshow(one);
        gray = rgb2gray(im2double(one));
        [x1, y1, x2, y2] = get_matches(im3, gray, 0);
        [T2,a,b] = get_transform(x1, y1, x2, y2);
        new_img = stitch(I3,one,T2);
        figure;imshow(new_img);
        disp('STITCH(I3,STITCH(I1,I2))')
    else
         disp(' IM1 IN THE MIDDLE')
        [x1, y1, x2, y2] = get_matches(im1, im2, 1);
        [x1, y1, x2, y2] = get_matches(im1, im3, 1);
        [T,a,b] = get_transform(x1, y1, x2, y2);
        one = stitch(I3,I1,T);
        figure;imshow(one);
        gray = rgb2gray(im2double(one));
        [x1, y1, x2, y2] = get_matches(im2, gray, 1);
        [T2,a,b] = get_transform(x1, y1, x2, y2);
        new_img = stitch(I2,one,T2);
        figure;imshow(new_img);
        disp('STITCH(I2,STITCH(I3,I1))')
    end
    
end