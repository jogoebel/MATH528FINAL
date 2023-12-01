
originalImage = imread('/Users/john_1john_1/courses/MATH528Project/ram4.png');

% convert to grayscale
originalImage = rgb2gray(originalImage);
originalImage = im2double(originalImage);

% standard motion blur point spread function
psf = fspecial('motion', 200, 45);

% Convolve the image with the point spread function to create a blurred image
blurredImage = imfilter(originalImage, psf, 'conv', 'same');

% Generate noise and add to the blurred image
noise = randn(size(blurredImage)) * 0.1;
noisyBlurredImage = blurredImage + noise;
noisyBlurredImage = uint8(max(min(noisyBlurredImage * 255, 255), 0));

% Fourier Transform of the noisy blurred image
FT_noisyBlurred = fft2(noisyBlurredImage);

% Fourier Transform of the PSF
FT_psf = fft2(psf, size(noisyBlurredImage, 1), size(noisyBlurredImage, 2));

% Motion Deblurring (Inverse filtering in the frequency domain)
FT_deblur = FT_noisyBlurred ./ FT_psf;
motionDeblurImage = real(ifft2(FT_deblur));

% Wiener Deconvolution in the frequency domain
snr = 0.006; % Signal-to-noise ratio
FT_wienerDeconv = conj(FT_psf) ./ (abs(FT_psf).^2 + snr) .* FT_noisyBlurred;
wienerDeconvImage = real(ifft2(FT_wienerDeconv));

figure;

subplot('Position', [0.01, 0.5, 0.45, 0.45]), imshow(noisyBlurredImage, []), title('Blurry Noisy Image');
subplot('Position', [0.51, 0.5, 0.45, 0.45]), imshow(psf, []), title('Motion Blur PSF');
subplot('Position', [0.51, 0.01, 0.45, 0.45]), imshow(wienerDeconvImage, []), title('Wiener Deconvolution Recovered Image');
subplot('Position', [0.01, 0.01, 0.45, 0.45]), imshow(motionDeblurImage, []), title('Motion Deblur Recovered Image') ;

annotation('textbox', [0.47, 0.50, 0.03, 0.03], 'String', '=', 'EdgeColor', 'none', 'HorizontalAlignment', 'center','FontSize', 30);
annotation('textbox', [0.47, 0.76, 0.03, 0.03], 'String', '/', 'EdgeColor', 'none', 'HorizontalAlignment', 'center','FontSize', 35);
annotation('arrow', [0.47, 0.43], [0.45, 0.30], 'HeadWidth', 13, 'HeadLength', 13,'LineWidth', 3); % diagonal arrow
annotation('arrow', [0.50, 0.54], [0.45, 0.30], 'HeadWidth', 13, 'HeadLength', 13,'LineWidth', 3); % diagonal arrow
