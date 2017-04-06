aSetOfdataNumber = getAllFileNumber();
for i=1:length(aSetOfdataNumber)
    dataNumber = aSetOfdataNumber(i);
    [waveData, ~] = loadDatFile(dataNumber);
    [anoData, anoType] = loadAtrFile(dataNumber);
    [qwaves, rwaves, swaves] = findQRS(waveData);
    [ indexsOfAno, features] = getFeatures(waveData, anoData, qwaves, rwaves, swaves);
    display(['文件号' num2str(dataNumber) '注释数量' num2str(length(anoData))  '检测出的qrs波群数量' num2str(length(features))])
end
