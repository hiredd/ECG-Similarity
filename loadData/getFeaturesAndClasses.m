function [ features, classes ] = getFeaturesAndClasses( dataNumber, tampletWaves)
% �õ�һ�������ļ��������Լ����
[rrNumber, rrType, ~] = loadRRFile(dataNumber);
[waveData, ~] = loadDatFile(dataNumber);
[qwaves, swaves] = findQS(rrNumber, waveData);
classes = rrType(2 : length(rrType)- 1)';
lenOfAllRRType = length(tampletWaves(:,1));
%����Ϊÿ�����Ĳ���5��������3��Ϊdtw��2��Ϊ����
features = zeros(length(rrNumber)-2, lenOfAllRRType*5);
countOfEachTmp = length(tampletWaves(1,:))/3;
for i =2:(length(rrNumber)-1)
    lLen =rrNumber(i) - rrNumber(i-1);
    lwave = waveData(swaves(i-1): qwaves(i));
    midwave = waveData(qwaves(i):swaves(i));
    rLen = rrNumber(i+1)-rrNumber(i);
    rwave = waveData(swaves(i): qwaves(i+1));
    for j=1:lenOfAllRRType
        for k=1:countOfEachTmp
            temlwave = tampletWaves{j, (k-1)*3+1};
            temmidwave = tampletWaves{j, (k-1)*3+2};
            temrwave = tampletWaves{j, (k-1)*3+3};
            features(i-1,(j-1)*5+1) = features(i-1,(j-1)*5+1)+lLen;
            features(i-1,(j-1)*5+2) = features(i-1,(j-1)*5+2)+rLen;
            features(i-1,(j-1)*5+4) = features(i-1,(j-1)*5+4)+countDTW(lwave, temlwave);
            features(i-1,(j-1)*5+3) = features(i-1,(j-1)*5+3)+countDTW(midwave, temmidwave);
            features(i-1,(j-1)*5+5) = features(i-1,(j-1)*5+5)+countDTW(rwave, temrwave);
        end
    end
end
%%���˵���ʹ�õ����
allRRType = getAllRRType();
i = 1;
while i <= length(classes)
    typeVal = char(classes(i));
    if ~isStrMatrixContain(allRRType, typeVal)
        classes(i, :) = [];
        features(i, :) = [];
    else
        i = i+1;
    end
end
%% ��һ������
features = scallingMatric(features);
end



