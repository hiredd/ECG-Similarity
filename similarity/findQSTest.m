%% ����һ��qrs��Ⱥ
allFileNumber = getAllFileNumber();
parfor i=1:length(allFileNumber)
    dataNumber = allFileNumber(i);
    display(['�ļ��ţ�' num2str(dataNumber)]);
    [waveData, ~] = loadDatFile(dataNumber);
    [rrNumber, ~, ~] = loadRRFile(dataNumber);
    [qwaves, swaves] = findQS(rrNumber, waveData);
end
