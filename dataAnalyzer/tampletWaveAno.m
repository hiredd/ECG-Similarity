allType = getheartBeatType();
numOfType = length(allType);
for i = 1:numOfType
    figure(i)
    numOfEachTapletWave = ceil(length(tampletWaves(1, :))/2);
    for j = 1:numOfEachTapletWave
        wave = tampletWaves{i, j}';
        subplot(4, 3, j), plot(wave);
        title(char(allType(i)));
        hold on;
        r = tampletWaves{i, numOfEachTapletWave +j };
        plot(r, wave(r), '+g');
        
        hold off;
    end
end

