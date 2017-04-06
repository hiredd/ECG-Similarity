for i =1 : length(AllFileNumber)
    dataNumber = AllFileNumber(i);
    display(['Œƒº˛∫≈£∫' num2str(dataNumber)]);
    [waveData, ~] = loadDatFile(dataNumber);
    [rrNumber, ~, ~] = loadRRFile(dataNumber);
    [qwaves, swaves] = findQS(rrNumber, waveData);
    for j=2:length(qwaves)-1
        if swaves(j-1)>qwaves(j) 
            error('qs≤È’“¥ÌŒÛ');
        end
        lwaveLen = qwaves(j) - swaves(j-1);
        midWaveLen = swaves(j) - qwaves(j);
        rwaveLen = qwaves(j+1) - swaves(j);
        if abs(midWaveLen - (lwaveLen + rwaveLen))>5
            error('qs≤È’“¥ÌŒÛ');
        end
    end
end
dataNumber = 102;
[waveData, ~] = loadDatFile(dataNumber);
[rrNumber, ~, ~] = loadRRFile(dataNumber);
[qwaves, swaves] = findQS(rrNumber, waveData);
hold on;
plot(waveData);
lenOfRR = length(rrNumber);
plot(qwaves(2:length(rrNumber)-1), waveData(qwaves(2:length(rrNumber)-1)), 'rx','MarkerFaceColor', 'g')
plot(rrNumber, waveData(rrNumber), 'bv','MarkerFaceColor', 'y')
plot(swaves(2:length(rrNumber)-1), waveData(swaves(2:length(rrNumber)-1)), 'rx', 'MarkerFaceColor', 'g')
grid on;
legend('ECG Signal', 'Q-waves', 'R-waves', 'S-waves');