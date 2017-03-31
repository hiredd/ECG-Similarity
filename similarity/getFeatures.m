function [ indexsOfAno, features] = getFeatures(waveData, anoData, qwaves, rwaves, swaves)
%% ��ȡqrs��Ⱥ������Ҳ�õ�һ��qrs��Ⱥ�ڶ�Ӧע�͵�����
features = zeros(length(rwaves), 4);
for i=1:length(rwaves)
    features(i, 1) = rwaves(i) - qwaves(i);
    features(i, 2) = swaves(i) - rwaves(i);
    features(i, 3) = waveData(rwaves(i))-waveData(qwaves(i));
    features(i, 4) = waveData(rwaves(i))-waveData(swaves(i));
end
%% ����һ��qrs��Ⱥ��Ӧע�͵�����
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
%% ɾ����ע���ļ���û��ע�͵�qrs��Ⱥ
i = 1;
while i<=length(indexsOfAno)
    if indexsOfAno(i) == 0
        indexsOfAno(i, :) = [];
        features(i, :) = [];
    else
        i = i+1;
    end
end
%���������й�һ������
for i=1:4
    maxVal = max(features(:, i));
    features(:, i) = features(:, i)/maxVal;
end
end