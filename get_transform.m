function [T,a,b] = get_transform(x1, y1, x2, y2)

	% Do RANSAC to determine the best transformation between the matched coordinates
	% provided by (x1,y1,x2,y2).

	% Return the transformation, the number of inliers, and average residual
    num = size(x1,1);
    inlierNum = 0;
    match1 = [x1 y1];
    match2 = [x2 y2];
    % RANSAC!!!
    for it = 1:1000
        % DIRECT LINEAR TRANSFORM
        index = randperm(num,4);
        x_1 = x1(index);
        y_1 = y1(index);
        x_2 = x2(index);
        y_2 = y2(index);
        X = [x_1 y_1 ones([4,1])];
        X2 = [x_2 y_2 ones([4,1])];
        z = zeros([1,3]);
        A = [];
        for j = 1:4
            a = [z X(j,:) -X2(j,2)*X(j,:);
                 X(j,:) z -X2(j,1)*X(j,:)];
            A = [A;a];
        end
        [U, S, V] = svd(A);
        H = reshape(V(:,end),[3,3]);
        % APPLY H TO MATCHED POINTS IN IM1
        T = maketform('projective',H);
        match_1 = tformfwd(T,match1);
        % CALCULATE DISTANCE FOR MAPPED MATCHES AND FILTER FOR INLIERS
        dis = (sum((match_1 - match2).^2,2)).^0.5;
        inliers = dis(dis < 0.1);
        % RECORD MAX INLIERS
        if (size(inliers,1) > inlierNum) 
            inlierNum = size(inliers,1);
            inlierIndex = find(dis < 0.1);
            averageMatchesResidual = sum(dis)/num;
            averageInliersResidual = sum(inliers)/inlierNum;
            bestH = H;
        end
    end
    % CALCULATE BEST H WITH INLIERS
    
    a = [match1(inlierIndex,:),ones([inlierNum,1])];
    b = [match2(inlierIndex,:),ones([inlierNum,1])];
    
    %bestH = a\b
    
    T = maketform('projective',bestH); 

    inlierNum, averageMatchesResidual, averageInliersResidual
end
