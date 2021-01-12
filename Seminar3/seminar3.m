%task1
[read,fs] = audioread('1.danes_je_lep_dan_klarinet_22050.wav');
N = length(read);
f = (0:(N-1))/N*fs;
ftx = fft(read);
figure; plot(f,abs(ftx));
title('Amplitude Spectrum of the audio signal'); 
xlabel ('Frequency[Hz]'); 
ylabel('Amplitude'); 

Fs = 22050;          


%task2
%uporabim stopband filter na zvoku
out = filter(filterF(420, 430, 450, 460, .5,  60, 1, Fs, 'stopband'),read); 

out2 = filter(filterF(1300, 1310, 1330, 1340, .5,  60, 1, Fs, 'stopband'),out);

out3 = filter(filterF(2000, 2100, 2300, 2400, .5,  60, 1, Fs, 'stopband'),out2);

out4 = filter(filterF(3060, 3070, 3090, 3100, .5,  60, 1, Fs, 'stopband'),out3); 

out5 = filter(filterF(3940, 3950, 3970, 3980, .5,  60, 1, Fs, 'stopband'),out4); 

out6 = filter(filterF(4820, 4830, 4850, 4860, .5,  60, 1, Fs, 'stopband'),out5); 

%zaigra filtriran zvok
sound(out6,Fs); 
%zapiše novo filtrirano datoteko
audiowrite('izhod.wav',out6,Fs);



%fft za pretvorbo originalnega zvoka
firstTransform = fft(read); 
firstTransform = firstTransform(1:N/2+1); 
%naredim vector frekvence za izris podatkov
f0 = 0:fs/N:fs/2;
figure; hold on;
plot(f0,abs(firstTransform)); 

[read1,fs1] = audioread('izhod.wav');
N1 = length(read1);
%fft za pretvorbo originalnega zvoka
secondTransform = fft(read1);  
secondTransform = secondTransform(1:N1/2+1);
%naredim vector frekvence za izris podatkov
f1 = 0:fs1/N1:fs1/2;
plot(f1,abs(secondTransform)); 
title('Amplitude Spectrum after aplying Band Stop Filter'); 
xlabel ('Frequency[Hz]'); ylabel('Amplitude'); grid on; 
hold off;

function Hd = filterF(Fpass1, Fstop1, Fstop2, Fpass2, Apass1, Astop, Apass2, Fs, match)
    h  = fdesign.bandstop(Fpass1, Fstop1, Fstop2, Fpass2, Apass1, Astop, Apass2, Fs);
    Hd = design(h, 'butter', 'MatchExactly', match); 
end
