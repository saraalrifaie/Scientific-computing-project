function s = cfi_load(filename)
%CFI_LOAD Load an image
%s = cfi_load(filename)
%loads an image (PNG/JPG) and puts it into s.data
%

    if nargin < 1
        error('cfi_load requires a filename as input.');
    end
    if ~isfile(filename)
        error('File not found: %s', filename);
    end

    % read the image & store in struct
    s.data = imread(filename);
    s.info = imfinfo(filename);
end
