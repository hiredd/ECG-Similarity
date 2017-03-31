function [ tampletWavecntEveryFile ] = getTampletWaveCntEveryFile( countOfEachTmp)
%得到每种模板波形应该在一个数据文件中添加的次数
rrTypeEveryFIle = getRRTypeEveryFile();
rowNum = length(rrTypeEveryFIle(:, 1));
colNum = length(rrTypeEveryFIle(1,:));
tampletWavecntEveryFile = zeros(rowNum, colNum);
for i = 1:colNum
    j = 1;
    while j<=rowNum
        if tampletWavecntEveryFile(j, i)<rrTypeEveryFIle(j, i) && sum(tampletWavecntEveryFile(:,i))<countOfEachTmp
            tampletWavecntEveryFile(j, i) = tampletWavecntEveryFile(j, i)+1;
        end
        j = j+1;
        if j==rowNum && sum(tampletWavecntEveryFile(:,i))<countOfEachTmp
            j = 1;
        end
    end
end
end

