loadGlobleVariable;
if ~exist('RF', 'var')
    loadTrainData;
    % Classification Tree is chosen as the learner
    mdl = ClassificationTree.template('NVarToSample','all');
    % Use Bagged Decision Trees to Classify the Data
    RF = fitensemble(allTrainFeatures,allTrainClasses,'Bag',150,mdl,'type','classification');
end
%% Predict Responses Using Both Approaches
allAccurency = cell(length(AllFileNumber), 1);
allLearningResult = cell(length(AllFileNumber), 1);
for i = 1 : length(AllFileNumber)
    features =  testFeatures{i};
    classes = testClasses{i};
    y_pred = predict(RF,features);
    [confmat,order] = confusionmat(classes,y_pred);
    learningResult = zeros(length(confmat), 3);
    accuracyNumCnt = 0;
    for j=1:length(confmat)
        learningResult( j, 1) = confmat( j, j);
        learningResult( j, 2) = sum(confmat( j, :)) -confmat( j,  j);
        learningResult( j, 3) = learningResult( j ,1) / sum(confmat( j, :));
        accuracyNumCnt = accuracyNumCnt +confmat( j, j);
    end
    allLearningResult{i} = learningResult;
    accuracy = accuracyNumCnt / sum(sum(confmat));
    allAccurency{i} = accuracy;
end
