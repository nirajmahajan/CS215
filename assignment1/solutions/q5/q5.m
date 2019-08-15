clear;clc;
x = [-3:0.02:3];
y = 5*sin(2.2*x + pi/3);
z=y;
to_corrupt = randperm(length(y), round(0.3*length(y)));

for elem = to_corrupt
    z(1,elem) = y(1,elem) + 100 + 20*(rand);
end

% Now Filtering wrt median
y_median=y;
n=length(y);
for elem = 1:n
    if(elem <= 8 && n-elem <= 8)
        y_median(1,elem) = median(z);
    elseif(elem <= 8)
        y_median(1,elem) = median(z(:,1:elem + 8));
    elseif(n-elem <= 8)
        y_median(1,elem) = median(z(:,(elem - 8):end));
    else
        y_median(1,elem) = median(z(:,(elem - 8):(elem + 8)));
    end
end

% Now Filtering wrt mean
y_mean=y;
n=length(y);
for elem = 1:n
    if(elem <= 8 && n-elem <= 8)
        y_mean(1,elem) = mean(z);
    elseif(elem <= 8)
        y_mean(1,elem) = mean(z(:,1:elem + 8));
    elseif(n-elem <= 8)
        y_mean(1,elem) = mean(z(:,(elem - 8):end));
    else
        y_mean(1,elem) = mean(z(:,(elem - 8):(elem + 8)));
    end
end

% Now Filtering wrt mean
y_quart=y;
n=length(y);
for elem = 1:n
    if(elem <= 8 && n-elem <= 8)
        y_quart(1,elem) = quantile(z,0.25);
    elseif(elem <= 8)
        y_quart(1,elem) = quantile(z(:,1:elem + 8), 0.25);
    elseif(n-elem <= 8)
        y_quart(1,elem) = quantile(z(:,(elem - 8):end), 0.25);
    else
        y_quart(1,elem) = quantile(z(:,(elem - 8):(elem + 8)), 0.25);
    end
end

% plot(x,y,'k');
% hold on;
% plot(x,z,'m');
% hold on;
% plot(x,y_mean,'r');
% hold on;
% plot(x,y_median,'b');
% hold on;
% plot(x,y_quart,'g');
% legend('clean','corrupted','mean','median','quartile')
% 
% hold off;

% calculate the rms error for mean
num_mean = 0; num_median = 0; num_quart = 0; den = 0;
for elem = length(y);
    num_mean = num_mean + ((y_mean(1,elem)-y(1,elem))*(y_mean(1,elem)-y(1,elem)));
    num_median = num_median + ((y_median(1,elem)-y(1,elem))*(y_median(1,elem)-y(1,elem)));
    num_quart = num_quart + ((y_quart(1,elem)-y(1,elem))*(y_quart(1,elem)-y(1,elem)));
    den = den + (y(1,elem) * y(1,elem));
end
fprintf('mean = %f\n', num_mean/den);
fprintf('median = %f\n', num_median/den);
fprintf('quart = %f\n', num_quart/den);