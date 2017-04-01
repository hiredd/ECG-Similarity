allFileNumber = getAllFileNumber();
for i=1:length(allFileNumber)/10
    dataNumber = allFileNumber(i);
    display(['ÎÄ¼þºÅ£º' num2str(dataNumber)]);
    [waveData, ~] = loadDatFile(dataNumber);
    [rrNumber, ~, ~] = loadRRFile(dataNumber);
    [qwaves, swaves] = findQS(rrNumber, waveData);
end
dataNumber = 102;
[waveData, ~] = loadDatFile(dataNumber);
[rrNumber, ~, ~] = loadRRFile(dataNumber);
[qwaves, swaves] = findQS(rrNumber, waveData);
hold on;
plot(waveData);
lenOfRR = length(rrNumber);
plot(qwaves(1:lenOfRR), waveData(qwaves(1:lenOfRR)), 'rx','MarkerFaceColor', 'g')
plot(rrNumber, waveData(rrNumber), 'rv','MarkerFaceColor', 'r')
plot(swaves(1:lenOfRR), waveData(swaves(1:lenOfRR)), 'rx', 'MarkerFaceColor', 'g')
grid on;
legend('ECG Signal', 'Q-waves', 'R-waves', 'S-waves');