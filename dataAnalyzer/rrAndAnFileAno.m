% 分析RR文件和注释文件中心脏跳动数据是不是一致
dataNumber = getAllFileNumber();
for i=1:length(dataNumber)
    [anoData, anoType, numberOfAno] = loadAtrFile(dataNumber(i));
    [ intervalTime, rrType ] = loadRRFile( dataNumber(i) );
    display([num2str(numberOfAno(1)) ':' num2str(length(intervalTime))]);
end