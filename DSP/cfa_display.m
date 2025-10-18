function cfa_display(s, domain)
%CFA_DISPLAY Show the audio signal
%
% cfa_display(s) shows the audio in the time domain
% cfa_display(s, 'f') shows it in the frequency domain
%
% inputs:
% s: audio structure with s.data and s.fs
% domain - 't' for time (default), 'f' for frequency
% I used FFT for frequency plots instead of spectrograms to keep it simple and fast.


    if nargin < 2
        domain = 't';
    end

    if ~isfield(s, 'data') || ~isfield(s, 'fs')
        error('The audio signal structure must contain fields "data" and "fs".');
    end

    switch lower(domain(1))
        case 't'
            % time domain plot
            t = (0:length(s.data)-1) / s.fs;
            plot(t, s.data);
            xlabel('Time (s)');
            ylabel('Amplitude');
            title('Time Domain Signal');

        case 'f'
            % frequency domain plot
            N = length(s.data);
            Y = fft(s.data);

            % convert frequency axis to kHz
            f = (0:N-1) * (s.fs / N) / 1000;  
            halfN = ceil(N/2);

            plot(f(1:halfN), abs(Y(1:halfN)));
            xlabel('Frequency (kHz)');
            ylabel('Magnitude');
            title('Frequency Domain Signal');
            xlim([0, 5]);

        otherwise
            error('Invalid domain. Use ''t'' for time or ''f'' for frequency.');
    end
end
