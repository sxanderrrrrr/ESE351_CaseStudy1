%% Dividing up frequency domain

function [soundSpectrum, Fs] = frequencyParser(filename)
    [sounddata, Fs] = audioread(filename);

    t = 0:1/Fs:(length(sounddata)-1)/Fs;

    sounddata = sounddata';

    % We are going to put LPF and HPF LTI systems in series to create a
    % bandpass filter. We are going to select cutoff frequency such that the
    % low end cut off and high end cut off keep treble frequencies at unity and
    % attenuate other signals.

    % The treble frequency fange is assume to be 6 kHz to 20 kHz.

    % LPF Calculations

    % f is frequency ranges in Hz. 
    % Each row is a diff range.

    f = [20,  250 %    Sub-Bass 
        250, 500; %    Bass
        500, 2000; %   Midrange
        2000, 4000; %  Higher Midrange
        6000, 20000];% Treble
    % We fix resistance and solve capacitance based off of the cut off
    % frequencies of the different ranges

    R = 1000;

    % Array that contains the capacitance values for the many filters.

    % Array that contains the capacitance values for the HPF.
    CH = [];

    CL = [];

    % LPF and HPF Capacitance

    for i = 1:length(f(:,2))
        ch = 1/(2.*pi.*f(i,1).*R);
        CH = cat(1,CH,ch);
        cl = 1/(2.*pi.*f(i,2).*R);
        CL = cat(1,CL,cl);
    end

    C = cat(2,CL,CH);

    TAU = R.*C;

    % Coefficients

    B = [];
    A = [];

    for i = 1:length(f(:,1))
        b = [0 1./TAU(i,1) 0];
        a = [1 1./TAU(i,1) + 1./TAU(i,2) (1/TAU(i,1)).*(1/TAU(i,2))];
        B = cat(1,B,b);
        A = cat(1,A,a);
    end


    % soundSpectrum contains the outputs of the sounddata after being sent
    % through each bandpass filter.

    soundSpectrum = [];

    for k = 1:length(f(:,1))
        for i = 1:2
            out = lsim(B(k,:), A(k,:), sounddata(i,:),t);
            soundSpectrum = cat(2,soundSpectrum,out);
        end
    end

    soundSpectrum = soundSpectrum';

end

function profilerOutput = soundProfiler(preset, soundDataSpectrum)
    % Depending on profile number it returns 1 - Treble boost, 2 - Bass
    % boost, 3 - Unity, 4 - Custom, ect

    % Treble boost preset
    if preset == 1
        profilerOutput = 5.*soundDataSpectrum(9:10, :);
    end

    % Bass boost preset
    if preset == 2
        profilerOutput = soundDataSpectrum(1:2, :) + soundDataSpectrum(3:4, :);
    end

    % Unity preset
    if preset == 3
        profilerOutput = soundDataSpectrum;
    end
    
    if preset == 4
        profilerOutput = soundDataSpectrum;
    end

end