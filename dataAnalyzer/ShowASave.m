allFileNumber = getAllFileNumber();
fileNumber=  allFileNumber(29);
[waveData, ~] = loadDatFile(fileNumber);
plot(waveData);