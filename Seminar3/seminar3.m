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
out = filter(filterF(420, 430, 450, 460, .5,  60, 1, Fs, 'stopband'),read); %applies band stop filter to the audio

out2 = filter(filterF(1300, 1310, 1330, 1340, .5,  60, 1, Fs, 'stopband'),out); %applies band stop filter to the audio

out3 = filter(filterF(200, 210, 230, 240, .5,  60, 1, Fs, 'stopband'),out2); %applies band stop filter to the audio

out4 = filter(filterF(3060, 3070, 3090, 3100, .5,  60, 1, Fs, 'stopband'),out3); %applies band stop filter to the audio

out5 = filter(filterF(3940, 3950, 3970, 3980, .5,  60, 1, Fs, 'stopband'),out4); %applies band stop filter to the audio

out6 = filter(filterF(4820, 4830, 4850, 4860, .5,  60, 1, Fs, 'stopband'),out5); %applies band stop filter to the audio

sound(out6,Fs); %plays filtered audio file
audiowrite('izhod.wav',out6,Fs); %writes the newly filtered audio file as a new file



%applies the fourier transform to the audio
firstTransform = fft(read);  %fft to transform the original signal into frequency domain 
% dft1 has even length 
firstTransform = firstTransform(1:N/2+1); %we need half of that singal because we dont nek
f0 = 0:fs/N:fs/2; % create a frequency vector for plot
figure; hold on;
plot(f0,abs(firstTransform)); 

[read1,fs1] = audioread('izhod.wav');
N1 = length(read1);
secondTransform = fft(read1);  %fft to transform the original signal into frequency domain 
secondTransform = secondTransform(1:N1/2+1); %we need half of that singal because we dont nek
f1 = 0:fs1/N1:fs1/2; % create a frequency vector for plot
plot(f1,abs(secondTransform)); 
title('Amplitude Spectrum of the audio signal after aplying Band Stop Filter'); 
xlabel ('Frequency[Hz]'); ylabel('Amplitude'); grid on; 
hold off;

function Hd = filterF(Fpass1, Fstop1, Fstop2, Fpass2, Apass1, Astop, Apass2, Fs, match)
    h  = fdesign.bandstop(Fpass1, Fstop1, Fstop2, Fpass2, Apass1, Astop, Apass2, Fs);
    Hd = design(h, 'butter', 'MatchExactly', match); 
end 