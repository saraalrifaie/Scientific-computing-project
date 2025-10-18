
%TEST_TOOLBOX Quick test script for my DSP toolbox
% What this does:
% loads an audio file (make sure 'example.ogg' is in the same folder)
% shows the audio in time and frequency plots
% applies an equaliser and shows the result
% applies dynamic EQ and shows that
% plays the original, then EQ’d, then dynamic EQ’d audio
%
% what you need in the folder: example.ogg(audio) and cfa_load, cfa_save, 
% cfa_display, cfa_play, cfa_equalise, cfa_ext


clear; clc;

%% load Audio File
s = cfa_load('sample.ogg');

%% figure1: display original signal (time domain)
figure(1); clf;
cfa_display(s, 't');
title('Original Signal (Time Domain)');

%% figure2: display original signal (frequency domain)
figure(2); clf;
cfa_display(s, 'f');
title('Original Signal (Frequency Domain)');

%% apply 11-Band Equaliser (cfa_equalise)
% Example EQ settings: boost band 6 by 3 dB and cut band 7 by 2 dB.
b = [0, 0, 0, 0, 0, 3, -2, 0, 0, 0, 0];
ss = cfa_equalise(s, b);

%% figure3: display static EQ ssignal (frequency domain)
figure(3); clf;
cfa_display(ss, 'f');
title('Static EQ Signal (Frequency Domain)');

%% extended function
% dynamic EQ applied to the 500-1000 Hz band:
% trigger threshold: -20 dB
% attack time: 0.01 sec
% release time: 0.2 sec
% reduction: -6 dB
ss_ext = cfa_ext(s, [500, 1000], -20, 0.01, 0.2, -6);

%% figure4: display dynamic EQ signal (frequency domain)
figure(4); clf;
cfa_display(ss_ext, 'f');
title('Dynamic EQ Signal (Frequency Domain)');

% play original audio
disp('Playing original audio...');
cfa_play(s, 100);
pause(length(s.data)/s.fs + 1);

% play static EQ audio
disp('Playing static EQ audio...');
cfa_play(ss, 100);
pause(length(s.data)/s.fs + 1);

% play dynamic EQ audio
disp('Playing dynamic EQ audio...');
cfa_play(ss_ext, 100);
