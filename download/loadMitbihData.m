%�����ļ�
filename=fullfile('.','data','100t.dat');
fileID=fopen(filename);
C=textscan(fileID,'%s %f');
y=C{2};
%ƽ������
y=smooth(y);
plot(y);
%smoothY=smooth(y)
%subplot(1,2,1),plot(y);
%subplot(1,2,2),plot(smoothY);
%���ý�ȡ�Ĳ�
y1=y(180:240);
y2=y(460:520);
y3=y(550:610);

