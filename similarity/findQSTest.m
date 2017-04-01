%% 分析一个qrs波群
allFileNumber = getAllFileNumber();
parfor i=1:length(allFileNumber)
    dataNumber = allFileNumber(i);
    display(['文件号：' num2str(dataNumber)]);
    [waveData, ~] = loadDatFile(dataNumber);
    [rrNumber, ~, ~] = loadRRFile(dataNumber);
    [qwaves, swaves] = findQS(rrNumber, waveData);
end
