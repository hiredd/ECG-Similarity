function [ boolVal ] = isStrMatrixContain( strMatrix, val )
%% 判断一个字符串矩阵是否包含一个值
for i=1:length(strMatrix)
    if strMatrix(i) == val
        boolVal = 1;
        return;
    end
end
boolVal = 0;
end

