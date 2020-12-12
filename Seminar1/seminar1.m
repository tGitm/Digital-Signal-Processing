note = @(w,n) cos(w * n) + 0.375 * cos(3 * w * n) + 0.581 * cos(5 * w * n) + 0.382 * cos(7 * w * n) + 0.141 * cos(9 * w * n) + 0.028 * cos(11 * w * n) + 0.009 * cos(13 * w * n);
Fs = 8000;

%notes
g = 392.00;
a = 440.00;
e = 329.63;
f = 349.23;
b = 493.88; 

%tables of notes and lenghts of notes
line1 = [g g a g];
line2 = [e e];
line3 = [g g a g];
line4 = [f f];
line5 = [g g a g];
line6 = [b b a];
line7 = [g g a f];
line8 = [e e];

%Ringaraja -> Slovenian children song
notes = [line1 line2 line3 line4 line5 line6 line7 line8];
len = [0.25 0.25 0.25 0.25 0.5 0.5 0.25 0.25 0.25 0.25 0.5 0.5 0.25 0.25 0.25 0.25 0.5 0.25 0.25 0.25 0.25 0.25 0.25 0.5 0.5];

toPlay = [];
playWithAdsr = [];

for k=1:numel(notes)
       if  len(k) == 0.25 
            w = 2 * pi * (notes(k)/Fs);
            n = 0:1999; %half of Fs
            toPlay = [toPlay note(w, n)];
    
       else
           w = 2 * pi * (notes(k)/Fs);
           n = 0:3999; %full Fs
           toPlay = [toPlay note(w, n)];
       end
    
        t = n/Fs; % time in seconds
        %Attack - The time it takes for the note to reach the maximum level
        A = linspace(0, 0.9, (length(note(w, n))*0.20)); 
        %Decay - The time it takes for the note to go from the maximum level to sustain level
        D = linspace(0.9, 0.9,(length(note(w, n))*0.0)); 
        %Sustain - The level while the note is held
        S = linspace(0.9, 0.9,(length(note(w, n))*0.70)); 
        %Release - The time it takes for the note to fall from the sustain level to zero when released
        R = linspace(0.9, 0,(length(note(w, n))*0.1)); 
        ADSR = [A D S R];

        a = zeros(size(note(w, n)));
        a(1:length(ADSR)) = ADSR;
        play = note(w, n).* a; %tone
        playWithAdsr = [playWithAdsr play]; %add to new table and play it later

end
      
            %plot result with ADSR
            figure;
            hold on;
            plot(t, play);
            xlabel 't[sec]:', ylabel 'Amplitude:') %axis([0 0.02 -1 1], add to report - with axis and without
            hold off;
      
soundsc(playWithAdsr, Fs)
