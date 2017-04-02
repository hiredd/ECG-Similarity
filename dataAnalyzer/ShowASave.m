allFileNumber = getAllFileNumber();
fileNumber=  allFileNumber(46);
[waveData, ~] = loadDatFile(fileNumber);
plot(waveData);