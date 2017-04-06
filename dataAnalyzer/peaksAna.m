%% 分析峰值分布情况
if ~exist('allAnoDataVal', 'var')
    fileNumber = getAllFileNumber();
    allAnoDataVal = zeros(1, 0);
    allAnoData = zeros(1, 0);
    for i=1:length(fileNumber)
        [anoData, anoType, ~] = loadAtrFile(fileNumber(i));
        [waveData, ~] = loadDatFile(fileNumber(i));
        allAnoDataVal = [allAnoDataVal waveData(anoData)];
        allAnoData = [allAnoData anoData];
    end
end
allAnoDataVal = abs(allAnoDataVal);
peaks = zeros(50, 1);
for i=1:length(allAnoDataVal)
    indexOfPeaks = ceil(allAnoDataVal(i)*10);
    indexOfPeaks = min(indexOfPeaks, 20);
    cnt = peaks(indexOfPeaks)+1;
    peaks(indexOfPeaks) = cnt;
end
%% 分析最小间距，以及间距分布情况
minInterval =1000;
for i=1:length(allAnoData)-1
    interval = allAnoData(i+1) - allAnoData(i);
    if interval>0
        minInterval = min(minInterval, interval);
    end
end
display(minInterval);
intervals = zeros(10, 1);
for i=1:length(allAnoData)-1
    interval = allAnoData(i+1) - allAnoData(i);
    if interval>0
        indexOfIntervals = ceil((interval-80)/10);
        indexOfIntervals = min(indexOfIntervals, length(intervals));
        cnt = intervals(indexOfIntervals)+1;
        intervals(indexOfIntervals) = cnt;
    end
end
lowPercentage = sum(intervals(1:length(intervals)-7))/sum(intervals(length(intervals)-3:length(intervals)))
