%% ��������ע���ļ�
dataNumber = getAllFileNumber();
for i=1:length(dataNumber)
    [anoData, anoType, numberOfAno] = loadAtrFile(dataNumber(i));
    unique(anoType)
end
%% ����һ��ע���ļ�
% dataNumber = 103;
% [anoData, anoType,  numberOfAno] = loadAtrFile(dataNumber);
% display( numberOfAno(2));
% unique(anoType)
% [waveData, ~] = loadDatFile(dataNumber);
% plot(waveData);
% hold on;
% anoDataVal=waveData(anoData);
% plot(anoData, anoDataVal, '+g');
% for i=1:length(anoData)
%  txt1 = text(double(anoData(i)), anoDataVal(i)+0.5, anoType(i));
% end
