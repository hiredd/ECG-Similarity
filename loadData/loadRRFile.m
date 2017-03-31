function [ intervalTime, rrType ] = loadRRFile( dataNumber )
%% ����RR�ļ�
filename = fullfile('.', 'data', 'arrtfn', [num2str(dataNumber), '.arr']);
fileID = fopen(filename);
rrData = textscan(fileID, '%f %s %f');
intervalTime = rrData{3};
rrType = rrData{2};
rrNumber = rrData{1};
intervalTime = intervalTime';
rrType = rrType';
rrNumber = rrNumber';
fclose(fileID);
end

