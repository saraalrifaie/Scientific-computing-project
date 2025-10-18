function cfa_play(s, v)
%CFA_PLAY play audio
%
% cfa_play(s) plays at normal volume (100%)
% cfa_play(s, v) plays at v percent volum
%
% inputs:
% s-audio structure with s.data and s.fs
% v-volume percentage (default = 100)
%
if nargin < 2
    v = 100;
end
if ~isfield(s, 'data') || ~isfield(s, 'fs')
    error('The structure must have fields "data" and "fs".');
end

sound(s.data * (v/100), s.fs);
end
