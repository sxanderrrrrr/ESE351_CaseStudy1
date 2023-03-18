% BandsRun demonstrates the noSiren audio preset. When noSiren is set to 1,
% the audio file plays with an attenuated siren. 

filename = 'Blue in Green with Siren.wav';

noSiren = 1;

[sounddata, Fs] = audioread(filename); 
sirenMin = minimizeSiren(noSiren, sounddata, Fs);  
sound(sirenMin, Fs); 

%% FFT of Filtered Siren
f = [0:length(sirenMin)-1]*Fs/length(sirenMin);
    BANDS = fft(sirenMin); 
    figure, plot(f,abs(BANDS)); 
    xlabel('f, Hz')
    ylabel('|X(f)|')
    title('FFT of 10 Bands')
