%% Case Study 1
% Authors: Xander Schmit, Nicole Ejedimu, Mary Butler
% Collaborators:
% Date: 
% Work Log
% Who               When
% Xander & Nicole   02/28 10:45 am - 12:15 pm
% Xander, Mary, Nicole 02/03 2:30 - 5:00 pm
% Xander, Mary, Nicole 02/04 10 am - 1:00 pm
% Xander & Mary 02/07 8 am - ...
%% Control Panel 

filename = 'Blue in Green with Siren.wav';

% Sound profiles include: 1 - Treble boost, 2 - Bass boost, 3 - Unity, 4 -
% Siren filter, 5 - Enhancement preset

equalizer_setting = 4;

gain = -15; % in dB


% ----------------------- USER NO TOUCHING BELOW HERE ---------------------

% soundDataSpectrum is the sounddata after it has been filtered by the
% various LPF - HPF systems. Rows 1 & 2 correspond to low bass. Rows 3&4
% correspond to bass. Row 5&6 correspond to low midrange. Row 7&8
% correspond to midrange. Row 9&10 correspond to treble.


[sounddata, Fs] = audioread(filename);


equalizerOutput = soundProfiler(equalizer_setting, gain, sounddata, Fs);

%% Space Station - Treble Cut Audio File

[spaceStation, Fs] = audioread('Space Station - Treble Cut.wav');

sound(spaceStation, Fs);

%% show transform of Space Station
f = [0:length(equalizerOutput)-1]*Fs/length(equalizerOutput);
SOUNDDATA = fft(equalizerOutput); 
figure, plot(f,abs(SOUNDDATA)); 
xlabel('f, Hz')
ylabel('|X(f)|')

%% Giant Steps Bass Cut

[giantSteps, Fs] = audioread('Giant Steps Bass Cut.wav');

sound(giantSteps, Fs);

%% show transform of Giant Steps Bass Cut

f = [0:length(giantSteps)-1]*Fs/length(giantSteps);
GIANTSTEPS = fft(giantSteps); 
figure, plot(f,abs(GIANTSTEPS)); 
xlabel('f, Hz')
ylabel('|X(f)|')

%% SIREN FILTERING

%% Blue in Green with Siren - Audio File

[blueGreen, Fs] = audioread('Blue in Green with Siren.wav');

sound(blueGreen, Fs);

%% show transform of Blue in Green with Siren
f = [0:length(blueGreen)-1]*Fs/length(blueGreen);
BLUEGREEN = fft(blueGreen); 
figure, plot(f,abs(BLUEGREEN)); 
xlabel('f, Hz')
ylabel('|X(f)|')
%% show transform for first second

blueGreenSnip = blueGreen(1.*Fs:5.*Fs);
f = [0:length(blueGreenSnip)-1]*Fs/length(blueGreenSnip);
BLUEGREENSNIP = fft(blueGreenSnip); 
figure, plot(f,abs(BLUEGREENSNIP));
ylabel('|X(f)|')
pause
set(gca,'YScale','log')

%% Attempting to filter the siren

sound(equalizerOutput, Fs)

%% show transform for first second

profilerSnip = equalizerOutput(1.*Fs:5.*Fs);
f = [0:length(profilerSnip)-1]*Fs/length(profilerSnip);
profilerSNIP = fft(profilerSnip); 
figure, plot(f,abs(profilerSNIP));
ylabel('|X(f)|')
pause
set(gca,'YScale','log')

%% Input signal analysis


 

