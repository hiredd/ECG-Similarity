% ��ȡƥ���ģ��
tampletWaves = cell(NumOfRRType, 3*NumOfTamplet);
getTampletWaveCntEveryFile;
curCnt = zeros(length(AllFileNumber), NumOfRRType);
tampletWavesIndex = ones(NumOfRRType, 1);
for i =1:length(AllFileNumber)
    display(['��ȡģ�� ��' num2str(i) '���ļ�������...']);
    hasFindAll = 1;
    for j = 1:NumOfRRType
        if curCnt(i, j) ~=tampletWaveCntEveryFile(i, j)
            hasFindAll = 0;
            break;
        end
    end
    if hasFindAll
        continue;
    end
    [rrNumber, rrType, ~] = loadRRFile(AllFileNumber(i));
    [waveData, ~] = loadDatFile(AllFileNumber(i));
    [qwaves, swaves] = findQS(rrNumber, waveData);
    p = randperm(length(rrNumber));
    rrNumber = rrNumber(p);
    rrType = rrType(p);
    for j=3: length(rrType)-2
        if isStrMatrixContain(AllRRType, char(rrType(j)))
            for k =1:NumOfRRType
                if AllRRType(k) == char(rrType(j))  && curCnt(i, k)<tampletWaveCntEveryFile(i, k)
                    curCnt(i, k)=curCnt(i, k)+1;
                    tampletWaves{k, 3*(tampletWavesIndex(k)-1)+1} = waveData(swaves(j-1) : qwaves(j));
                    tampletWaves{k, 3*(tampletWavesIndex(k)-1)+2} = waveData(qwaves(j) : swaves(j));
                    tampletWaves{k, 3*(tampletWavesIndex(k)-1)+3} =waveData(swaves(j) : qwaves(j+1));
                    tampletWavesIndex(k) = tampletWavesIndex(k)+1;
                    break;
                end
            end
        end
    end
end
