function [ features, classes ] = getFeaturesAndClasses( dataNumber, tampletWaves )
% �õ�һ�������ļ��������Լ����
[anoData, anoType, ~] = loadAtrFile(dataNumber);
[waveData, ~] = loadDatFile(dataNumber);
classes = anoType(2 : length(anoType)- 1)';
lenOfHeartBeatType = length(tampletWaves(:,1));
features = zeros(length(anoData)-2, lenOfHeartBeatType*5);
widthOfQR = 20;
countOfEachTmp = ceil(length(tampletWaves(1,:))/2);
for i =2:length(anoData)-1
    l1wave = waveData(anoData(i-1) : anoData(i-1) + ceil((anoData(i) - anoData(i-1))/2));
    l2wave = waveData( anoData(i-1) + ceil((anoData(i) - anoData(i-1))/2) : anoData(i)-widthOfQR);
    midwave = waveData(anoData(i)-widthOfQR : anoData(i) + widthOfQR);
    r1wave = waveData(anoData(i)+widthOfQR : anoData(i) + ceil((anoData(i+1)-anoData(i))/2));
    r2wave = waveData(anoData(i) + ceil((anoData(i+1)-anoData(i))/2) : anoData(i+1));
    for j=1:lenOfHeartBeatType
        for k=1:countOfEachTmp
            rindex = tampletWaves{j, countOfEachTmp+k};
            temWave = tampletWaves{j, k};
            teml1wave = temWave(1 : ceil(rindex/2));
            teml2wave = temWave(ceil(rindex/2) : rindex -widthOfQR);
            temmidwave = temWave(rindex-widthOfQR : rindex+widthOfQR);
            temr1wave = temWave(rindex+widthOfQR : rindex + ceil((length(temWave)-rindex)/2));
            temr2wave = temWave(rindex+ceil((length(temWave)-rindex)/2) : length(temWave));
            features(i-1,(j-1)*5+1) = features(i-1,(j-1)*5+1)+countDTW(l1wave, teml1wave);
            features(i-1,(j-1)*5+2) = features(i-1,(j-1)*5+2)+countDTW(l2wave, teml2wave);
            features(i-1,(j-1)*5+3) = features(i-1,(j-1)*5+3)+countDTW(midwave, temmidwave);
            features(i-1,(j-1)*5+4) = features(i-1,(j-1)*5+4)+countDTW(r1wave, temr1wave);
            features(i-1,(j-1)*5+5) = features(i-1,(j-1)*5+5)+countDTW(r2wave, temr2wave);
        end
    end
end
features = scallingMatric(features);
end


