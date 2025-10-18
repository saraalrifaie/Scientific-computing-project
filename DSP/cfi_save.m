function cfi_save(filename, s)
%CFI_SAVE Save an image
%
% cfi_save(filename, s)
% saves s.data as an image file
%
    if nargin < 2
        error('cfi_save requires both a filename and a struct s.');
    end
    if ~isfield(s, 'data')
        error('The struct s must contain a field named "data".');
    end

    imwrite(s.data, filename);
end
