loadGlobleVariable;
loadTrainData;
%% Use Bagged Decision Trees to Classify the Data
% Classification Tree is chosen as the learner
mdl = ClassificationTree.template('NVarToSample','all');
RF = fitensemble(trainX,trainY,'Bag',150,mdl,'type','classification');
%% Predict Responses Using Both Approaches
[features, classes] = getFeaturesAndClasses(100, tampletWaves);
y_pred = predict(RF,features);
[confmat,order] = confusionmat(classes,y_pred)