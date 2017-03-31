function [ features, classes ] = getFeaturesAndClasses( dataNumber, tampletWaves,isSvdb )
% 得到一个波形文件的特征以及类别
if isSvdb
    [rrNumber, rrType, ~] = loadRRFileSvdb(dataNumber);
    [waveData, ~] = loadDatFileSvdb(dataNumber);
else
    [rrNumber, rrType, ~] = loadRRFile(dataNumber);
    [waveData, ~] = loadDatFile(dataNumber);
end
classes = rrType(2 : length(rrType)- 1)';
lenOfAllRRType = length(tampletWaves(:,1));
%特征为每种类别的波形7个特征，5个位dtw，2个为长度
features = zeros(length(rrNumber)-2, lenOfAllRRType*7);
widthOfQR = 20;
if isSvdb
    widthOfQR = ceil(widthOfQR/(360/128));
end

countOfEachTmp = ceil(length(tampletWaves(1,:))/2);
for i =2:(length(rrNumber)-1)
    lLen = (rrNumber(i) - rrNumber(i-1))/2;
    l1wave = waveData(rrNumber(i-1) : rrNumber(i-1) + ceil((rrNumber(i) - rrNumber(i-1))/2));
    l2wave = waveData( rrNumber(i-1) + ceil((rrNumber(i) - rrNumber(i-1))/2) : rrNumber(i)-widthOfQR);
    midwave = waveData(rrNumber(i)-widthOfQR : rrNumber(i) + widthOfQR);
    rLen = (rrNumber(i+1)-rrNumber(i))/2;
    r1wave = waveData(rrNumber(i)+widthOfQR : rrNumber(i) + ceil((rrNumber(i+1)-rrNumber(i))/2));
    r2wave = waveData(rrNumber(i) + ceil((rrNumber(i+1)-rrNumber(i))/2) : rrNumber(i+1));
    if isSvdb
        lLen = lLen *(360/128);
        rLen= rLen*(360/128);
    end
    for j=1:lenOfAllRRType
        for k=1:countOfEachTmp
            rindex = tampletWaves{j, countOfEachTmp+k};
            temWave = tampletWaves{j, k};
            temlLen = rindex/2;
            teml1wave = temWave(1 : ceil(rindex/2));
            teml2wave = temWave(ceil(rindex/2) : rindex -widthOfQR);
            temmidwave = temWave(rindex-widthOfQR : rindex+widthOfQR);
            temrLen = (length(temWave)-rindex)/2;
            temr1wave = temWave(rindex+widthOfQR : rindex + ceil((length(temWave)-rindex)/2));
            temr2wave = temWave(rindex+ceil((length(temWave)-rindex)/2) : length(temWave));
            features(i-1,(j-1)*7+1) = features(i-1,(j-1)*7+1)+countDTW(l1wave, teml1wave);
            features(i-1,(j-1)*7+2) = features(i-1,(j-1)*7+2)+countDTW(l2wave, teml2wave);
            features(i-1,(j-1)*7+3) = features(i-1,(j-1)*7+3)+countDTW(midwave, temmidwave);
            features(i-1,(j-1)*7+4) = features(i-1,(j-1)*7+4)+countDTW(r1wave, temr1wave);
            features(i-1,(j-1)*7+5) = features(i-1,(j-1)*7+5)+countDTW(r2wave, temr2wave);
            features(i-1,(j-1)*7+6) = features(i-1,(j-1)*7+6)+countDTW(lLen, temlLen);
            features(i-1,(j-1)*7+7) = features(i-1,(j-1)*7+7)+countDTW(rLen, temrLen);
        end
    end
end
%%过滤掉不使用的类别
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
unique(classes)
%% 归一化处理
features = scallingMatric(features);
end



