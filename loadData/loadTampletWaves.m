allRRType = getAllRRType();
lenOfRRType = length(allRRType);
countOfEachTmp = 4; %每种类别的模板数量
tampletWaves = cell(lenOfRRType, 2*countOfEachTmp);
%curCountOfTampW = ones(lenOfRRType, 1);
dataNumber = getAllFileNumber();
tampletWaveCntEveryFile = getTampletWaveCntEveryFile(countOfEachTmp);
curCnt = zeros(length(tampletWaveCntEveryFile(:, 1)), length(tampletWaveCntEveryFile(1, :)));
tampletWavesIndex = ones(lenOfRRType, 1);
for i =1:length(dataNumber) %
    display(i);%
    hasFindAll = 1;
    for j = 1:lenOfRRType
        if curCnt(i, j) ~=tampletWaveCntEveryFile(i, j)
            hasFindAll = 0;
            break;
        end
    end
    if hasFindAll
        continue;
    end
    [rrNumber, rrType, ~] = loadRRFile(dataNumber(i));
    [waveData, ~] = loadDatFile(dataNumber(i));
    for j=2: length(rrType)-1
        if isStrMatrixContain(allRRType, char(rrType(j)))
            for k =1:lenOfRRType
                if allRRType(k) == char(rrType(j))  && curCnt(i, k)<tampletWaveCntEveryFile(i, k)
                    if rrNumber(j) - rrNumber(j-1) >750 || rrNumber(j+1)-rrNumber(j)>750 %
                         continue;
                    end
                    curCnt(i, k)=curCnt(i, k)+1;
                    tampletWaves{k, tampletWavesIndex(k)} =waveData(rrNumber(j-1):rrNumber(j+1));
                    tampletWaves{k, countOfEachTmp+tampletWavesIndex(k)} = rrNumber(j) - rrNumber(j-1) +1;
                    tampletWavesIndex(k) = tampletWavesIndex(k)+1;
                    break;
                end
            end
        end
    end
end
for i=1:lenOfRRType
    for j=2:countOfEachTmp
        if isempty(tampletWaves{i, j})
            tampletWaves{i, j} = tampletWaves{i, j-1};
            tampletWaves{i, countOfEachTmp+j} = tampletWaves{i, countOfEachTmp+j-1}
        end
    end
end
