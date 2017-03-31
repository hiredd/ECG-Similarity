loadDatFile(100);
%loadAtr;
distWave = 1:250;
[similarities, cutedData] = countAllSimilaritiesAgainstQRSWave(distWave, waveData);
numOfQRSWave = length(cutedData);
%row = ceil((numOfQRSWave+1)/6);
row = 3;
subplot(row, 6, 1), plot(distWave, waveData(distWave));
axis([distWave(1) distWave(length(distWave)) -0.5 1.2]);
for i=1:17
    waveSection = cutedData{i};
    subplot(row, 6, i+1), plot(waveSection,waveData(waveSection));
    startAxisX = waveSection(i);
    endAxisX = waveSection(length(waveSection));
    axis([startAxisX endAxisX -0.5 1.2]);
    title(['æ‡¿Î:',num2str(similarities(i))]);
end

