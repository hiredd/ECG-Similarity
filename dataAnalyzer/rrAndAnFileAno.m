% ����RR�ļ���ע���ļ����������������ǲ���һ��
dataNumber = getAllFileNumber();
for i=1:length(dataNumber)
    [anoData, anoType, numberOfAno] = loadAtrFile(dataNumber(i));
    [ intervalTime, rrType ] = loadRRFile( dataNumber(i) );
    display([num2str(numberOfAno(1)) ':' num2str(length(intervalTime))]);
end