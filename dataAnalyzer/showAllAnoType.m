dataNumber = getAllFileNumber();
allAnoType = cell(0,1);
allRRType = cell(0, 1);
for i=1:length(dataNumber)
    [anoData, anoType, numberOfAno] = loadAtrFile(dataNumber(i));
    [ intervalTime, rrType ] = loadRRFile(dataNumber(i));
    anoType = unique(anoType);
    anoType = anoType';
    allAnoType = [allAnoType; anoType];
    rrType = unique(rrType);
    rrType = rrType';
    allRRType = [allRRType; rrType];
end
allAnoType = unique(allAnoType);
allRRType = unique(allRRType);