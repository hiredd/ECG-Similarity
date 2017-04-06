function [ scallMatric ] = scallingMatric( origMatric )
%��һ������ת����0-1��Χ
rowNum = length(origMatric(:, 1));
colNum = length(origMatric(1, :));
scallMatric = zeros(rowNum, colNum);
for i = 1:colNum
    maxVal = max(origMatric(:, i));
    for j=1:rowNum
        scallMatric(j, i) = origMatric(j, i)/maxVal;
    end
end
end

