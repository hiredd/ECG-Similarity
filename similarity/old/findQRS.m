function [ qwaves, rwaves, swaves ] = findQRS( waveData )
%% �ҳ�����QRS��Ⱥ
rwaves = findRWaves(waveData);
[qwaves, rwaves, swaves] = findQSwaves(rwaves, waveData);
end

function [rwaves]=findRWaves(waveData)
%% ����R��
[~,rwaves] = findpeaks(waveData, 'MinPeakHeight', 0.3, 'MinPeakDistance', 180);
end

function [qwaves, rwaves, swaves] = findQSwaves(rwaves, waveData)
%% ����Q��S��
numOfQRS = length(rwaves);
qwaves = zeros(1, numOfQRS);
swaves = zeros(1, numOfQRS);
i = 1;
while i<= length(rwaves)
    numOfQRS = length(rwaves);
    s_leftSection =  (i==1)*(1)+(i~=1)*(rwaves(i)-50);%
    e_leftSection = rwaves(i);
    s_rightSection = e_leftSection;
    e_rightSection = (i==numOfQRS)*(length(waveData))+(i~=numOfQRS)*(rwaves(i)+50);%
    leftSection = -waveData(s_leftSection : e_leftSection);
    rightSection = -waveData(s_rightSection : e_rightSection);
    [~, leftPeaks] = findpeaks(leftSection);%
    [~, rightPeaks] = findpeaks(rightSection);
    %leftPeaks = leftPeaks(waveData(min_locs)>-0.5 & waveData(min_locs)<-0.2);
    if isempty(rightPeaks) && i== length(rwaves)
        %% ���β������������ȥ��β��
        qwaves = qwaves(1:length(qwaves)-1);
        rwaves = rwaves(1:length(rwaves)-1);
        swaves = swaves(1:length(swaves)-1);
        continue;
    end
    if isempty(leftPeaks) && i==1
        %% ����ײ�����������ȥ���ײ�
        qwaves = qwaves(2:length(rwaves));
        rwaves = rwaves(2:length(rwaves));
        swaves = swaves(2:length(rwaves));
        continue;
    end
    %% �����Ҳ�������ʱ�����⴦��
    if isempty(leftPeaks)
        qwaves(i) = 25+s_leftSection;
    else
        qwaves(i) = leftPeaks(length(leftPeaks))+s_leftSection -1;
    end
    if isempty(rightPeaks)
        swaves(i) = 25+s_rightSection;
    else
        swaves(i) = rightPeaks(1)+s_rightSection-1;
    end
    i = i+1;

end
end
