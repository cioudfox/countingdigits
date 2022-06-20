% Name: Jason Wu 
% Date: 3/12/22
% MyCentroid function utilized in Part 1: Task 1 & Task 2 of the assignment
% Details:
% Takes n x 784 matrix A of digits {test0,...,test9} and 10 x 784 test 
% matrix for average digits as input.
% Returns n x 1 vector which contains the label for the test digit in A.
% ITS A FUNCTION, IT WILL BE OVERWRITTEN BY VARIABLES IN MAIN. MAKE
% SURE YOU KEEP THEM AS TEMP AND THEN TRANSFER THEM.

function [o] = mycentroid(test,avg)
    % Generate starting matrix
    o = zeros(height(test),1);

    % Use given Centroid formula
    for i = 1:height(test)
        z = double(test(i,:)); 
        dist = zeros(10,1); 
        for k=1:10
            dist(k) = norm( z - avg(k,:) );
        end

    % Calculate Index Values
    [~,temp] = min(dist(:));
    o(i,1) = temp - 1;
    end
end
