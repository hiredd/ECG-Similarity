%% 分析注释文件中的类别
anoFilesNumber = getAllFileNumber;
%% 计数
anoTypeMap = containers.Map();
for i =1:length(anoFilesNumber)
    [anoData, anoType] = loadAtrFile(anoFilesNumber(i));
    for j=1:length(anoType)
        anoTypeVal = anoType(j);
        anoTypeVal = char(anoTypeVal);
        if isKey(anoTypeMap, anoTypeVal)
            count = anoTypeMap(anoTypeVal) + 1;
        else
            count = 1;
        end
        anoTypeMap(anoTypeVal) =count;
    end
end
% 转换成矩阵
numOfType = length(anoTypeMap);
keysOfType = keys(anoTypeMap);
resultMatrix = cell(2, numOfType);
for i=1:numOfType
    key = keysOfType{i};
    resultMatrix{1, i} = key;
    key = char(key);
    resultMatrix{2, i} = anoTypeMap(key);
end
resultMatrixX = resultMatrix(1, :);
resultMatrixY = resultMatrix(2, :);
resultMatrixY = cell2mat(resultMatrixY);
%% 分析类别的注释
% datNumber = 108;
% typeName = 'j';
% [anoData, anoType] = loadAtrFile(datNumber);
% aTypeIndex = zeros(0, 1);
% for i=1:length(anoType)
%     if char(anoType(i)) == typeName
%         aTypeIndex(length(aTypeIndex)+1) = anoData(i);
%     end
% end
% [waveData, ~] = loadDatFile(datNumber);
% watchNumber = 3;
% watchLen =400;
% for i=1:length(aTypeIndex)
%     xaxisVal = aTypeIndex(i)-watchLen:aTypeIndex(i)+watchLen;
%     subplot(1, watchNumber, i), plot(xaxisVal, waveData(xaxisVal));
%     axis([xaxisVal(1) xaxisVal(length(xaxisVal)) -1 3]);
%     hold on
%     anoDataVal=waveData(aTypeIndex(i));
%     plot(aTypeIndex(i), waveData(aTypeIndex(i)), '+g');
%     hold off
%     if i == 3
%         break;
%     end
% end



