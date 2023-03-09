function profilerOutput = soundProfiler(equalizer_setting, sounddata, Fs)
    % Depending on profile number it returns 1 - Treble boost, 2 - Bass
    % boost, 3 - Unity, 4 - Custom, ect

    soundFrequencySpectrum = frequencyParser(sounddata,Fs);

    % Treble boost preset
    if equalizer_setting == 1
%         doubleFiltered = frequencyParser(soundFrequencySpectrum(9:10,:)', Fs);
%         tripleFiltered = frequencyParser(doubleFiltered(9:10,:)', Fs);
        profilerOutput = soundFrequencySpectrum(1:2, :) + 0.7.*soundFrequencySpectrum(3:4, :) + 0.0006.*soundFrequencySpectrum(5:6, :) + 2.*soundFrequencySpectrum(7:8, :) + 8.*soundFrequencySpectrum(9:10, :);
    end

    % Bass boost preset
    if equalizer_setting == 2
        profilerOutput = soundFrequencySpectrum(1:2, :) + 5.*soundFrequencySpectrum(3:4, :) + soundFrequencySpectrum(5:6, :) + 0.1.*soundFrequencySpectrum(7:8, :) + soundFrequencySpectrum(9:10, :);
    end

    % Unity preset
    if equalizer_setting == 3
        profilerOutput = soundFrequencySpectrum(1:2, :) + 0.6.*soundFrequencySpectrum(3:4, :) + 0.6.*soundFrequencySpectrum(5:6, :) + 0.8.*soundFrequencySpectrum(7:8, :) + 0.7.*soundFrequencySpectrum(9:10, :);
    end

   % Custom preset for siren filter
    if equalizer_setting == 4
        profilerOutput = 2.*soundFrequencySpectrum(1:2, :) + 0.05.*soundFrequencySpectrum(3:4, :) + 0.0001.*soundFrequencySpectrum(5:6, :) + 0.0001.*soundFrequencySpectrum(7:8, :) + 1.3.*soundFrequencySpectrum(9:10, :);
    end
end