
originalImage = imread('/Users/john_1john_1/courses/MATH528Project/ram4.png');
originalImage = rgb2gray(originalImage);
% Create a smaller point squared function (representing motion blur)
pointSquaredFunction = fspecial('motion', 200, 45);

% Convolve the image with the point squared function
blurredImage = imfilter(originalImage, pointSquaredFunction, 'conv', 'same');

% noise
noise = randn(size(blurredImage)) * 20;

noiseImage = uint8(noise + 128); % make noise visible

% Add the noise to the blurred image to get the final image
finalImage = double(blurredImage) + double(noise);
finalImage = uint8(max(min(finalImage, 255), 0));

figure;
subplot('Position', [0.01, 0.5, 0.45, 0.45]), imshow(originalImage), title('Original Image');
subplot('Position', [0.51, 0.5, 0.45, 0.45]), imshow(pointSquaredFunction, []), title('Point Spread Function');
subplot('Position', [0.51, 0.01, 0.45, 0.45]), imshow(finalImage), title('Blurred Image with Noise');
subplot('Position', [0.01, 0.01, 0.45, 0.45]), imshow(noiseImage), title('Noise');

% Add arrows
annotation('arrow', [0.42, 0.55], [0.73, 0.73], 'HeadWidth', 13, 'HeadLength', 13,'LineWidth', 3); % Right arrow
annotation('arrow', [0.42, 0.55], [0.23, 0.23], 'HeadWidth', 13, 'HeadLength', 13,'LineWidth', 3); % Right arrow
annotation('arrow', [0.54, 0.43], [0.55, 0.40], 'HeadWidth', 13, 'HeadLength', 13,'LineWidth', 3); % diagonal arrow

% Add symbols
annotation('textbox', [0.47, 0.76, 0.03, 0.03], 'String', '*', 'EdgeColor', 'none', 'HorizontalAlignment', 'center','FontSize', 35);
annotation('textbox', [0.47, 0.52, 0.03, 0.03], 'String', '+', 'EdgeColor', 'none', 'HorizontalAlignment', 'center','FontSize', 25);
annotation('textbox', [0.47, 0.27, 0.03, 0.03], 'String', '=', 'EdgeColor', 'none', 'HorizontalAlignment', 'center','FontSize', 25);