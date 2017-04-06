function [ cutedWaveData ] = cutWave( waveData, distQRSWave, distIndex, qwaves, swaves )
%把波形切成一个个qrs波群
lenOfPWave = qwaves(distIndex)-distQRSWave(1);
lenOfTWave = distQRSWave(length(distQRSWave))-swaves(distIndex);
cutedWaveData = {length(qwaves)};
for i=1:length(qwaves)
    startOfWave = max(qwaves(i) - lenOfPWave, 1);
    endOfWave = min(swaves(i) + lenOfTWave, length(waveData));
    cutedWaveData{i} = startOfWave:endOfWave;
end
end

