%% Case Study 1: System response analysis

% Creating a for loop to create a freqs plot for lower bass, ..., treble
% responses. It takes the coefficients B and A for each system and makes a
% plot.

%% Question 2A

 % We are going to put LPF and HPF LTI systems in series to create a
    % bandpass filter. We are going to select cutoff frequency such that the
    % low end cut off and high end cut off keep treble frequencies at unity and
    % attenuate other signals.

    % The treble frequency range is assume to be 6 kHz to 20 kHz.

    % LPF Calculations

    % f is frequency ranges in Hz. 
    % Each row is a diff range.

    close all;

    f = [5,  250            % Sub-Bass 
        250, 500;           % Bass
        500, 2000;          % Midrange
        2000, 6000;         % Higher Midrange
        6000, 20000];       % Treble
    
    % We fix resistance and solve capacitance based off of the cut off
    % frequencies of the different ranges

    R = 1000;

    % Array that contains the capacitance values for the LPF and HPF.
    
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

    H = 0;
    hh = [];

    for k = 1:length(f(:,1))
        h = freqs(B(k,:), A(k,:), 0:2.*pi*44100);
        hh = cat(1,hh,h);
        H = H + h;
        figure("Name", "Frequency Band " + k);
        subplot(2,1,1), plot(0:2.*pi*44100, 20*log10(abs(h))), xlabel('Frequency (rad/s)'), ylabel('Magnitude');
        subplot(2,1,2), plot(0:2.*pi*44100, angle(h)), xlabel('Frequency (rad/s)'), ylabel('Phase');
        sgtitle("Frequency Band " + k);
        for i = 1:2, subplot(2,1,i), set(gca,'XScale','log'), 
        axis tight, end 
    end

    figure("Name", " Total Response");
    subplot(2,1,1), plot(0:2.*pi*44100, 20*log10(abs(H))), xlabel('Frequency (rad/s)'), ylabel('Magnitude');
    subplot(2,1,2), plot(0:2.*pi*44100, angle(H)), xlabel('Frequency (rad/s)'), ylabel('Phase');
    sgtitle("Total Response");
    for i = 1:2, subplot(2,1,i), set(gca,'XScale','log'), 
    axis tight, end 

%% Question 2B

%% Treble gain
profilerOutput = hh(1, :) + 0.7.*hh(2, :) + 0.0006.*hh(3, :) + 2.*hh(4, :) + 5.*hh(5, :);

figure("Name", "Treble Boost Preset Frequency Response");
    subplot(2,1,1), plot(0:2.*pi*44100, 20*log10(abs(profilerOutput))), xlabel('Frequency (rad/s)'), ylabel('Magnitude');
    subplot(2,1,2), plot(0:2.*pi*44100, angle(profilerOutput)), xlabel('Frequency (rad/s)'), ylabel('Phase');
    sgtitle("Treble Boost Frequency Response");
    for i = 1:2, subplot(2,1,i), set(gca,'XScale','log'), 
    axis tight, end 

%% Bass gain
profilerOutput =  1.*hh(1, :) + 5.*hh(2, :) + 1.*hh(3, :) + 0.1.*hh(4, :) + 1.*hh(5, :);

figure("Name", "Bass Boost Preset Frequency Response");
    subplot(2,1,1), plot(0:2.*pi*44100, 20*log10(abs(profilerOutput))), xlabel('Frequency (rad/s)'), ylabel('Magnitude');
    subplot(2,1,2), plot(0:2.*pi*44100, angle(profilerOutput)), xlabel("Frequency (rad/s)"), ylabel("Phase");
    sgtitle("Bass Boost Frequency Response");

    for i = 1:2, subplot(2,1,i), set(gca,'XScale','log'), 
    axis tight, end 

%% Unity gain
profilerOutput = 1.*hh(1, :) + 0.6.*hh(2, :) + 0.6.*hh(3, :) + 0.8.*hh(4, :) + 0.7.*hh(5, :);

figure("Name", "Unity Preset Frequency Response");
    subplot(2,1,1), plot(0:2.*pi*44100, 20*log10(abs(profilerOutput))), xlabel('Frequency (rad/s)'), ylabel('Magnitude');
    subplot(2,1,2), plot(0:2.*pi*44100, angle(profilerOutput)), xlabel('Frequency (rad/s)'), ylabel('Phase');
    sgtitle("Unit Frequency Response");
    for i = 1:2, subplot(2,1,i), set(gca,'XScale','log'), 
    axis tight, end 

%% Custom Preset for Blue in Green with Siren
profilerOutput = 2.*hh(1, :) + 0.5.*hh(2, :) + 0.001.*hh(3, :) + 0.001.*hh(4, :) + 1.3.*hh(5, :);

figure("Name", "Filtering Out the Siren Preset");
    subplot(2,1,1), plot(0:2.*pi*44100, 20*log10(abs(profilerOutput))), xlabel('Frequency (rad/s)'), ylabel('Magnitude');
    subplot(2,1,2), plot(0:2.*pi*44100, angle(profilerOutput)), xlabel('Frequency (rad/s)'), ylabel('Phase');
    sgtitle("Filtering Out Siren Frequency Response");
    for i = 1:2, subplot(2,1,i), set(gca,'XScale','log'), 
    axis tight, end 

%% Custom Preset
profilerOutput = 2.*hh(1, :) + 0.001.*hh(2, :) + 0.001.*hh(3, :) + 0.001.*hh(4, :) + 2.*hh(5, :);

figure("Name", " Custom Preset Frequency Response");
    subplot(2,1,1), plot(0:2.*pi*44100, 20*log10(abs(profilerOutput))), xlabel('Frequency (rad/s)'), ylabel('Magnitude');
    subplot(2,1,2), plot(0:2.*pi*44100, angle(profilerOutput)), xlabel('Frequency (rad/s)'), ylabel('Phase');;
    sgtitle("Custom Preset Frequency Response");
    for i = 1:2, subplot(2,1,i), set(gca,'XScale','log'), 
    axis tight, end 

%% Question 2C
close all;

t = 0: 1/44100:1;
x = zeros(size(t));
x(1) = 1;

for k = 1:length(f(:,1))
    result = lsim(B(k,:), A(k,:), x, t);
    figure("Name", " Impulse response for freq range " + k);
    plot(t(1:20), result(1:20)), xlabel("Time (seconds)");
end

%% Question 2D

t = 0: 1/44100:1;
x = zeros(size(t));
x(1) = 1;

A = sum(A); 
B = sum(B); 

total_response = lsim(B, A, x, t); 
figure(); 
plot(t, total_response); 