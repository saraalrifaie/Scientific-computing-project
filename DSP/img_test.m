% img_test.m
% whilst doing the labels for each figure, the labels below get mixed up
% and ive tried to fix that multiple but there has no soultion as it works
% once then does not.
% i have placed close all on top so that when another image is run the
% previous gets close as assumption was thats why my labels are mixed up
% but it still has not be fixed
close all; clear; clc;

% load  image
s = cfi_load('peacock.png'); 

% figure 1: original image
figure(1); clf;
cfi_display(s, 's');
title('Spatial Domain Image');

% figure 2:segmented mask
figure(2); clf;
m = cfi_segment(s); % or cfi_display(s, 'e');
imshow(m);
title('Segmented Mask');

%figure 3: cartoon ext
figure(3); clf;
ss = cfi_ext(s);
imshow(ss.data, []);
title('Cartoon Effect Image');