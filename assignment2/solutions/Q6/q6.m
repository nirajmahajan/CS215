clear;clc;
first = imread('T1.jpg');
second = imread('T2.jpg');
first = double(first);
second = double(second);

[rows, columns] = size(first);

corr = [];
qmi = [];

for tx = -10:10
    b = second;
    qmi_calc = zeros(26);
    marg1_calc = zeros(1,26);
    marg2_calc = zeros(1,26);
    
    % shift b
    for i = columns:-1:1
        if((i - tx) > columns || (i - tx) <=0)
            b(:,i) = 0;
        else
            b(:, i) = second(:, (i-tx));
        end
    end    
        
    % create individual values
    for row_iter = 1:rows
        for column_iter = 1:columns
            x_coeff = 1+floor(first(row_iter, column_iter)/10);
            y_coeff = 1+floor(b(row_iter, column_iter)/10);
            qmi_calc(x_coeff, y_coeff) = qmi_calc(x_coeff, y_coeff) + 1;
        end
    end
    
    qmi_calc = qmi_calc / sum(sum(qmi_calc));
        
    % create the marginal histograms
    for iter = 1:26
        marg1_calc(1,iter) = sum(qmi_calc(iter, :));
        marg2_calc(1,iter) = sum(qmi_calc(:, iter));
    end
    
    marg1_calc = marg1_calc / sum(sum(marg1_calc));
    marg2_calc = marg2_calc / sum(sum(marg2_calc));
    stack = 0;
    
    for i = 1:26
        for j = 1:26
            stack = stack + (qmi_calc(i,j) - marg1_calc(1,i)*marg2_calc(1,j))^2;
        end
    end
    
    qmi = [qmi stack];
    % calculate the correlation coefficient
    mu_first = mean(mean(first));
    mu_b = mean(mean(b));
    num=0;
    den1 = 0;
    den2 = 0;
    for row_iter = 1:rows
        for column_iter = 1:columns
            first_term = (first(row_iter, column_iter) - mu_first);
            b_term = (b(row_iter, column_iter) - mu_b);
            num = num + (first_term * b_term);
            den1 = den1 + (first_term^2);
            den2 = den2 + (b_term^2);
        end
    end
    temp = num / (sqrt(den1*den2));
    corr = [corr, temp];
end

figure(1);
plot(-10:10, corr);
title('Q6 - Correlation Coefficient');
xlabel('shift (tx)');
ylabel('Correlation Coefficient');

figure(2);
plot(-10:10, qmi);
title('Q6 - Quadratic Mutual Information');
xlabel('shift (tx)');
ylabel('QMI');




% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% negative!!



clear;clc;
first = imread('T1.jpg');
first = double(first);
second = 255-first;

[rows, columns] = size(first);

corr = [];
qmi = [];

for tx = -10:10
    b = second;
    qmi_calc = zeros(26);
    marg1_calc = zeros(1,26);
    marg2_calc = zeros(1,26);
    
    % shift b
    for i = columns:-1:1
        if((i - tx) > columns || (i - tx) <=0)
            b(:,i) = 0;
        else
            b(:, i) = second(:, (i-tx));
        end
    end    
        
    % create individual values
    for row_iter = 1:rows
        for column_iter = 1:columns
            x_coeff = 1+floor(first(row_iter, column_iter)/10);
            y_coeff = 1+floor(b(row_iter, column_iter)/10);
            qmi_calc(x_coeff, y_coeff) = qmi_calc(x_coeff, y_coeff) + 1;
        end
    end
    
    qmi_calc = qmi_calc / sum(sum(qmi_calc));
        
    % create the marginal histograms
    for iter = 1:26
        marg1_calc(1,iter) = sum(qmi_calc(iter, :));
        marg2_calc(1,iter) = sum(qmi_calc(:, iter));
    end
    
    marg1_calc = marg1_calc / sum(sum(marg1_calc));
    marg2_calc = marg2_calc / sum(sum(marg2_calc));
    stack = 0;
    
    for i = 1:26
        for j = 1:26
            stack = stack + (qmi_calc(i,j) - marg1_calc(1,i)*marg2_calc(1,j))^2;
        end
    end
    
    qmi = [qmi stack];
    % calculate the correlation coefficient
    mu_first = mean(mean(first));
    mu_b = mean(mean(b));
    num=0;
    den1 = 0;
    den2 = 0;
    for row_iter = 1:rows
        for column_iter = 1:columns
            first_term = (first(row_iter, column_iter) - mu_first);
            b_term = (b(row_iter, column_iter) - mu_b);
            num = num + (first_term * b_term);
            den1 = den1 + (first_term^2);
            den2 = den2 + (b_term^2);
        end
    end
    temp = num / (sqrt(den1*den2));
    corr = [corr, temp];
end

figure(3);
plot(-10:10, corr);
title('Q6 - Correlation Coefficient (Negative)');
xlabel('shift (tx)');
ylabel('Correlation Coefficient');

figure(4);
plot(-10:10, qmi);
title('Q6 - Quadratic Mutual Information (Negative)');
xlabel('shift (tx)');
ylabel('QMI');