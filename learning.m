%% Load Data for Classification
aSetOfdataNumber = getAllFileNumber();
%load('C:\Users\ZYC\Documents\MATLAB\ECG-1\data\tampletWaves');
loadTampletWaves;
lenOfHeartBeatType = length(tampletWaves(:,1));
X = zeros(0, 5*lenOfHeartBeatType);
Y = cell(0, 1);
% lenOfDataNum = length(aSetOfdataNumber);
lenOfDataNum = length(aSetOfdataNumber);
Features = cell(lenOfDataNum, 1);
Classes = cell(lenOfDataNum, 1);
parfor i =1:lenOfDataNum
    display(i);%
    [features, classes] = getFeaturesAndClasses(aSetOfdataNumber(i), tampletWaves);
    Features{i} = features;
    Classes{i} = classes;
%     X = [X; features];
%     Y = [Y; classes];
end
for i=1:lenOfDataNum
    features = Features{i};
    classes = Classes{i};
    X = [X; features];
    Y = [Y; classes];
end
% X = features;
% Y = classes;
%% Partition 70% of the Data into a Training Set and 30% into a Test Set
cv = cvpartition(Y,'holdout',0.3);
Xtrain = X(training(cv),:);
Ytrain = Y(training(cv));
Xtest = X(test(cv),:);
Ytest = Y(test(cv));
%% Use Bagged Decision Trees to Classify the Data
% Classification Tree is chosen as the learner
mdl1 = ClassificationTree.template('NVarToSample','all');
RF1 = fitensemble(Xtrain,Ytrain,'Bag',150,mdl1,'type','classification');
%% Predict Responses Using Both Approaches
y_pred1 = predict(RF1,Xtest);
[confmat1,order] = confusionmat(Ytest,y_pred1)