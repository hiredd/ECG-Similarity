function [ qwaves, swaves ] = findQS( rrNumber,  waveData)
%% ����һ����Ⱥ��QS��
numOfR = length(rrNumber);
qwaves = zeros(1, numOfR);
swaves = zeros(1, numOfR);
qMissingCnt = 0;
sMissingCnt = 0;
for i = 2 : numOfR-1
    lRRLen = rrNumber(i) -rrNumber(i-1);
    s_leftSection = rrNumber(i-1) + ceil(lRRLen/2);
    leftSection = -waveData(s_leftSection : rrNumber(i));
    rRRLen = rrNumber(i+1) - rrNumber(i);
    e_rightSection = rrNumber(i) + ceil(rRRLen/2);
    rightSection = -waveData(rrNumber(i) : e_rightSection);
    [~, leftPeaks] = findpeaks(leftSection);
    [~, rightPeaks] = findpeaks(rightSection);
    %leftPeaks = leftPeaks(waveData(min_locs)>-0.5 & waveData(min_locs)<-0.2);
    if isempty(leftPeaks)
        qwaves(i) = 25+s_leftSection; %25��ֵ��Ҫ����ʵ������ȷ��
        qMissingCnt = qMissingCnt + 1;
    else
        qwaves(i) = leftPeaks(length(leftPeaks))+s_leftSection -1;
    end
    if isempty(rightPeaks)
        swaves(i) = 25+rrNumber(i);
        sMissingCnt = sMissingCnt + 1;
    else
        swaves(i) = rightPeaks(1)+rrNumber(i)-1;
    end
end
display(['δ�ҵ���Q����' num2str(qMissingCnt)]);
display(['δ�ҵ���S����'  num2str(sMissingCnt)]);
end


