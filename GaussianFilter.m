% Read and process the image
img = imread('/Users/john_1john_1/courses/MATH528Project/ram4.png');
img_gray = rgb2gray(img);
[dim1, dim2] = size(img_gray);
min_dim = min(dim1, dim2);
img_cropped = img_gray(1:min_dim, 1:min_dim);

%2D Fourier Transform
F = fft2(double(img_cropped));
F_shifted = fftshift(F);

%Gaussian filter
sigma = 90;
filter_size = 90;
[h1, h2] = meshgrid(round(-filter_size/2):round(filter_size/2), round(-filter_size/2):round(filter_size/2));
gaussian_filter = exp(-h1.^2/(2*sigma^2) - h2.^2/(2*sigma^2));
gaussian_filter = gaussian_filter / sum(gaussian_filter(:));
gaussian_filter_shifted = fftshift(fft2(gaussian_filter, min_dim, min_dim));

% Multiply Fourier Transform of image with Fourier Transform of Gaussian filter
product_F = F_shifted .* gaussian_filter_shifted;

% Inverse Fourier Transform
inverse_product = real(ifft2(ifftshift(product_F)));

figure;

subplot('Position', [0.01, 0.66, 0.3, 0.3]);
imshow(img_cropped);
title('f(m, n)');

subplot('Position', [0.34, 0.66, 0.3, 0.3]);
imshow(log(abs(F_shifted) + 1), []);
title('Log(|F(p, q)|)');

subplot('Position', [0.01, 0.33, 0.3, 0.3]);
imshow(gaussian_filter, []);

subplot('Position', [0.34, 0.33, 0.3, 0.3]);
imshow(log(abs(gaussian_filter_shifted) + 1), []);

subplot('Position', [0.01, 0.01, 0.3, 0.3]);
imshow(inverse_product, []);

subplot('Position', [0.34, 0.01, 0.3, 0.3]);
imshow(log(abs(product_F) + 1), []);

%add arrows
annotation('arrow', [0.28, 0.37], [0.81, 0.81], 'HeadWidth', 13, 'HeadLength', 13,'LineWidth', 3); % Right arrow
annotation('arrow', [0.37, 0.28], [0.16, 0.16], 'HeadWidth', 13, 'HeadLength', 13,'LineWidth', 3); % Left arrow
annotation('arrow', [0.62, 0.62], [0.37, 0.26], 'HeadWidth', 13, 'HeadLength', 13,'LineWidth', 3); % Down arrow1
annotation('arrow', [0.03, 0.03], [0.37, 0.26], 'HeadWidth', 13, 'HeadLength', 13,'LineWidth', 3); % Down arrow2

%other symbols
annotation('textbox', [0.48, 0.47, 0.02, 0.35], 'String', 'x','EdgeColor', 'none', 'HorizontalAlignment', 'center', 'FontSize', 15, 'VerticalAlignment', 'middle');
annotation('textbox', [0.16, 0.46, 0, 0.35], 'String', '*','EdgeColor', 'none', 'HorizontalAlignment', 'center', 'FontSize', 30, 'VerticalAlignment', 'middle');