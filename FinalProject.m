%% Counting Digits Project
% Using the MNIST databset of handwritten digits --
% by Yann LeCun (NYU), Corinna Cortes (Google), and
% Chris J. C. Burges (Microsoft Research)  

clear;
load mnistdata;  

%%
% The data is separated into two categories: train and test.
% Each category contains 10 sets of digits from 0-9.  
% Each row vector of length 784 is a 28-by-28 image.
%

%whos('-file','mnistdata.mat')

%% DEBUGGING Display for MNISTdata
figure(1) 
m = 6;  % display the selected train/test digits in an m x m array
for i = 1:m*m 

   digit = train8(i,:);
   %digit = test8(i,:);

   digitImage = reshape(digit,28,28);

   subplot(m,m,i); 
   image(rot90(flipud(digitImage),-1)); 
   colormap(gray(256)); 
   axis square tight off; 

end 

%% 
% The figure above shows different instances of digit 8 in the 
% data matrix 'train8'.
%

%%
% Now let us compute the averages (``centroid'') of train digits
%

T(1,:) = mean(train0); 
T(2,:) = mean(train1); 
T(3,:) = mean(train2); 
T(4,:) = mean(train3); 
T(5,:) = mean(train4); 
T(6,:) = mean(train5); 
T(7,:) = mean(train6); 
T(8,:) = mean(train7); 
T(9,:) = mean(train8); 
T(10,:) = mean(train9); 

%% 
% Here is a way to visualize the averages of train digits
%

for i = 1:10 
    digitImage_mean(:,:,i) = reshape(T(i,:),28,28);
end 

%figure(2) 
for i = 1:10 
    subplot(2,5,i) 
    image(rot90(flipud(digitImage_mean(:,:,i)),-1)); 
    colormap(gray(256)); 
    axis square tight off; 
end

%%
% The above figure shows the averages of 0, 1, ..., 9 digits.
%

%% Objectives 
%
% In this project, we investigate two algorithms to classify digits: 
% the centroid algorithm and the PCA algorithm.
%

%% Centroid Algorithm

[y] = mycentroid(test0,T);
fprintf("Calling y = mycentroid(test0,T). Printing out size(y)");
disp(size(y));
% Local function test. Located on bottom of page
%[c] = centobj(test0,T);

%% Result table for centroid algorithm
centresult = (1:10)';
for i = 1:10
    s = strcat('test',num2str(i-1));
    temp = mycentroid(eval(s),T);
    centresult(i) = (sum(temp(:) == i-1) / height(eval(s))) * 100;
end

c = table((0:9)',round(centresult,1));
c.Properties.VariableNames = {'Digit','Success Rate'};
disp(c);

% sum(c(:) == 0)

%% The PCA Algorithm

%viewdigit(U3(:,1)) 

%viewdigit(U3(:,2)) 

%% 
% Following the above description, we can compute basis vectors for 
% principal feature of all digits 0 to 9 as follows: 

%basis_length = 1;   % the number $m$ of basis vectors 
%Us = zeros( 28*28, basis_length, 10);
%for k=1:10
    %
    % go through each digit 0 to 9
    % 
    %s = strcat('train',num2str(k-1));
    %A = double(eval(s));
    %  
    % get first 5 singular vector
    % 
    %[U,~,~] = svds( A', basis_length );
    %Us(:,:,k)=U;   % store the basis vectors of digit ``k-1''. 
%end

%z = double(test4(14,:))';  %  select a test digit
%dist = zeros(10,1); 
%for k=1:10
%    Uk = Us(:,:,k); 
%    dist(k) = norm( z - Uk*(Uk'*z) );
%end
%dist

%Run tests for 1,5,10,20.
tempsc = (1:10)';

%Debug values check.
%sc1 = (1:10)';
%sc2 = (1:10)';
%sc3 = (1:10)';
%sc4 = (1:10)';

%Run loop 4 times to capture m = 1,5,10,20
for i = 1:4
    %If i == 1, keep. Else, multiply by 5 * (i-1) or 5 if 4. 
    if i == 1
        basis_length = i;
    elseif i == 4
        basis_length = i * 5;
    else
        basis_length = (i-1)*5;
    end

    %Calculate the new Us variable with m
    Us = zeros( 28*28, basis_length, 10);
    for k=1:10
        s = strcat('train',num2str(k-1));
        A = double(eval(s));
        [U,~,~] = svds( A', basis_length );
        Us(:,:,k)=U;  
    end

    %Calculate the digits for each size m
    for j = 1:10
        s = strcat('test',num2str(j-1));
        temp = mypca(eval(s),Us);
        tempsc(j) = (sum(temp(:) == j-1) / height(eval(s))) * 100;
    end

    %Find and move SC values to temporary storage
    if basis_length == 1
        sc1 = tempsc;
    elseif basis_length == 5
        sc2 = tempsc;
    elseif basis_length == 10
        sc3 = tempsc;
    else
        sc4 = tempsc;
    end
end


%% Result table for PCA algorithm
d = table((0:9)',round(sc1,1),round(sc2,1),round(sc3,1),round(sc4,1));
d.Properties.VariableNames = {'Digit','Success Rate m = 1','Success Rate m = 5','Success Rate m = 10','Success Rate m = 20'};
disp(d);

%% Local Debugging function for myPCA
%function o = pcaobj(test,avg)
%    o = zeros(height(test),1);
%    for i = 1:height(test)
%        z = double(test(i,:))';  %  select a test digit
%        dist = zeros(10,1); 
%        for k=1:10
%            Uk = avg(:,:,k); 
%            dist(k) = norm( z - Uk*(Uk'*z) );
%        end
%        [~,ta] = min(dist(:));
%        o(i,1) = ta - 1;
%    end
%end

%% Local Debugging function for myCentroid
%function o = centobj(test,avg)
    %o = zeros(height(test),1);
    %for i = 1:height(test)
        %z = double(test(i,:)); 
        %dist = zeros(10,1); 
        %for k=1:10
            %dist(k) = norm( z - avg(k,:) );
        %end
    %[~,ta] = min(dist(:));
    %o(i,1) = ta - 1;
    %end
%end