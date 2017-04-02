function [ qwaves, swaves ] = findQS( rrNumber,  waveData)
%% 查找一个波群的在R波两端的平坡起点
numOfR = length(rrNumber);
qwaves = zeros(1, numOfR);
swaves = zeros(1, numOfR);
lenOfwindow = 10;
for i = 1 : numOfR
    if i ~= 1
        lSearchLen = ceil((rrNumber(i) - rrNumber(i-1))/3);
    else
        lSearchLen = min(100, rrNumber(1)-2*lenOfwindow);
    end
    lVar = zeros(lSearchLen, 1);
    for j=1 : lSearchLen
        startPoint = rrNumber(i)-j;
        lVar(j) = var(waveData(startPoint - lenOfwindow: startPoint));
    end
    minLVar = realmax;
    minLIndex = -1;
    for j = 1 : lSearchLen
        if minLVar > lVar(j)
            minLVar = lVar(j);
            minLIndex = j;
        end
    end
    qwaves(i) = rrNumber(i)  - minLIndex;
end

for i = 1 : numOfR
    if i ~= numOfR
        rSearchLen = ceil((rrNumber(i+1) - rrNumber(i))/3);
    else
        rSearchLen = min(100, length(waveData)-rrNumber(numOfR)-2*lenOfwindow);
    end
    rVar = zeros(rSearchLen, 1);
    for j=1 : rSearchLen
        startPoint = rrNumber(i) + j;
        rVar(j) = var(waveData(startPoint : startPoint + lenOfwindow));
    end
    minRVar = realmax;
    minRIndex = -1;
    for j = 1 : rSearchLen
        if minRVar > rVar(j)
            minRVar = rVar(j);
            minRIndex = j;
        end
    end
    swaves(i) = rrNumber(i)  + minRIndex;
end
end


