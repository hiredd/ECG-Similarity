allRRType = getAllRRType();
for i = 1:length(tampletWaves(:, 1))
    figure(i)
    for j = 1:ceil(length(tampletWaves(1, :))/2)
        wave = tampletWaves{i, j}';      
        subplot(4, 3, j), plot(wave);
        hold on;
        title(allRRType(i));
        r = tampletWaves{i, 10+j};
        plot(r, wave(r), '+g');
        hold off;
    end
end

