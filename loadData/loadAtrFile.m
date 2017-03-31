function [ anoData, anoType, numberOfAno] = loadAtrFile( dataNumber )
%% ����ע���ļ�
filename = fullfile('C:\Users\ZYC\Documents\MATLAB\ECG-1', 'data', 'atrtf', [num2str(dataNumber), '.atr']);
fileID = fopen(filename);
anoData = textscan(fileID, '%s %d %s %d %d %d %s');
anoType = anoData{3};
anoData = anoData{2};
anoType = anoType';
anoData = anoData';
numberOfAno = zeros(2, 1);
numberOfAno(1) = length(anoData);
[ anoData, anoType ] = nonBeatAnoFilter( anoData, anoType );
numberOfAno(2) = length(anoData);
fclose(fileID);
end

function [ anoData, anoType ] = nonBeatAnoFilter( anoData, anoType )
%% ����ע���ļ��в�������������ע��
heartBeatType = getheartBeatType();
i = 1;
while i<=length(anoData)
    typeVal = char(anoType(i));
    if ~strMatrixHasAVal(heartBeatType, typeVal)
        anoType(i) = [];
        anoData(i) = [];
    else
        i = i+1;
    end
end
end

function [boolVal] = strMatrixHasAVal(strMatrix, val)
%% �ж�һ���ַ����������Ƿ���һ��ֵ
for i=1:length(strMatrix)
    if strMatrix(i) == val
        boolVal = 1;
        return;
    end
end
boolVal = 0;
end
