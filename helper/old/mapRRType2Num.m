function [ numberVal ] = mapRRType2Num( rrType )
%��rr���ת������ֵ
if ~exist('allType','var')
    allType = getAllRRType();
end
numberVal = 0;
for i=1:length(allType)
    if rrType == allType(i)
        numberVal = i;
        break;
    end
end
end

