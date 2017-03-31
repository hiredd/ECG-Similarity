dataNumber = getAllFileNumber();
allAnoType = cell(0,1);
for i=1:length(dataNumber)
    [anoData, anoType, numberOfAno] = loadAtrFile(dataNumber(i));
    anoType = unique(anoType);
    anoType = anoType';
    allAnoType = [allAnoType; anoType];
end
allAnoType = unique(allAnoType)