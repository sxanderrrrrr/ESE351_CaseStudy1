% Preset:
        % 1: Treble Boost Preset
        % 2: Bass Boost Preset
        % 3: Unity Preset
        % 4: Custom Preset: Filtering out the Siren
        % 5: Custom Preset: Eliminating Mid-Range Frequencies
    
% soundProfiler generates the output audio signal with applied gains
% specific to the equalizer setting. If the equalizer setting equals 1,
% then the profileroutput is an audio signal with boosted treble.  


function profilerOutput = soundProfiler(equalizer_setting, sounddata, Fs) 

    soundFrequencySpectrum = frequencyParser(sounddata,Fs);

    % Treble boost preset
    if equalizer_setting == 1
        profilerOutput = 1.*soundFrequencySpectrum(1:2, :) + 0.7.*soundFrequencySpectrum(3:4, :) +...
                        + 0.0006.*soundFrequencySpectrum(5:6, :) + 2.*soundFrequencySpectrum(7:8, :) +...
                        + 5.*soundFrequencySpectrum(9:10, :);
    end

    % Bass boost preset
    if equalizer_setting == 2
        profilerOutput = 1.*soundFrequencySpectrum(1:2, :) + 5.*soundFrequencySpectrum(3:4, :) +... 
                       + 1.*soundFrequencySpectrum(5:6, :) + 0.1.*soundFrequencySpectrum(7:8, :) +...
                       + 1.*soundFrequencySpectrum(9:10, :);
    end

    % Unity preset
    if equalizer_setting == 3
        profilerOutput = 1.* soundFrequencySpectrum(1:2, :) + 0.6.*soundFrequencySpectrum(3:4, :) +...
                       + 0.6.*soundFrequencySpectrum(5:6, :) + 0.8.*soundFrequencySpectrum(7:8, :) + ...
                       + 0.7.*soundFrequencySpectrum(9:10, :);
    end
    
    % Custom preset for siren filter
    if equalizer_setting == 4
        profilerOutput = 2.*soundFrequencySpectrum(1:2, :) + 0.5.*soundFrequencySpectrum(3:4, :) +...
                      + 0.0001.*soundFrequencySpectrum(5:6, :) + 0.0001.*soundFrequencySpectrum(7:8, :) +...
                      + 1.3.*soundFrequencySpectrum(9:10, :);
    end
    
    % Custom Preset that cancels Mid Range Frequencies
     if equalizer_setting == 5
        profilerOutput = 2.*soundFrequencySpectrum(1:2, :) + 0.5.*soundFrequencySpectrum(3:4, :) +...
                      + 0.*soundFrequencySpectrum(5:6, :) + 0.*soundFrequencySpectrum(7:8, :) +...
                      + 2.5.*soundFrequencySpectrum(9:10, :);
     end
end