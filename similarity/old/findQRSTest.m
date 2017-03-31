%% 分析所有qrs波群
% dataNumber = getAllFileNumber();
% for i=1:length(dataNumber)
%     [waveData, ~] = loadDatFile(dataNumber(i));
%     [anoData, anoType, ~] = loadAtrFile(dataNumber(i));
%     [qwaves, rwaves, swaves] = findQRS(waveData);
%     display([num2str(length(anoData)) '    ' num2str(length(rwaves))]);
% end
%% 分析一个qrs波群
dataNumber = 102;
[waveData, ~] = loadDatFile(dataNumber);
[anoData, anoType, ~] = loadAtrFile(dataNumber);
[ qwaves, rwaves, swaves ] = findQRS(waveData);
display([num2str(length(rwaves)) '    ' num2str(length(anoData))]);
hold on;
plot(waveData);
plot(qwaves, waveData(qwaves), 'rx','MarkerFaceColor', 'g')
plot(rwaves, waveData(rwaves), 'rv','MarkerFaceColor', 'r')
plot(swaves, waveData(swaves), 'rs', 'MarkerFaceColor', 'b')
plot(anoData, waveData(anoData), 'b+', 'MarkerFaceColor', 'r');
grid on;
legend('ECG Signal', 'Q-waves', 'R-waves', 'S-waves', 'Ano-waves');