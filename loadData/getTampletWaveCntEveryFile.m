function [ tampletWavecntEveryFile ] = getTampletWaveCntEveryFile( countOfEachTmp)
%�õ�ÿ��ģ�岨��Ӧ����һ�������ļ�����ӵĴ���
anoTypeEveryFIle = getAnoTypeEveryFile();
rowNum = length(anoTypeEveryFIle(:, 1));
colNum = length(anoTypeEveryFIle(1,:));
tampletWavecntEveryFile = zeros(rowNum, colNum);
for i = 1:colNum
    j = 1;
    while j<=rowNum
        if tampletWavecntEveryFile(j, i)<anoTypeEveryFIle(j, i) && sum(tampletWavecntEveryFile(:,i))<countOfEachTmp
            tampletWavecntEveryFile(j, i) = tampletWavecntEveryFile(j, i)+1;
        end
        j = j+1;
        if j==rowNum && sum(tampletWavecntEveryFile(:,i))<countOfEachTmp
            j = 1;
        end
    end
end
end

