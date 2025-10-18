function cfa_save(filename, s)
%CFA_SAVE Save an audio file
%
% cfa_save(filename, s)
% Saves the audio from structure s into a file
% Needs s.data (audio samples) and s.fs (sampling rate)
%
% just uses audiowrite

if nargin < 2
    error('Filename and audio structure required.');
end
if ~isfield(s, 'data') || ~isfield(s, 'fs')
    error('The structure must have fields "data" and "fs".');
end

audiowrite(filename, s.data, s.fs);
end
