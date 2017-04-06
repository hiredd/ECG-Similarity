%% ����ÿ���ļ���Q��S�������Ƿ����
allFileNumber = getAllFileNumber();
% parfor i=1:length(allFileNumber)
%     dataNumber = allFileNumber(i);
%     display(['�ļ��ţ�' num2str(dataNumber)]);
%     [waveData, ~] = loadDatFile(dataNumber);
%     [rrNumber, ~, ~] = loadRRFile(dataNumber);
%     [qwaves, swaves] = findQS(rrNumber, waveData);
%     for j=2:length(qwaves)
%         if swaves(j-1)>qwaves(j)
%             error('qs���Ҵ���');
%         end
%     end
% end
%% ����QR�κ�RS�γ���
qrCounter = ones(1000,1);
rsCounter = ones(1000,1);
for i=1:length(allFileNumber)
    dataNumber = allFileNumber(i);
    [waveData, ~] = loadDatFile(dataNumber);
    [rrNumber, ~, ~] = loadRRFile(dataNumber);
    [qwaves, swaves] = findQS(rrNumber, waveData);
    for j=2:length(rrNumber)-1
        qrLen = rrNumber(j)-qwaves(j);
        if ~qrLen==0
            qrIndex = floor(qrLen);
            qrCnt = qrCounter(qrIndex)+1;
            qrCounter(qrIndex) = qrCnt;
        end
        rsLen = swaves(j)-rrNumber(j);
        if ~rsLen==0            
            rsIndex = floor(rsLen);
            rsCnt = qrCounter(rsIndex)+1;
            rsCounter(qrIndex) = rsCnt;
        end
    end
end