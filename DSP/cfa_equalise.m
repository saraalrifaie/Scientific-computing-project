function ss = cfa_equalise(s, b)
%CFA_EQUALISE Apply an 11-band equaliser
%ss = cfa_equalise(s, b)
%
% takes an audio signal and boosts/cuts 11 frequency bands.
% bands: 16, 31.5, 63, 125, 250, 500, 1000, 2000, 4000, 8000, 16000 Hz
%
% inputs:
% s: audio structure
% b: 11 values (in dB) for each band
%
% example:
% b = [0, 0, 0, 0, 0, 3, -2, 0, 0, 6, 0];
% ss = cfa_equalise(s, b);
%
% I used FFT-based scaling instead of designing individual filters to
% make it computationally simpler.
% check that b is a 1x11 vector
    if length(b) ~= 11
        error('cfa_equalise: b must be a 1x11 vector of dB gains.');
    end

    % define the 11 center frequencies
    centerFreqs = [16, 31.5, 63, 125, 250, 500, 1000, 2000, 4000, 8000, 16000];

    % get the sampling frequency
    fs = s.fs;
    edges = zeros(1, 12);
    edges(1) = 0;
    for i = 1:10
        edges(i+1) = sqrt(centerFreqs(i) * centerFreqs(i+1));
    end
    edges(12) = fs/2;

   
    multipliers = 10.^(b/20);

    audioData = s.data;
    [N, M] = size(audioData);

    % have an output array for the processed data
    outData = zeros(N, M);
    for ch = 1:M
        Y = fft(audioData(:, ch));
        for k = 1:N
          
            freqIndex = k - 1;  
            if freqIndex <= N/2
                freq = freqIndex * (fs / N);
            else
                % for negative frequencies 
                freq = (freqIndex - N) * (fs / N);
            end
            
            freqAbs = abs(freq);
            
            % which band this frequency falls in
            bandIdx = findBand(freqAbs, edges);
            
            if bandIdx > 0 && bandIdx <= 11
                Y(k) = Y(k) * multipliers(bandIdx);
            end
        end
        
        outData(:, ch) = ifft(Y, 'symmetric');
    end

    ss = s;
    ss.data = outData;
end

%% local helper function: findBand
function bandIdx = findBand(freq, edges)
%FINDBAND Finds which band a frequency belongs to
%freq is the frequency you’re checking
%edges is a list of band edges
%It returns the band number (1 to 11) if the frequency fits in one band
%If it doesn’t fit, returns 0

    if freq < edges(1) || freq >= edges(end)
        bandIdx = 0;
        return;
    end

    for i = 1:11
        if freq >= edges(i) && freq < edges(i+1)
            bandIdx = i;
            return;
        end
    end
    
  
    bandIdx = 11;
end
