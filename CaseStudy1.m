%% Case Study 1
% Authors: Xander Schmit, Nicole Ejedimu, Mary Butler
% Collaborators:
% Date: 
% Work Log
% Who               When
% Xander & Nicole   02/28 10:45 am - 12:15 pm
% Xander, Mary, Nicole 02/03 2:30 - 5:00 pm
% Xander, Mary, Nicole 02/04 10 am - 1:00 pm
% Xander 02/07 8 am - ...
%% Control Panel 

filename = 'Space Station - Treble Cut.wav';

% Sound profiles include: 1 - Treble boost, 2 - Bass boost, 3 - Unity, 4 -
% Custom

profile = 1;


% ----------------------- USER NO TOUCHING BELOW HERE ---------------------

% soundDataSpectrum is the sounddata after it has been filtered by the
% various LPF - HPF systems. Rows 1 & 2 correspond to low bass. Rows 3&4
% correspond to bass. Row 5&6 correspond to low midrange. Row 7&8
% correspond to midrange. Row 9&10 correspond to treble.


[soundDataSpectrum, Fs] = frequencyParser(filename);

% profileOutput = soundProfiler(profile, soundDataSpectrum);

sound(soundDataSpectrum(9:10, :), Fs);


