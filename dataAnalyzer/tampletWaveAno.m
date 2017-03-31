for i = 1:length(tampletWaves(:, 1))
    figure(i)
    for j = 1:ceil(length(tampletWaves(1, :))/2)
        wave = tampletWaves{i, j}';      
        subplot(2, 2, j), plot(wave);
        hold on;
        r = tampletWaves{i, 4+j};
        plot(r, wave(r), '+g');
        hold off;
    end
end

