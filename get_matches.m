function [x_1, y_1, x_2, y_2] = get_matches(im1, im2, do_visualization)

	% Return matched x,y locations across the two images. The point defined by (x1,y1) in
	% img1 should correspond to the point defined by (x2,y2) in img2.
    [feats1, x1, y1] = get_feats(im1);
    [feats2, x2, y2] = get_feats(im2);
    disMat = dist2(feats1,feats2);
    
    % FILTER THE FEATURE PAIRS TO GET THE MATCHES
    [val_sorted, index_sorted] = sort(disMat,2);
    ratio = val_sorted(:,1)./val_sorted(:,2);
    loc1 = find(ratio < 0.5);
    loc2 = index_sorted(loc1,1);
    x_1 = x1(loc1);
    y_1 = y1(loc1);
    x_2 = x2(loc2);
    y_2 = y2(loc2);
    
	if do_visualization
		% You must implement this.
		% Display a single figure with the two input images side-by-side.
		% Visualize the features your method has found with some way of showing
		% the corresponding matches.
        matchNum = size(x_1);
        [r,c] = size(im1);
       	figure, imshow([im1 im2]);hold on;
        x_2_2 = x_2 + c;
        for i = 1:matchNum
            line([x_2_2(i) x_1(i)], [y_2(i) y_1(i)])
        end
    end
end

