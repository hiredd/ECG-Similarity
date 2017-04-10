% ��ÿ���ļ��а�������Ϊ70%ȡ��ѵ������

%% ��ȡ�������ݵ������Լ����
if ~exist('tampletWaves', 'var')
    loadTampletWaves;
end
numOfFile = length(AllFileNumber);
trainFeatures = cell(numOfFile, 1);
trainClasses = cell(numOfFile, 1);
testFeatures = cell(numOfFile, 1);
testClasses = cell(numOfFile, 1);
parfor i = 1 :numOfFile%
    [features, classes] = getFeaturesAndClasses(AllFileNumber(i), tampletWaves, NumOfRRType, NumOfTamplet, AllRRType);
    cv = cvpartition(classes,'holdout',0.3);
    trainFeatures{i} = features(training(cv),:);
    trianClasses{i} = classes(training(cv));
    testFeatures{i} = features(test(cv),:);
    testClasses{i} = classes(test(cv));
end
allTrainFeatures = zeros(0, 5*NumOfRRType);
allTrainClasses = cell(0, 1);
for i=1 : numOfFile
    allTrainFeatures = [allTrainFeatures; trainFeatures{i}];
    allTrainClasses = [allTrainClasses; trainClasses{i}];
end