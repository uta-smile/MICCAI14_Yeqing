close all 

I = imread('000224.png');
t = load('init.txt');
t(3:4) = t(3:4)-t(1:2);

t1 = load('init.txt');
t1 = round(t1);

imshow(I)
hold on; plot(X(:), Y(:), 'g.', 'markersize', 5);
[X, Y] = meshgrid(t1(1)+5:10:t1(3)-5, t1(2)+5:10:t1(4)-5);
rectangle('Position', t, 'EdgeColor', 'g')
