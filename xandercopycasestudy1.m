%% Case Study 1
% Authors: Xander Schmit, Nicole Ejedimu, Mary Butler
% Collaborators:
% Date: 
% Work Log
% Who               When
% Xander & Nicole   02/28 10:45 am - 12:15 pm
% Xander, Mary, Nicole 02/03 2:30 - 5:00 pm
% Xander, Mary, Nicole 02/04 10 am - 1:00 pm

%% Treble range

% We are going to put LPF and HPF LTI systems in series to create a
% bandpass filter. We are going to select cutoff frequency such that the
% low end cut off and high end cut off keep treble frequencies at unity and
% attenuate other signals.

% The treble frequency fange is assume to be 6 kHz to 20 kHz.

% LPF Calculations

% f is frequency ranges. Each row is a diff range. EX row 1 is bass 20 to
% 250 Hz.

f = [20,  250; 
    250, 10000;
    10000, 20000];

R = 1000;

CL = [];

% LPF Capacitance
for i = 1:length(f(:,2))
    c = 1/(2.*pi.*f(i,2).*R);
    CL = cat(1,CL,c);
end

% HPF Capacitance
CH = [];

for i = 1:length(f(:,1))
    c = 1/(2.*pi.*f(i,1).*R);
    CH = cat(1,CH,c);
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

%% Trying out gain

[sounddata, Fs] = audioread('Space Station - Treble Cut.wav');

t = 0:1/Fs:(length(sounddata)-1)/Fs;

sounddata = sounddata';

treble = [];

bass = [];

midrange = [];

for i = 1:2
    out = lsim(B(3,:), A(3,:), sounddata(i,:),t);
    treble = cat(2,treble,out);
end

treble = treble';

for i = 1:2
    out = lsim(B(2,:), A(2,:), sounddata(i,:),t);
    midrange = cat(2,midrange,out);
end

midrange = midrange';

for i = 1:2
    out = lsim(B(1,:), A(1,:), sounddata(i,:),t);
    bass = cat(2,bass,out);
end

bass = bass';
% 1 - bass, 2 - midrange, 3 - treble
Gain = [0.1 0 0];

output = (Gain(1,1).*bass) + (Gain(1,2).*midrange) + (Gain(1,3).*treble);
%% 

H = [];
W = [];
x_freqs = 2.*pi.*(0:length(sounddata(1,:))-1).*Fs./length(sounddata(1,:));
for i = 1:length(f(:,1))
    [h, w] = freqs(B(i,:),A(i,:), x_freqs);
    H = cat(1,H,h);
    W = cat(1,W,w);
end

%%

figure();
hold on;
semilogx(abs(H(1,:))),semilogx(abs(H(2,:))),semilogx(abs(H(3,:)));
hold off;

%% Analyzing The Input Signal

Input_FFT = fft(sounddata(1,:))./(1/Fs);

x_freqs = (0:length(sounddata(1,:))-1).*Fs./length(sounddata(1,:));
%%
figure()
plot(x_freqs, abs(fft(output(1,:))./(1/Fs)));
%%
figure();
plot(x_freqs, abs((Input_FFT)));

%% 
x_freqs = (0:length(sounddata(1,:))-1).*Fs./length(sounddata(1,:));
figure();

plot(x_freqs, abs(fft(treble(1,:))));

%%
x_freqs = (0:length(sounddata(1,:))-1).*Fs./length(sounddata(1,:));


b = [1 0];

a = [1 1/TAU(3,1)];

g = lsim(b,a,sounddata(1,:),t);

figure();

plot(x_freqs, abs(fft(g)./(1./Fs)));

