heartBeatType = getheartBeatType();
lenOfHeartBeatType = length(heartBeatType);
countOfEachTmp = 10; %每种类别的模板数量
tampletWaves = cell(lenOfHeartBeatType, 2*countOfEachTmp);
curCountOfTampW = ones(lenOfHeartBeatType, 1);
dataNumber = getAllFileNumber();
tampletWaveCntEveryFile = getTampletWaveCntEveryFile(countOfEachTmp);
curCnt = zeros(length(tampletWaveCntEveryFile(:, 1)), length(tampletWaveCntEveryFile(1, :)));
tampletWavesIndex = ones(lenOfHeartBeatType, 1);
for i =1:length(dataNumber) %
    display(i);%
    hasFindAll = 1;
    for j = 1:lenOfHeartBeatType
        if curCnt(i, j) ~=tampletWaveCntEveryFile(i, j)
            hasFindAll = 0;
            break;
        end
    end
    if hasFindAll
        continue;
    end
    [anoData, anoType, numberOfAno] = loadAtrFile(dataNumber(i));
    [waveData, ~] = loadDatFile(dataNumber(i));
    for j=3: length(anoType)-2
        if isStrMatrixContain(heartBeatType, char(anoType(j)))
            for k =1:lenOfHeartBeatType
                if heartBeatType(k) == char(anoType(j))  && curCnt(i, k)<tampletWaveCntEveryFile(i, k)
                    if anoData(j) - anoData(j-1) >750 || anoData(j+1)-anoData(j)>750 %
                         continue;
                    end
                    curCnt(i, k)=curCnt(i, k)+1;
                    tampletWaves{k, tampletWavesIndex(k)} =waveData(anoData(j-1):anoData(j+1));
                    tampletWaves{k, countOfEachTmp+tampletWavesIndex(k)} = anoData(j) - anoData(j-1) +1;
                    tampletWavesIndex(k) = tampletWavesIndex(k)+1;
                    break;
                end
            end
        end
    end
end
for i=1:lenOfHeartBeatType
    for j=2:countOfEachTmp
        if isempty(tampletWaves{i, j})
            tampletWaves{i, j} = tampletWaves{i, j-1};
            tampletWaves{i, countOfEachTmp+j} = tampletWaves{i, countOfEachTmp+j-1}
        end
    end
end
