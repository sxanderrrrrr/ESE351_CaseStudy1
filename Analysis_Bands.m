%% Analyzing 10 Band Frequency Output

% Analysis_Bands visualizes the 10 frequency bands and their respective
% frequencies. This file also includes the FFT and spectrogram of the audio
% file after passing through the filter. 

close all; 
 
%  soundSpec = frequencyParse10(sounddata, Fs); 
%  
%  t = 0:1/Fs:(length(sounddata)-1)/Fs; 
%     
%     sounddata = sounddata'; 

    f = [20,  40        %   Deep Bass - Preset 1
         40,  80;       %   Low Bass - Preset 2
         80,  160;      %   Mid Bass - Preset 3
        160,  300;      %   Upper Bass - Preset 4
        300,  500;      %   Lower Mid-Range - Preset 5
        500,  1500;     %   Middle Mid-Range - Preset 6
        1500, 2400;     %   Upper Mid-Range - Preset 7
        2400, 5000;     %   Pressure Range - Preset 8
        5000, 10000;    %   High End - Preset 9
        10000, 20000];   %   Extremely High End - Preset 10

    R = 1000;           %   Resistance

    CL = [];            %   Array for Lowpass Capacitances

% LPF Capacitance

    for i = 1:length(f(:,2))
        cl = 1/(2.*pi.*f(i,2).*R);
        CL = cat(1,CL,cl);
    end
   
    C = CL;

    TAU = R.*C;

% Coefficients

    B = [];
    A = [];

    for i = 1:length(f(:,1))
        b = [0 1./TAU(i,1)];
        a = [1 1./TAU(i,1)];
        B = cat(1,B,b);
        A = cat(1,A,a);
    end

    soundSpec = [];

    H = 0;
    hh = [];
    
    for k = 1:length(f(:,1))
        h = freqs(B(k,:), A(k,:), 0:2.*pi*44100);
        H = H + h;
        hh = cat(1, hh, h); 
        figure("Name", " Frequency Band " + k);
        subplot(2,1,1), plot(0:2.*pi*44100, 20*log10(abs(h))), xlabel('Frequency (rad/s)'), ylabel("Magnitude");
        subplot(2,1,2), plot(0:2.*pi*44100, angle(h)), xlabel('Frequency (rad/s)'), ylabel("Angle");
        sgtitle("Frquency Band " + k);
        for i = 1:2, subplot(2,1,i), set(gca,'XScale','log'), 
            axis tight, 
        end 
    end
    
    figure("Name", " Total Response ");
    subplot(2,1,1), plot(0:2.*pi*44100, 20*log10(abs(H))), xlabel('Frequency rad/s)'), ylabel("Magnitude");
    subplot(2,1,2), plot(0:2.*pi*44100, angle(H)), xlabel('Frequency rad/s)'), ylabel("Angle");
    sgtitle("Total Response");
    for i = 1:2, subplot(2,1,i), set(gca,'XScale','log'), 
    axis tight, end

  %% Question 2B
    % Filter Out the Siren
    sirenMin = 3.*hh(1,:) + 3.*hh(2,:) + 1.*hh(3,:) + 0.00001.*hh(4,:) + 0.001.*hh(5,:)+... 
                   + 0.001.*hh(6,:) + 0.001.*hh(7,:) + 0.001.*hh(8,:) + 0.00001.*hh(9,:) + 0.00001.*hh(10,:); 
    
    figure("Name", "Siren Filter Bode Plot");
    subplot(2,1,1), plot(0:2.*pi*44100, 20*log10(abs(sirenMin))), xlabel('Frequency rad/s)'), ylabel("Magnitude");
    subplot(2,1,2), plot(0:2.*pi*44100, angle(sirenMin)), xlabel('Frequency rad/s)'), ylabel("Angle");
    sgtitle("Treble Gain");
    for i = 1:2, subplot(2,1,i), set(gca,'XScale','log'), 
    axis tight, end 

%% FFT of 10 Bands
Fs = 44100; 
f = [0:length(sirenMin)-1]*Fs/length(sirenMin);
    BANDS = fft(sirenMin); 
    figure, plot(f,abs(BANDS)); 
    xlabel('f, Hz')
    ylabel('|X(f)|')
    title('FFT of 10 Bands')

%% Spectrogram of Minimized Siren
    figure(); 
    title('Spectrogram of Minimized Siren'); 
    spectrogram(sirenMin(1,:),1024,200,1024,Fs);