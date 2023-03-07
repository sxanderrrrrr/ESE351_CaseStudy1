function profilerOutput = soundProfiler(equalizer_setting, gain, sounddata, Fs)
    % Depending on profile number it returns 1 - Treble boost, 2 - Bass
    % boost, 3 - Unity, 4 - Custom, ect

    gain = 10.^(gain./10);

    soundFrequencySpectrum = frequencyParser(sounddata,Fs);

    % Treble boost preset
    if equalizer_setting == 1
        doubleFiltered = frequencyParser(soundFrequencySpectrum(9:10,:)', Fs);
        tripleFiltered = frequencyParser(doubleFiltered(9:10,:)', Fs);
        profilerOutput = 0.75.*soundFrequencySpectrum(1:2, :) + 0.75.*soundFrequencySpectrum(3:4, :) + 0.75.*soundFrequencySpectrum(5:6, :) + 0.75.*soundFrequencySpectrum(7:8, :) + gain.*tripleFiltered(9:10, :);
    end

    % Bass boost preset
    if equalizer_setting == 2
        profilerOutput = gain.*soundFrequencySpectrum(1:2, :) + gain.*soundFrequencySpectrum(3:4, :);
    end

    % Unity preset
    if equalizer_setting == 3
        profilerOutput = soundFrequencySpectrum(1:2, :) + soundFrequencySpectrum(3:4, :) + soundFrequencySpectrum(5:6, :) + soundFrequencySpectrum(7:8, :) + soundFrequencySpectrum(9:10, :);
    end
    
    if equalizer_setting == 4
        profilerOutput = soundFrequencySpectrum(1:2, :) + gain.*(soundFrequencySpectrum(5:6, :));

    end
end