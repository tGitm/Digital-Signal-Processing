[y1,Fs1] = audioread('Man_scream.wav');
[y2,Fs2] = audioread('Female_scream.wav');
[y3,Fs3] = audioread('danced_with_devil.wav');
[y4,Fs4] = audioread('born_yesterday.wav');
%sound(y1, Fs1);

stft(y1,Fs1,'Window',kaiser(256,5),'OverlapLength',220,'FFTLength',512);
%stft(y2,Fs2,'Window',kaiser(256,5),'OverlapLength',220,'FFTLength',512);
%stft(y3,Fs3,'Window',kaiser(256,5),'OverlapLength',220,'FFTLength',512);
%stft(y4,Fs4,'Window',kaiser(256,5),'OverlapLength',220,'FFTLength',512);




