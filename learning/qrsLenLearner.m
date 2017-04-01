%% Load Data for Classification
if  ~exist('qrFeatures','var')
    allFileNumber = getAllFileNumber();
    numOfFile = length(allFileNumber);
    qrFeatures = cell(numOfFile, 1);
    rsFeatures = cell(numOfFile, 1);
    qrClasses = cell(numOfFile, 1);
    rsClasses = cell(numOfFile, 1);
    parfor i =1:numOfFile
        display(i)
        qrfeatures = zeros(0, 2);
        rsfeatures = zeros(0, 2);
        qrclasses = zeros(0, 1);
        rsclasses = zeros(0, 1);
        dataNumber = allFileNumber(i);
        [waveData, ~] = loadDatFile(dataNumber);
        [rrNumber, rrType, ~] = loadRRFile(dataNumber);
        [qwaves, swaves] = findQS(rrNumber, waveData);
        for j=2:length(rrNumber)-1
            r0r1Len = rrNumber(j) - rrNumber(j-1);
            r1r2Len = rrNumber(j+1) - rrNumber(j);
            rrtype = mapRRType2Num(char(rrType(j)));
            qrfeatures{j-1, 1} = r0r1Len;
            qrfeatures{j-1, 2} = rrtype;
            rsfeatures{j-1, 1} = r1r2Len;
            rsfeatures{j-1, 2} = rrtype;
            qrLen = floor(rrNumber(j)-qwaves(j));
            rsLen = floor(swaves(j)-rrNumber(j));
            qrclasses{j-1, 1} = qrLen;
            rsclasses{j-1, 1} = rsLen;
        end
        qrFeatures{i} = qrfeatures;
        rsFeatures{i} = rsfeatures;
        qrClasses{i} = qrclasses;
        rsClasses{i} = rsclasses;
    end
end

if ~exist('qrX','var')
    qrX = zeros(0, 2);
    rsX = zeros(0 ,2);
    qrY = zeros(0, 1);
    rsY = zeros(0, 1);
    parfor i=1:numOfFile
        qrx = qrFeatures{i};
        qry = qrClasses{i};
        rsx = rsFeatures{i};
        rsy = rsClasses{i};
        qrX = [qrX; cell2mat(qrx)];
        rsX = [rsX; cell2mat(rsx)];
        qrY = [qrY; cell2mat(qry)];
        rsY = [rsY; cell2mat(rsy)];
    end
end

%% Partition 70% of the Data into a Training Set and 30% into a Test Set
cv = cvpartition(qrY,'holdout',0.3);
Xtrain = qrX(training(cv),:);
Ytrain = qrY(training(cv));
Xtest = qrX(test(cv),:);
Ytest = qrY(test(cv));
%% Use Bagged Decision Trees to Classify the Data
% Classification Tree is chosen as the learner
qrmdl = ClassificationTree.template('NVarToSample','all');
qrRF = fitensemble(Xtrain,Ytrain,'Bag',150,qrmdl,'type','classification');
%% Predict Responses Using Both Approaches
y_pred1 = predict(qrRF,Xtest);
[qrconfmat,qrorder] = confusionmat(Ytest,y_pred1)