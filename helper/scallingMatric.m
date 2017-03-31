function [ scallMatric ] = scallingMatric( origMatric )
%把一个矩阵转换成0-1范围
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

