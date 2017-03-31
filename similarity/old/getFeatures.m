function [ indexsOfAno, features] = getFeatures(waveData, anoData, qwaves, rwaves, swaves)
%% 提取qrs波群特征，也得到一个qrs波群在对应注释的索引
features = zeros(length(rwaves), 4);
for i=1:length(rwaves)
    features(i, 1) = rwaves(i) - qwaves(i);
    features(i, 2) = swaves(i) - rwaves(i);
    features(i, 3) = waveData(rwaves(i))-waveData(qwaves(i));
    features(i, 4) = waveData(rwaves(i))-waveData(swaves(i));
end
%% 查找一个qrs波群对应注释的索引
indexsOfAno = zeros(length(rwaves),1);
index = 1;
for i = 1:length(rwaves)
    while index <= length(anoData) && anoData(index)+10 <=rwaves(i)
        index = index +1;
    end
    if index > length(anoData)
        break;
    end
    if anoData(index) -10<rwaves(i)
        indexsOfAno(i, 1) = index;
    end
end
%% 删除在注释文件中没有注释的qrs波群
i = 1;
while i<=length(indexsOfAno)
    if indexsOfAno(i) == 0
        indexsOfAno(i, :) = [];
        features(i, :) = [];
    else
        i = i+1;
    end
end
%对特征进行归一化处理
for i=1:4
    maxVal = max(features(:, i));
    features(:, i) = features(:, i)/maxVal;
end
end