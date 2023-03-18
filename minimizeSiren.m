% minimizeSiren creates a siren preset that completely filters out the
% siren from the audio. If the user specifies that noSiren = 1, then
% the function will output the Blue in Green with Siren audio file with a 
% minimized siren. 

% This function is an extended model of the soundProfiler function that
% includes 10 frequency bands instead of 5. 

function sirenMin = minimizeSiren(noSiren, sounddata, Fs)

     soundSpec = frequencyParser(sounddata,Fs);

     if noSiren == 1 
         sirenMin = 1.*soundSpec(1,:) + 1.*soundSpec(2,:) + 0.001.*soundSpec(3,:) + 0.001.*soundSpec(4,:) + 0.001.*soundSpec(5,:)+... 
               + 0.001*soundSpec(6,:) + 0.001.*soundSpec(7,:) + 0.001.*soundSpec(8,:) + 1.*soundSpec(9,:) + 1.*soundSpec(10,:);

     end
end