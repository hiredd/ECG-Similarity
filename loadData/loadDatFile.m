function [ waveData, origWaveData ] = loadDatFile( datNumber )
%����һ��dat�ļ�
filename = fullfile('data', 'dattf', [num2str(datNumber), '.dat']);
fileID = fopen(filename, 'r');
C = textscan(fileID, '%s %f %f');
origWaveData = C{2};
%ƽ������
waveData = smooth(origWaveData); 
waveData = waveData' ;
origWaveData = origWaveData' ;
%����ƫ�ƴ���
%waveData=detrend(waveData);
[p,~,mu] = polyfit((1:numel(waveData)), waveData, 6);
f_y = polyval(p, (1:numel(waveData)), [], mu);
waveData = waveData - f_y; 
fclose(fileID);
end

