%%检查负的R
minVal = min(anoDataVal);
maxVal = max(anoDataVal);
negtiveValIndex = find(anoDataVal<0);
negtiveIndex = anoData(negtiveValIndex);
figure(1)
observeLen = 400;
plot((negtiveIndex-observeLen:negtiveIndex+observeLen), waveData(negtiveIndex-observeLen:negtiveIndex+observeLen));
title(['负的注释R值: ', num2str(negtiveIndex)]);
%%异常R值检查
i = 1;
j = 1;
abnormalAtrCount = 1;
abnormalRCount = 1;
while i <length(anoData) && j<length(rwaves)
    x = anoData(i);
    y = rwaves(j);
    if abs(x-y)<10
        i = i+1;
        j = j+1;
    elseif x < y
        abnormalAtr(abnormalAtrCount) = i;
        abnormalAtrCount = abnormalAtrCount +1;
        i = i+1;
    else
        abnormalR(abnormalRCount) = j;
        abnormalRCount = abnormalRCount +1;
        j = j+1;
    end
end
figure(2)
numOfAbAtr = length(abnormalAtr);
numOfAbR = length(abnormalR);
colNum = 3 ;
observeLen= 200;
rowNum =ceil((numOfAbAtr + numOfAbR) /colNum);
for i=1 : numOfAbAtr;
    %防止区间超出
    startIndex =max([abnormalAtr(i)-observeLen, 1]);
    endIndex = min([abnormalAtr(i)+observeLen, length(waveData)]);
    subplot(rowNum, colNum, i), plot(startIndex:endIndex, waveData(startIndex:endIndex));
    title(['Abnormal Atr: ', num2str(abnormalAtr(i))]);
end

for i=1 : length(abnormalR);
    startIndex =max([abnormalR(i)-observeLen, 1]);
    endIndex = min([abnormalR(i)+observeLen, length(waveData)]);
    subplot(rowNum, colNum, i+numOfAbAtr), plot(startIndex:endIndex, waveData(startIndex:endIndex));
    title(['Abnormal R: ', num2str(abnormalR(i))]);
end

%记录：
%文件100的注释中有两个错误标注，分别为1、1908
norAnoData = anoData;
for i= 1:length(abnormalAtr)
    norAnoData(:, i) = [];
end

minAnoVal = min(waveData(norAnoData))
maxAnoVal = max(waveData(norAnoData))

