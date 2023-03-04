%% Case Study 1
% Authors: Xander Schmit, Nicole Ejedimu, Mary Butler
% Collaborators:
% Date: 
% Work Log
% Who               When
% Xander & Nicole   02/28 10:45 am - 12:15 pm
% Xander, Mary, Nicole 02/03 2:30 - 5:00 pm
%% Constants

% Sampling Frequency
fs = 44100; % kHz

%% Treble range

% We are going to put LPF and HPF LTI systems in series to create a
% bandpass filter. We are going to select cutoff frequency such that the
% low end cut off and high end cut off keep treble frequencies at unity and
% attenuate other signals.

% The treble frequency fange is assume to be 5 kHz to 12 kHz.

% LPF Calculations

f_lpf = 24000;

R_lpf = 1000;

C_lpf = 1/(2.*pi.*f_lpf.*R_lpf);

tau_lpf = R_lpf.*C_lpf;

b_lpf = 1/tau_lpf;

a_lpf = [1 1/tau_lpf];

% HPF Calculations

f_hpf = 2500;

R_hpf = 1000;

C_hpf = 1/(2.*pi.*f_hpf.*R_hpf);

tau_hpf = R_hpf.*C_hpf;

b_hpf = [1 0];

a_hpf = [1 1/tau_hpf];

% System

a = [1 1./tau_hpf + 1./tau_lpf (1/tau_hpf).*(1/tau_lpf)];

b = [0 1/tau_lpf 0];

sys = tf(b,a);

bode(sys);

%% 

%Sampling rate.
delta_t = 1/44100; %Hz

%Time vector
t = 0:delta_t:15*tau_lpf;

% DT: Impulse

x_imp = zeros(size(t));

x_imp(1) = 1;

% DT: Capacitive load

h_c = filter(delta_t/tau_lpf,[1 (delta_t/tau_lpf)-1],x_imp);

% DT: Resistive Load

h_r = filter([1 -1],[1 (delta_t/tau_hpf)-1],x_imp);

h = conv(h_c,h_r);
figure()
stem(h);
