% Read and process the image
img = imread('/Users/john_1john_1/courses/MATH528Project/ram4.png');
img_gray = rgb2gray(img); 
[dim1, dim2] = size(img_gray);
min_dim = min(dim1, dim2);
img_cropped = img_gray(1:min_dim, 1:min_dim);

% 2d Fourier Transform of the cropped image
F = fft2(double(img_cropped));
F_shifted = fftshift(F);
magnitude_log = log(abs(F_shifted) + 1);

figure;
subplot('Position', [0.05, 0.1, 0.4, 0.8]);
imshow(img_cropped);
title('f(x, y)');

subplot('Position', [0.53, 0.1, 0.4, 0.8]);
imshow(magnitude_log, []);
title('Log(|F(u, v)|)');

annotation('arrow', [0.46 0.52], [0.5 0.5], 'HeadWidth', 13, 'HeadLength', 13, 'LineWidth', 3);
colorbar('Position', [0.05, 0.14, 0.88, 0.04], 'Orientation', 'horizontal');
caxis([min(magnitude_log(:)), max(magnitude_log(:))]);