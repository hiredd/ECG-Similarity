%% Load Data for Classification
if ~exist('X','var')
    if ~exist('tampletWaves', 'var')
        loadTampletWaves();
    end
    allDataFile = getAllFileNumber();
    lenOfRRType = length(tampletWaves(:,1));
    X = zeros(0, 5*lenOfRRType);
    Y = cell(0, 1);
    % lenOfDataNum = length(aSetOfdataNumber);
    lenOfDataNum = length(allDataFile);
    Features = cell(lenOfDataNum, 1);
    Classes = cell(lenOfDataNum, 1);
    for i =16:17
        display(i)
        [features, classes] = getFeaturesAndClasses(allDataFile(i), tampletWaves);
        Features{i} = features;
        Classes{i} = classes;
    end
    for i=1:lenOfDataNum
        features = Features{i};
        classes = Classes{i};
        X = [X; features];
        Y = [Y; classes];
    end
end
reduceData;
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