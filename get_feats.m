function [feats, x, y] = get_feats(im)

	% Return an N x M matrix of features, along with the corresponding x,y
	% locations of the detected features.

	% N and M both depend on what method of feature detection you choose to use.
	% N = number of features found
	% M = feature vector length
    
    [cim, y, x] = harris(im, 1, 0.05, 2, 0);
    numCorner = size(x);
    corners = [x, y, zeros([numCorner,1])];
    corners(:,3) = 2;
    feats = find_sift(im, corners, 1.5);
    
end
