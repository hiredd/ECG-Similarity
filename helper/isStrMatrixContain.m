function [ boolVal ] = isStrMatrixContain( strMatrix, val )
%% �ж�һ���ַ��������Ƿ����һ��ֵ
for i=1:length(strMatrix)
    if strMatrix(i) == val
        boolVal = 1;
        return;
    end
end
boolVal = 0;
end

