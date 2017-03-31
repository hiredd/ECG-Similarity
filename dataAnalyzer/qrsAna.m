dataNumber = 101;
[waveData, ~] = loadDatFile(dataNumber);
[anoData, anoType] = loadAtrFile(dataNumber);
[ qwaves, rwaves, swaves ] = findQRS( waveData );
