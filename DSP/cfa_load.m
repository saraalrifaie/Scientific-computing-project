function s = cfa_load(filename)
%CFA_LOAD Load an audio file
%s = cfa_load(filename)
% I decided to store sampling rate and info in the same struct to keep everything tidy.
% output structure s has:
% s.data: audio samples
% s.fs: sampling rate (Hz)
% s.info: extra file info
%
if nargin < 1
    error('Filename required.');
end
if ~isfile(filename)
    error('File not found.');
end

s.info = audioinfo(filename);
[s.data, s.fs] = audioread(filename);
end
