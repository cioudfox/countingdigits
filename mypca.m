% Name: Jason Wu 
% Date: 3/12/22
% MyPCA function utilized in Part 2: Task 3 & Task 4 of the assignment
% Details:
% Takes n x 784 matrix A of digits {test0,...,test9} and 10 x m x 784 test 
% matrix for average digits as input.
% Returns n x 1 vector which contains the label for the test digit in A.

function [o] = mypca(test,avg)
    % Generate starting matrix
    o = zeros(height(test),1);

    % Use given PCA formula
    for i = 1:height(test)
        z = double(test(i,:))';  %  select a test digit
        dist = zeros(10,1); 
        for k=1:10
            Uk = avg(:,:,k); 
            dist(k) = norm( z - Uk*(Uk'*z) );
        end

        %Calculate index value
        [~,temp] = min(dist(:));
        o(i,1) = temp - 1;
    end
end
