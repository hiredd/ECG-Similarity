fileNumber = getAllFileNumber();
for i=1:2
    [rrNumber, rrType, rrintervalTime] = loadRRFile(fileNumber(i));
end