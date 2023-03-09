%% Case Study 1: System response analysis

% Creating a for loop to create a freqs plot for lower bass, ..., treble
% responses. It takes the coefficients B and A for each system and makes a
% plot.


% Question 2 a

 % We are going to put LPF and HPF LTI systems in series to create a
    % bandpass filter. We are going to select cutoff frequency such that the
    % low end cut off and high end cut off keep treble frequencies at unity and
    % attenuate other signals.

    % The treble frequency range is assume to be 6 kHz to 20 kHz.

    % LPF Calculations

    % f is frequency ranges in Hz. 
    % Each row is a diff range.

    close all;

    f = [5,  250 %    Sub-Bass 
        250, 500; %    Bass
        500, 2000; %   Midrange
        2000, 6000; %  Higher Midrange
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
%     A_1 = [];
%     B_1 = [];

    for i = 1:length(f(:,1))
        b = [0 1./TAU(i,1) 0];
        %b_1 = conv(b,b);
        a = [1 1./TAU(i,1) + 1./TAU(i,2) (1/TAU(i,1)).*(1/TAU(i,2))];
        %a_1 = conv(a,a);
        B = cat(1,B,b);
        A = cat(1,A,a); 
%         B_1 = cat(1,B_1,b_1);
%         A_1 = cat(1,A_1,a_1);
    end

   
    

    % soundSpectrum contains the outputs of the sounddata after being sent
    % through each bandpass filter.

    soundSpectrum = [];

    H = 0;
    hh = [];
    %hh_1 = [];

    for k = 1:length(f(:,1))
        h = freqs(B(k,:), A(k,:), 0:2.*pi*44100);
        %h_1 = freqs(B_1(k,:), A_1(k,:), 0:2.*pi*44100);
        hh = cat(1,hh,h);
       % hh_1= cat(1,hh_1,h);
        H = H + h;
        figure("Name", " Preset" + k);
        subplot(2,1,1), plot(0:2.*pi*44100, 20*log10(abs(h)));
        subplot(2,1,2), plot(0:2.*pi*44100, angle(h));
        sgtitle("Preset" + k);
        for i = 1:2, subplot(2,1,i), set(gca,'XScale','log'), 
        axis tight, end 
    end

    figure("Name", " Total Response");
    subplot(2,1,1), plot(0:2.*pi*44100, 20*log10(abs(H)));
    subplot(2,1,2), plot(0:2.*pi*44100, angle(H));
    sgtitle("Total Response");
    for i = 1:2, subplot(2,1,i), set(gca,'XScale','log'), 
    axis tight, end 
%% Question 2b

% % Treble gain
% %profilerOutput1 = hh_1(1, :) + hh_1(2, :) + hh_1(3, :) + hh_1(4, :) + 5.*hh_1(5, :);
% profilerOutput = hh(1, :) + 0.7.*hh(2, :) + 0.0006.*hh(3, :) + 2.*hh(4, :) + 5.*hh(5, :);
% 
% figure("Name", " Total Response");
%     subplot(2,1,1), plot(0:2.*pi*44100, 20*log10(abs(profilerOutput)));
%     subplot(2,1,2), plot(0:2.*pi*44100, angle(profilerOutput));
% %     subplot(2,2,3), plot(0:2.*pi*44100, 20*log10(abs(profilerOutput1)));
% %     subplot(2,2,4), plot(0:2.*pi*44100, angle(profilerOutput1));
%     sgtitle("Total Response for treble");
%     for i = 1:2, subplot(2,1,i), set(gca,'XScale','log'), 
%     axis tight, end 
% 
% % Bass gain
% profilerOutput =  1.*hh(1, :) + 5.*hh(2, :) + 1.*hh(3, :) + 0.1.*hh(4, :) + 1.*hh(5, :);
% 
% figure("Name", " Total Response ");
%     subplot(2,1,1), plot(0:2.*pi*44100, 20*log10(abs(profilerOutput)));
%     subplot(2,1,2), plot(0:2.*pi*44100, angle(profilerOutput));
%     sgtitle("Total Response for bass");
%     for i = 1:2, subplot(2,1,i), set(gca,'XScale','log'), 
%     axis tight, end 
% 
% % Unity gain
% profilerOutput = 1.*hh(1, :) + 0.6.*hh(2, :) + 0.6.*hh(3, :) + 0.8.*hh(4, :) + 0.7.*hh(5, :);
% 
% figure("Name", " Total Response");
%     subplot(2,1,1), plot(0:2.*pi*44100, 20*log10(abs(profilerOutput)));
%     subplot(2,1,2), plot(0:2.*pi*44100, angle(profilerOutput));
%     sgtitle("Total Response for unity");
%     for i = 1:2, subplot(2,1,i), set(gca,'XScale','log'), 
%     axis tight, end 

% Custom preset
profilerOutput = 2.*hh(1, :) + 0.5.*hh(2, :) + 0.001.*hh(3, :) + 0.001.*hh(4, :) + 1.3.*hh(5, :);

figure("Name", " Total Response");
    subplot(2,1,1), plot(0:2.*pi*44100, 20*log10(abs(profilerOutput)));
    subplot(2,1,2), plot(0:2.*pi*44100, angle(profilerOutput));
    sgtitle("Total Response for preset");
    for i = 1:2, subplot(2,1,i), set(gca,'XScale','log'), 
    axis tight, end 


%% Question 2 c

close all;

t = 0: 1/44100:1;
x = zeros(size(t));
x(1) = 1;

for k = 1:length(f(:,1))
    result = lsim(B(k,:), A(k,:), x, t);
    figure("Name", " Impulse response for freq range " + k);
    plot(t(1:20), result(1:20)), xlabel("Time (seconds)");
end
