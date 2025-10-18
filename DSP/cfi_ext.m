function ss = cfi_ext(s)
%CFI_EXT cartoon effect
%
%   ss = cfi_ext(s)
%   makes the image look cartoon like by smoothing and adding edges
%

    img = s.data;
    if ndims(img) == 3
        img_gray = rgb2gray(img);
    else
        img_gray = img;
    end

    % smooth image using median filter
    smoothed_img = medfilt2(img_gray, [7 7]); 
    edges = edge(img_gray, 'Sobel');
    inverted_edges = ~edges;
    cartoon_img = uint8(double(smoothed_img) .* double(inverted_edges));

   if ndims(img) == 3
        cartoon_img_rgb = zeros(size(img), 'uint8');
        for c = 1:3
            channel = img(:, :, c);
            smoothed_channel = medfilt2(channel, [7 7]);
            cartoon_channel = uint8(double(smoothed_channel) .* double(inverted_edges));
            cartoon_img_rgb(:, :, c) = cartoon_channel;
        end
        cartoon_img = cartoon_img_rgb;
    end
        ss.data = cartoon_img;
end
