function m = cfi_segment(s)
%CFI_SEGMENT make a mask
%
%   m = cfi_segment(s)
%   makes a black and white mask to separate foreground and background
%

    if ~isfield(s, 'data')
        error('The struct s must contain a field named "data".');
    end

    img = s.data;
    if ndims(img) == 3
        img = rgb2gray(img);
    end

    level = graythresh(img);
    m = imbinarize(img, level);  
end
