
% Sampling Frequency
fs = 44100; % kHz

%% Treble range

% We are going to put LPF and HPF LTI systems in series to create a
% bandpass filter. We are going to select cutoff frequency such that the
% low end cut off and high end cut off keep treble frequencies at unity and
% attenuate other signals.

% The treble frequency fange is assume to be 5 kHz to 12 kHz.

% LPF Calculations

f_lpf = 12000;

R_lpf = 1000;

C_lpf = 1/(2.*pi.*f_lpf.*R_lpf);% Online.

tau_lpf = R_lpf.*C_lpf;

b_lpf = 1/tau_lpf;

a_lpf = [1 1/tau_lpf];

% HPF Calculations

f_hpf = 5000;

R_hpf = 1000;

C_hpf = 1/(2.*pi.*f_hpf.*R_hpf);

tau_hpf = R_hpf.*C_hpf;

b_hpf = [1 0];

a_hpf = [1 1/tau_hpf];

% System

a = [1 1./tau_hpf + 1./tau_lpf (1/tau_hpf).*(1/tau_lpf)];

b = [0 1/tau_lpf 0];

freqs(b,a);

[sounddata, Fs] = audioread("sample-3s.mp3");

t = 0:1/Fs:(length(sounddata)-1)/Fs;

sound(sounddata, Fs);

%%
sounddata = sounddata';
%%

treble_test_1 = lsim(b,a,sounddata(1,:),t);

treble_test_2 = lsim(b,a,sounddata(2,:),t);

treble_test = cat(2,treble_test_1, treble_test_2);

sound(treble_test, Fs);
%%
freqs(b,a);

%%
a = conv(a,a);

b = conv(b,b);

treble_test_1 = lsim(b,a,sounddata(1,:)',t);

treble_test_2 = lsim(b,a,sounddata(2,:)',t);

treble_test = cat(2,treble_test_1, treble_test_2);

sound(treble_test, Fs);

%% Bass Range

% LPF Calculations
bass_lpf = 250;                     %bass lowpass frequency

bass_C_lpf = 1/(2.*pi.*bass_lpf.*R_lpf);

bass_tau_lpf = R_lpf.*bass_C_lpf; 

bass_b_lpf = 1/bass_tau_lpf;

bass_a_lpf = [1 1/bass_tau_lpf];


% HPF Calculations
bass_hpf = 20;                      %bass highpass frequency

bass_C_hpf = 1/(2.*pi.*bass_hpf.*R_hpf); 

bass_tau_hpf = R_hpf .* bass_C_hpf; 

bass_b_hpf = [1 0];

bass_a_hpf = [1 1/bass_tau_hpf];

% System
bass_a = [1 1./bass_tau_hpf + 1./bass_tau_lpf (1/bass_tau_hpf).*(1/bass_tau_lpf)];

bass_b = [0 1/bass_tau_lpf 0];

freqs(bass_b,bass_a);

%%
% Bass Test 
bass_test_1 = lsim(bass_b,bass_a,sounddata(1,:),t);

bass_test_2 = lsim(bass_b,bass_a,sounddata(2,:),t);

bass_test = cat(2,bass_test_1, bass_test_2);

sound(bass_test, Fs);







