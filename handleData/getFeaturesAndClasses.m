function [ features, classes ] = getFeaturesAndClasses( dataNumber, tampletWaves)
% 得到一个波形文件的特征以及类别
[rrNumber, rrType, ~] = loadRRFile(dataNumber);
[waveData, ~] = loadDatFile(dataNumber);
[qwaves, swaves] = findQS(rrNumber, waveData);
classes = rrType(2 : length(rrType)- 1)';
global NumOfRRType;
global NumOfTamplet;
% 特征为每种类别的波形5个特征，3个为dtw，2个为长度
features = zeros(length(rrNumber)-2, NumOfRRType*5);
display(['特征获取中...  文件号： ' num2str(dataNumber)]);
for i =2:(length(rrNumber)-1)   
    lLen =rrNumber(i) - rrNumber(i-1);
    lwave = waveData(swaves(i-1) : qwaves(i));
    midwave = waveData(qwaves(i) : swaves(i));
    rLen = rrNumber(i+1) - rrNumber(i);
    rwave = waveData(swaves(i) : qwaves(i+1));
    for j=1 : NumOfRRType
        for k=1 : NumOfTamplet
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
%% 过滤掉不使用的类别
global AllRRType;
i = 1;
while i <= length(classes)
    typeVal = char(classes(i));
    if ~isStrMatrixContain(AllRRType, typeVal)
        classes(i, :) = [];
        features(i, :) = [];
    else
        i = i+1;
    end
end
%% 归一化处理
features = scallingMatric(features);
end



