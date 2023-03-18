%% Case Study 1 Main File

%% Control Panel 

% filename = 'Space Station - Treble Cut.wav';
filename = 'Blue in Green with Siren.wav'; 

equalizer_setting = 5;

[sounddata, Fs] = audioread(filename); 
profilerOutput = soundProfiler(equalizer_setting, sounddata, Fs); 
% sound(profilerOutput, Fs);

%% ----------------------- USER NO TOUCHING BELOW HERE ---------------------

% soundDataSpectrum is the sounddata after it has been filtered by the
% various LPF - HPF systems. Rows 1 & 2 correspond to low bass. Rows 3&4
% correspond to bass. Row 5&6 correspond to low midrange. Row 7&8
% correspond to midrange. Row 9&10 correspond to treble.

%% Space Station - Treble Cut
    filename = 'Space Station - Treble Cut.wav';
    [sounddata, Fs] = audioread(filename);
    equalizer_setting = 1; 
    profilerOutput = soundProfiler(equalizer_setting, sounddata, Fs); 
%     sound(sounddata, Fs);  

% Space Station FFT 
    f = [0:length(profilerOutput)-1]*Fs/length(profilerOutput);
    SOUNDDATA = fft(profilerOutput); 
    figure, plot(f,abs(SOUNDDATA)); 
    xlabel('f, Hz')
    ylabel('|X(f)|')
    title('FFT of Space Station- Treble Cut Audio');
 
%% Giant Steps Bass Cut
    [sounddata, Fs] = audioread('Giant Steps Bass Cut.wav');
    equalizer_setting = 2; 
    profilerOutput = soundProfiler(equalizer_setting, sounddata, Fs);
%     sound(profilerOutput, Fs); 

% Giant Steps Bass Cut
    f = [0:length(profilerOutput)-1]*Fs/length(profilerOutput);
    GIANTSTEPS = fft(profilerOutput); 
    figure, plot(f,abs(GIANTSTEPS)); 
    xlabel('f, Hz');
    ylabel('|X(f)|'); 
    title('FFT of Giant Steps Bass Cut Audio');


%% Treble Boost Preset
    filename = 'Space Station - Treble Cut.wav'; 
    equalizer_setting = 1; 
    [sounddata, Fs] = audioread(filename); 
    profilerOutput = soundProfiler(equalizer_setting, sounddata, Fs); 
%     sound(profilerOutput, Fs); 

% Treble Boost FFT 
    f = [0:length(profilerOutput)-1]*Fs/length(profilerOutput);
    FFT = fft(profilerOutput); 
    figure(1); 
    plot(f, abs(FFT)); 
    xlabel('f, Hz'); 
    ylabel('|X(f)|');
    title('FFT of Treble Boost Preset');
 
% Treble Boost Spectrogram
%     sounddata = sounddata'; 
    figure(); 
    spectrogram(profilerOutput(1,:),1024,200,1024,Fs);

%% Bass Boost Preset
    filename = 'Space Station - Treble Cut.wav';
    equalizer_setting = 2; 
    [sounddata, Fs] = audioread(filename); 
    profilerOutput = soundProfiler(equalizer_setting, sounddata, Fs);
%     sound(profilerOutput, Fs); 

% Bass Boost FFT
    f = [0:length(profilerOutput)-1]*Fs/length(profilerOutput);
    BASS = fft(profilerOutput); 
    figure, plot(f,abs(BASS)); 
    xlabel('f, Hz')
    ylabel('|X(f)|')
    title('FFT of Bass Boost Output')

% Bass Boost Spectrogram
%     sounddata = sounddata'; 
    figure(); 
    spectrogram(profilerOutput(1,:),1024,200,1024,Fs);

%% Unity Preset
    filename = 'Space Station - Treble Cut.wav';
    equalizer_setting = 3; 
    [sounddata, Fs] = audioread(filename); 
    profilerOutput = soundProfiler(equalizer_setting, sounddata, Fs);
%     sound(profilerOutput, Fs);
 
% Unity FFT
    f = [0:length(profilerOutput)-1]*Fs/length(profilerOutput);
    UNITY = fft(profilerOutput); 
    figure, plot(f,abs(UNITY)); 
    xlabel('f, Hz')
    ylabel('|X(f)|')
    title('FFT of Unity Preset')

% Unity Spectrogram
%     sounddata = sounddata'; 
    figure(); 
    spectrogram(profilerOutput(1,:),1024,200,1024,Fs);

%% Custom Preset: Filtering Out the Siren
    filename = 'Blue in Green with Siren.wav';
    equalizer_setting = 4; 
    [sounddata, Fs] = audioread(filename); 
    profilerOutput = soundProfiler(equalizer_setting, sounddata, Fs);
%     sound(profilerOutput, Fs);

% Custom Preset FFT
    f = [0:length(profilerOutput)-1]*Fs/length(profilerOutput);
    UNITY = fft(profilerOutput); 
    figure, plot(f,abs(UNITY)); 
    xlabel('f, Hz');
    ylabel('|X(f)|');
    title('FFT of Filtered Siren Preset');

% Custom Preset Spectrogram
%     sounddata = sounddata'; 
    figure(); 
    spectrogram(profilerOutput(1,:),1024,200,1024,Fs);

%% Custom Preset for new Audio Signal
    filename = 'funkBeat.wav';  
    [sounddata, Fs] = audioread(filename); 
    equalizer_setting = 5;
    profilerOutput = soundProfiler(equalizer_setting, sounddata, Fs); 
%     sound(profilerOutput, Fs); 

% Custom Audio FFT

    f = [0:length(profilerOutput)-1]*Fs/length(profilerOutput);
    SOUNDDATA = fft(profilerOutput); 
    figure(1), plot(f,abs(SOUNDDATA)); 
    xlabel('f, Hz');
    ylabel('|X(f)|');
    title('FFT of Custom Audio Preset');

% Custom Audio Spectrogram
%     sounddata = sounddata'; 
    figure(); 
    spectrogram(profilerOutput(1,:),1024,200,1024,Fs);
    title('Spectrogram of Custom Audio Preset'); 

