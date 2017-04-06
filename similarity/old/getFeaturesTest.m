aSetOfdataNumber = getAllFileNumber();
for i=1:length(aSetOfdataNumber)
    dataNumber = aSetOfdataNumber(i);
    [waveData, ~] = loadDatFile(dataNumber);
    [anoData, anoType] = loadAtrFile(dataNumber);
    [qwaves, rwaves, swaves] = findQRS(waveData);
    [ indexsOfAno, features] = getFeatures(waveData, anoData, qwaves, rwaves, swaves);
    display(['�ļ���' num2str(dataNumber) 'ע������' num2str(length(anoData))  '������qrs��Ⱥ����' num2str(length(features))])
end
