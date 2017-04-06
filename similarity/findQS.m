function [ qwaves, swaves ] = findQS( rrNumber,  waveData)
%% 查找一个波群的在R波两端的平坡起点
numOfR = length(rrNumber);
qwaves = zeros(1, numOfR);
swaves = zeros(1, numOfR);
for i = 1 : numOfR
    if i ~= 1
        qwaves(i) = rrNumber(i) - ceil((rrNumber(i) - rrNumber(i-1))/3);
    end
    if i ~= numOfR
        swaves(i) = rrNumber(i) + ceil((rrNumber(i+1) - rrNumber(i))/3);
    end
end
% for i = 1 : numOfR
%     if i ~= 1
%         lSearchLen = ceil((rrNumber(i) - rrNumber(i-1))/2);
%     else
%         lSearchLen = ceil(rrNumber(i)/2);
%     end
%     lenOfwindow = lSearchLen;
%     lVar = zeros(lSearchLen, 1);
%     for j=1 : lSearchLen
%         startPoint = rrNumber(i)-j + 1 ;
%         lVar(j) = var(waveData(startPoint - lenOfwindow: startPoint));
%     end
%     minLVar = realmax;
%     minLIndex = -1;
%     for j = 1 : lSearchLen
%         if minLVar > lVar(j)
%             minLVar = lVar(j);
%             minLIndex = j;
%         end
%     end
%     qwaves(i) = rrNumber(i)  - minLIndex;
% end
% 
% for i = 1 : numOfR
%     if i ~= numOfR
%         rSearchLen = ceil((rrNumber(i+1) - rrNumber(i))/2);
%     else
%         rSearchLen = ceil((length(waveData)-rrNumber(numOfR))/2);
%     end
%      lenOfwindow = rSearchLen;
%     rVar = zeros(rSearchLen, 1);
%     for j=1 : rSearchLen
%         startPoint = rrNumber(i) + j - 1;
%         rVar(j) = var(waveData(startPoint : startPoint + lenOfwindow));
%     end
%     minRVar = realmax;
%     minRIndex = -1;
%     for j = 1 : rSearchLen
%         if minRVar > rVar(j)
%             minRVar = rVar(j);
%             minRIndex = j;
%         end
%     end
%     swaves(i) = rrNumber(i)  + minRIndex;
% end
% end


