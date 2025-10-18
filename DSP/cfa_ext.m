function ss = cfa_ext(s, freqBand, threshold, attack, release, reduction)
%CFA_EXT Apply dynamic EQ to a frequency band.
%ss = cfa_ext(s, freqBand, threshold, attack, release, reduction)
%
% dynamically reduces gain in a frequency band if it gets too loud
%
% inputs:
%       s: audio structure
%       freqBand: [low high] frequencies in Hz
%       threshold: amplitude level in db to trigger reduction
%       attack: how quickly it reacts 
%       release: how quickly it recovers
%       reduction: gain cut (in dB)
%
%   how it works
%  bandpass filter the chosen band
%  measure amplitude changes
%  reduce gain if it crosses threshold
%  smooth changes using attack/release times

    % verify input structure has required fields
    if ~isfield(s, 'data') || ~isfield(s, 'fs')
        error('Input structure s must contain fields "data" and "fs".');
    end
    
    fs = s.fs;
    [N, M] = size(s.data);
    threshold_lin = 10^(threshold/20);
    reduction_factor = 10^(reduction/20);
    
    Wn = freqBand / (fs/2);  % normalise frequency
    [b_bp, a_bp] = butter(2, Wn, 'bandpass');
    
    outData = s.data;
    
   
    for ch = 1:M
        x = s.data(:, ch);
        % filter signal 
        band = filter(b_bp, a_bp, x);
        env = zeros(size(band));
        gain = ones(size(band));
        env(1) = abs(band(1));
        gain(1) = 1;
        
   
        for n = 2:N
          
            if abs(band(n)) > env(n-1)
                alpha = exp(-1/(fs*attack));
            else
                alpha = exp(-1/(fs*release));
            end
            env(n) = (1 - alpha)*abs(band(n)) + alpha*env(n-1);
            
            if env(n) > threshold_lin
                targetGain = reduction_factor;
            else
                targetGain = 1;
            end
            
            % smooth gain transition
            gain(n) = (1 - alpha)*targetGain + alpha*gain(n-1);
        end
        
       
        processed_band = band .* gain;
    
        outData(:, ch) = x - band + processed_band;
    end
    
    ss = s;
    ss.data = outData;
end
