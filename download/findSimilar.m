waveLen=151;
stepLen=10;
resultValues=java.util.ArrayList;
resultTimeSerials=java.util.ArrayList;
targetTimeSerial=200:350;
targetValue=y(targetTimeSerial);
for k=1:stepLen:length(y)-waveLen+1
    if k>180&&k<220
        continue;
    end
    timeSerial=k:waveLen+k-1;
    testSerial=y(timeSerial);
    dist=dtw(targetValue,testSerial);
    if dist<2
        resultValues.add(y(timeSerial));
        resultTimeSerials.add(timeSerial);
    end
end
resultNum=resultValues.size();
resultValues=toArray(resultValues);
resultTimeSerials=toArray(resultTimeSerials);
resultValues=cell(resultValues)';
resultTimeSerials=cell(resultTimeSerials)';
subplot(4,1,1),plot(targetTimeSerial,targetValue);
for k=1:3
        value=resultValues(k);
        value=value{1};
        value=value';
        timeSerial=resultTimeSerials(k);
        timeSerial=timeSerial{1};
        timeSerial=timeSerial';
        subplot(4,1,k+1),plot(timeSerial,value);
end
