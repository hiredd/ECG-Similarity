fileNumber = getAllFileNumber();

%% 计数
rrTypeMap = containers.Map();
for i =1:length(fileNumber)
   [intervalTime, rrType] = loadRRFile(fileNumber(i));
    for j=1:length(rrType)
        rrTypeVal = rrType(j);
        rrTypeVal = char(rrTypeVal);
        if isKey(rrTypeMap, rrTypeVal)
            count = rrTypeMap(rrTypeVal) + 1;
        else
            count = 1;
        end
        rrTypeMap(rrTypeVal) =count;
    end
end
%% 转换成矩阵
numOfType = length(rrTypeMap);
keysOfType = keys(rrTypeMap);
resultMatrix = cell(2, numOfType);
for i=1:numOfType
    key = keysOfType{i};
    resultMatrix{1, i} = key;
    key = char(key);
    resultMatrix{2, i} = rrTypeMap(key);
end
resultMatrixX = resultMatrix(1, :);
resultMatrixY = resultMatrix(2, :);
resultMatrixY = cell2mat(resultMatrixY);

%% 分析间隔
% allIntervalTime = zeros(100, 1);
% allIntervalDifTime = zeros(1000, 1);
% for i=1:26
%     [intervalTime, rrType] = loadRRFile(fileNumber(i));
%     for j=2:length(intervalTime)-1
%         index = ceil(intervalTime(j)*10);
%         cnt = allIntervalTime(index) + 1;
%         allIntervalTime(index) = cnt;
%     end
%     for j=2:length(intervalTime)-1
%         index = abs(ceil(intervalTime(j)-intervalTime(j-1)*100));
%         cnt = allIntervalDifTime(index) +1;
%         allIntervalDifTime(index) = cnt;
%     end
% end