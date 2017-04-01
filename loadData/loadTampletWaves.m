allRRType = getAllRRType();
lenOfRRType = length(allRRType);
countOfEachTmp = 10; %每种类别的模板数量
tampletWaves = cell(lenOfRRType, 3*countOfEachTmp);
%curCountOfTampW = ones(lenOfRRType, 1);
dataNumber = getAllFileNumber();
tampletWaveCntEveryFile = getTampletWaveCntEveryFile(countOfEachTmp);
curCnt = zeros(length(tampletWaveCntEveryFile(:, 1)), length(tampletWaveCntEveryFile(1, :)));
tampletWavesIndex = ones(lenOfRRType, 1);
for i =1:length(dataNumber) 
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
    [qwaves, swaves] = findQS(rrNumber, waveData);
    for j=3: length(rrType)-2
        if isStrMatrixContain(allRRType, char(rrType(j)))
            for k =1:lenOfRRType
                if allRRType(k) == char(rrType(j))  && curCnt(i, k)<tampletWaveCntEveryFile(i, k)
                    if rrNumber(j) - rrNumber(j-1) >750 || rrNumber(j+1)-rrNumber(j)>750 %
                         continue;
                    end
                    curCnt(i, k)=curCnt(i, k)+1;
                    tampletWaves{k, 3*(tampletWavesIndex(k)-1)+1} =waveData(swaves(j-1):qwaves(j));
                    tampletWaves{k, 3*(tampletWavesIndex(k)-1)+2} =waveData(qwaves(j):swaves(j));
                    tampletWaves{k, 3*(tampletWavesIndex(k)-1)+3} =waveData(swaves(j):qwaves(j+1));
                    tampletWavesIndex(k) = tampletWavesIndex(k)+1;
                    break;
                end
            end
        end
    end
end
for i=1:lenOfRRType
    for j=2:countOfEachTmp
        if isempty(tampletWaves{i, (j-1)*3+1})
            tampletWaves{i, (j-1)*3+1} = tampletWaves{i, (j-2)*3+1};
            tampletWaves{i, (j-1)*3+2} = tampletWaves{i, (j-2)*3+1};
            tampletWaves{i, (j-1)*3+3} = tampletWaves{i, (j-2)*3+3};
        end
    end
end
