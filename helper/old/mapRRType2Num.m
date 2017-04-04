function [ numberVal ] = mapRRType2Num( rrType )
%把rr类别转换成数值
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

