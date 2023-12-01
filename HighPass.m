% Read and process the image
img = imread('/Users/john_1john_1/courses/MATH528Project/ram4.png');
img_gray = rgb2gray(img);
[dim1, dim2] = size(img_gray);
min_dim = min(dim1, dim2);
img_cropped = img_gray(1:min_dim, 1:min_dim);

% 2D Fourier Transform of the cropped image
F = fft2(double(img_cropped));
F_shifted = fftshift(F);

% Create a frequency mask for high-pass filtering
mask_radius = 30;
mask = (x.^2 + y.^2) > mask_radius^2;

% high-pass filter
filtered_F = F_shifted .* mask;
magnitude_log_filtered = log(abs(filtered_F) + 1);

% Inverse Fourier Transform of the filtered image
inverse_filtered_image = real(ifft2(ifftshift(filtered_F)));

figure;

subplot('Position', [0.01, 0.5, 0.45, 0.45]);
imshow(img_cropped);
title('f(m, n)');

subplot('Position', [0.51, 0.5, 0.45, 0.45]);
imshow(log(abs(F_shifted) + 1), []);
title('Log|F(p, q)|');

subplot('Position', [0.51, 0.01, 0.45, 0.45]);
imshow(magnitude_log_filtered, []);

subplot('Position', [0.01, 0.01, 0.45, 0.45]);
imshow(inverse_filtered_image, []);

annotation('arrow', [0.42, 0.55], [0.73, 0.73], 'HeadWidth', 13, 'HeadLength', 13,'LineWidth', 3); % Right arrow
annotation('arrow', [0.55, 0.42], [0.23, 0.23], 'HeadWidth', 13, 'HeadLength', 13,'LineWidth', 3); % Left arrow
annotation('arrow', [0.93, 0.93], [0.55, 0.40], 'HeadWidth', 13, 'HeadLength', 13,'LineWidth', 3); % Down arrow