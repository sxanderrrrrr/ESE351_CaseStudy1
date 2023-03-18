%% Dividing Frequencies into 10 Bands

% frequencyParse10 is modeled from frequencyParser. The only difference is
% that this system uses 10 lowpass filters with 10 different ranges of
% frequencies. 

function soundSpec = frequencyParse10(sounddata, Fs)
    
    t = 0:1/Fs:(length(sounddata)-1)/Fs; 
    
    sounddata = sounddata'; 

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

% LPF and HPF Capacitance

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
    
    for k = 1:length(f(:,1))
        for i = 1:2
            sys = tf(B(k,:), A(k,:)); 
            out = lsim(sys, sounddata(i,:),t);
            soundSpec = cat(2,soundSpec,out);
        end
    end
    
    soundSpec = soundSpec';
end

