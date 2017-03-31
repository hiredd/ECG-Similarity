function [ dist ] = countDTW( wave1, wave2 )
%计算两个波的dwt距离
dist = dtw(wave1, wave2);
end

