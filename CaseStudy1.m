%% Case Study 1
% Authors: Xander Schmit, Nicole Ejedimu, Mary Butler
% Collaborators:
% Date: 
% Work Log
% Who               When
% Xander & Nicole   02/28 10:45 am
%% Constants

% Sampling Frequency
fs = 44100; % kHz

%% Treble boost

% We are going to put LPF and HPF LTI systems in series to create a
% bandpass filter. We are going to select cutoff frequency such that the
% low end cut off and high end cut off keep treble frequencies at unity and
% attenuate other signals.

% The treble frequency fange is assume to be 5 kHz to 12 kHz.

% LPF Calculations

f_lpf = 12000;

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

