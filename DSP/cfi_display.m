function cfi_display(s, domain)
%CFI_DISPLAY Show the image
%
% cfi_display(s) shows the image
% cfi_display(s, 'e') shows the mask from cfi_segment
%
    if nargin < 2
        domain = 's';
    end
    
    if ~isfield(s, 'data')
        error('The struct s must contain a field named "data".');
    end

    switch lower(domain(1))
        case 's'
          
            imshow(s.data, []);
            
        case 'e'
            m = cfi_segment(s);
            imshow(m);
            
        otherwise
            error('Invalid domain. Use ''s'' for spatial or ''e'' for segmentation.');
    end
end
