function [anoTypeEveryFile] = getAnoTypeEveryFile()
% 分析每个注释文件中的类别
anoFilesNumber = getAllFileNumber();
heartBeatType = getheartBeatType();
anoTypeEveryFile = zeros(length(anoFilesNumber), length(heartBeatType));
for i =1:length(anoFilesNumber)
    [~, anoType] = loadAtrFile(anoFilesNumber(i));
    for j=1:length(anoType)
        anoTypeVal = anoType(j);
        anoTypeVal = char(anoTypeVal);
        for k=1:length(heartBeatType)
            if anoTypeVal == heartBeatType(k)
                cnt = anoTypeEveryFile(i, k)+1;
                anoTypeEveryFile(i, k) = cnt;
                break;
            end
        end
    end
end
end