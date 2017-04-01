function [ qwaves, swaves ] = findQS( rrNumber,  waveData)
%% 查找一个波群的在R波两端的平坡起点
numOfR = length(rrNumber);
qwaves = zeros(1, numOfR);
swaves = zeros(1, numOfR);
minLenOfQRS = 5;
maxLenOfQRS = 35;
lenOfwindow = 10;
for i = 1 : numOfR
    %% 寻找左右平滑点
    searchLen = maxLenOfQRS - minLenOfQRS +1;
    lVar = zeros(searchLen, 1);
    rVar = zeros(searchLen, 1);
    for j=1:searchLen
        if i~=0
            startPoint = rrNumber(i)-minLenOfQRS-j;
            lVar(j) = var(waveData(startPoint - lenOfwindow: startPoint));
        end
        if i~=searchLen
            startPoint = rrNumber(i)+minLenOfQRS+j;
            rVar(j) = var(waveData(startPoint: startPoint + lenOfwindow));
        end
    end
    minLVar = realmax;
    minLIndex = -1;
    minRVar = realmax;
    minRIndex = -1;
    for j=1:searchLen
        if minLVar > lVar(j)
            minLVar = lVar(j);
            minLIndex = j;
        end
        if minRVar > lVar(j)
            minRVar = lVar(j);
            minRIndex = j;
        end
    end
    qwaves(i) = rrNumber(i) - minLenOfQRS -minLIndex;
    swaves(i) = rrNumber(i) + minLenOfQRS + minRIndex;
end
end


