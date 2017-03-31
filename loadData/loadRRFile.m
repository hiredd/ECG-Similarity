function [ intervalTime, rrType ] = loadRRFile( dataNumber )
%% 导入RR文件
filename = fullfile('C:\Users\ZYC\Documents\MATLAB\ECG-1', 'data', 'arrtf', [num2str(dataNumber), '.arr']);
fileID = fopen(filename);
rrData = textscan(fileID, '%s %s %f %s %s');
intervalTime = rrData{3};
rrType = rrData{2};
intervalTime = intervalTime';
rrType = rrType';
fclose(fileID);
end

