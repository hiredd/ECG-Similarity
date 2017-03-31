function [ features, classes ] = getFeaturesAndClasses( dataNumber, tampletWaves,isSvdb )
% �õ�һ�������ļ��������Լ����
if isSvdb
    [rrNumber, rrType, ~] = loadRRFileSvdb(dataNumber);
    [waveData, ~] = loadDatFileSvdb(dataNumber);
else
    [rrNumber, rrType, ~] = loadRRFile(dataNumber);
    [waveData, ~] = loadDatFile(dataNumber);
end
classes = rrType(2 : length(rrType)- 1)';
lenOfAllRRType = length(tampletWaves(:,1));
%����Ϊÿ�����Ĳ���7��������5��λdtw��2��Ϊ����
features = zeros(length(rrNumber)-2, lenOfAllRRType*7);
widthOfQR = 20;
if isSvdb
    widthOfQR = ceil(widthOfQR/(360/128));
end

countOfEachTmp = ceil(length(tampletWaves(1,:))/2);
for i =2:(length(rrNumber)-1)
    lLen = ceil((rrNumber(i) - rrNumber(i-1))/2);
    l1wave = waveData(rrNumber(i-1) +widthOfQR: rrNumber(i-1) + lLen);
    l2wave = waveData( rrNumber(i-1) + lLen : rrNumber(i)-widthOfQR);
    midwave = waveData(rrNumber(i)-widthOfQR : rrNumber(i) + widthOfQR);
    rLen = ceil((rrNumber(i+1)-rrNumber(i))/2);
    r1wave = waveData(rrNumber(i)+widthOfQR : rrNumber(i) + rLen);
    r2wave = waveData(rrNumber(i) + rLen : rrNumber(i+1));
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
unique(classes)
%% ��һ������
features = scallingMatric(features);
end



