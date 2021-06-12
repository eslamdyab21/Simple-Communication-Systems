clc
clear

% read the sound file and play it
[xin ,fs] = audioread('dawn of faith.mpeg');
sound(xin,fs);

% asking for the value of segma
fprintf('please enter the number of impulseResponse:\nType 1 for H1\nType 2 for H2\nType 3 for H3\nType 4 for H4\n');
impulseResponse = input('The number= ');

sigma=input('please enter the value of sigma: ');

% geting number of channels
channelsNum = size(xin(:,1));
channelsNum = channelsNum(2);

% empty vector to concatinate the channels in it
finalOutputSignal = zeros(length(xin),channelsNum);
finalNoiseySignal = zeros(length(xin),channelsNum);

i=1;
while (i <= channelsNum)
    [outputSignal,noiseSignal] = communicationSystem(xin(:,1),fs,sigma,i,impulseResponse);
    finalOutputSignal(:,i) = outputSignal;
    finalNoiseySignal(:,i) = noiseSignal;
    
    i = i+1;
end


% play output sound file 
sound(finalNoiseySignal,fs);
pause(25);

%play output sound file 
sound(finalOutputSignal,fs);
audiowrite('out.wav', finalOutputSignal, fs);