function [ similarities, cutedWaveData ] = countAllSimilaritiesAgainstQRSWave( distQRSWave, waveData )
%计算和源查找S波形
[qwaves, rwaves, swaves] = findQRS(waveData);
[distIndex] = findIndexOfWave(distQRSWave, rwaves);
[cutedWaveData] = cutWave(waveData, distQRSWave, distIndex, qwaves, swaves);
numOfQRSwave = length(rwaves);
distQRS = zeros(1, numOfQRSwave);
distP = zeros(1, numOfQRSwave);
distT= zeros(1, numOfQRSwave);
for i = 1:numOfQRSwave
    distQRS(i) = countDistanceOfTwoQRSWave(distIndex, i, waveData, qwaves, rwaves, swaves);
    distP(i) = countDistanceOfTwoPWave(distQRSWave, distIndex, i, waveData, qwaves);
    distT(i) = countDistanceOfTwoTWave(distQRSWave, distIndex, i, waveData, swaves);
end
distQRS = scallingDistance(distQRS);
distP= scallingDistance(distP);
similarities = (distQRS + distP + distT)/3;
end

function [waveIndex] = findIndexOfWave(wave, rwaves)
%查找一个sqr波在心电图中属于第几个qrs
numOfQRSwave = length(rwaves);
for i = 1:numOfQRSwave
    if wave(1)<rwaves(i) && wave(length(wave))>rwaves(i)
        waveIndex = i;
        return;
    end
end
end

function [dist] = countDistanceOfTwoQRSWave(wave1Index, wave2Index, waveData, qwaves, rwaves, swaves)
%使用欧式距离计算两个波的距离
risetime1 = rwaves(wave1Index) - qwaves(wave1Index);
risetime2 = rwaves(wave2Index) - qwaves(wave2Index);
falltime1 = swaves(wave1Index) - rwaves(wave1Index);
falltime2 = swaves(wave2Index) - rwaves(wave2Index);
riselevel1 = waveData(rwaves(wave1Index))-waveData(qwaves(wave1Index));
riselevel2 = waveData(rwaves(wave2Index))-waveData(qwaves(wave2Index));
falllevel1 = waveData(swaves(wave1Index))-waveData(rwaves(wave1Index));
falllevel2 = waveData(swaves(wave2Index))-waveData(rwaves(wave2Index));
X=[risetime1, riselevel1, falltime1, falllevel1;risetime2, riselevel2, falltime2, falllevel2];
dist = pdist(X);
end

function [dist] = countDistanceOfTwoPWave(wave1, wave1Index, wave2Index, waveData, qwaves)
%使用dwt计算P-R段的距离
startOfWave1 = wave1(1);
endOfWave1 = qwaves(wave1Index);%
startOfWave2 = qwaves(wave2Index)-(endOfWave1-startOfWave1);
startOfWave2 = max(startOfWave2, 1);
endOfWave2 = qwaves(wave2Index);
dist = dtw(waveData(startOfWave1:endOfWave1), waveData(startOfWave2:endOfWave2));
end

function [dist] = countDistanceOfTwoTWave(wave1, wave1Index, wave2Index, waveData, swaves)
%使用dwt计算Q-T段的距离
startOfWave1 = swaves(wave1Index);
endOfWave1 = wave1(length(wave1));
startOfWave2 = swaves(wave2Index);
endOfWave2 = swaves(wave2Index)+(endOfWave1-startOfWave1);
endOfWave2 = min([endOfWave2, length(waveData)]);
dist = dtw(waveData(startOfWave1:endOfWave1), waveData(startOfWave2:endOfWave2));
end

function [dist] = scallingDistance(dist)
%转换成[0,1]区间的距离
maxVal = max(dist);
for i=1:length(dist)
    dist(i) = dist(i)/maxVal;
end
end
