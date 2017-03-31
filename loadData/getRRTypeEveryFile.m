function [rrTypeEveryFile] = getRRTypeEveryFile()
% 分析每个rr文件中的类别
allFiles = getAllFileNumber();
allRRType = getAllRRType();
rrTypeEveryFile = zeros(length(allFiles), length(allRRType));
for i =1:length(allFiles)
    [~, rrType, ~] = loadRRFile(allFiles(i));
    for j=1:length(rrType)
        rrTypeVal = rrType(j);
        rrTypeVal = char(rrTypeVal);
        for k=1:length(allRRType)
            if rrTypeVal == allRRType(k)
                cnt = rrTypeEveryFile(i, k)+1;
                rrTypeEveryFile(i, k) = cnt;
                break;
            end
        end
    end
end
end