fileNumber = getAllFileNumber();
allIntervalTime = zeros(100, 1);
allIntervalDifTime = zeros(1000, 1);
for i=1:26
    [intervalTime, rrType] = loadRRFile(fileNumber(i));
    for j=2:length(intervalTime)-1
        index = ceil(intervalTime(j)*10);
        cnt = allIntervalTime(index) + 1;
        allIntervalTime(index) = cnt;
    end
    for j=2:length(intervalTime)-1
        index = abs(ceil(intervalTime(j)-intervalTime(j-1)*100));
        cnt = allIntervalDifTime(index) +1;
        allIntervalDifTime(index) = cnt;
    end
end