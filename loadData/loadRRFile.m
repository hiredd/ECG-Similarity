function [ rrNumber, rrType, rrintervalTime ] = loadRRFile( dataNumber )
%% ����RR�ļ�
filename = fullfile('data', 'arrtfn', [num2str(dataNumber), '.arr']);
fileID = fopen(filename);
rrData = textscan(fileID, '%f %s %f');
fclose(fileID);
rrintervalTime = rrData{3};
rrType = rrData{2};
rrNumber = rrData{1};
rrintervalTime = rrintervalTime';
rrType = rrType';
rrNumber = rrNumber';
end

