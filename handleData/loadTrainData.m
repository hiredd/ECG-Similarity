% 使用随机采样方式从所有数据中选择出一组数据作为训练用的数据

%% 获取所有数据的特征以及类别
if ~exist('allX','var')
    if ~exist('tampletWaves', 'var')
        loadTampletWaves;
    end
    allX = zeros(0, 5*NumOfRRType);
    allY = cell(0, 1);
    numOfFile = length(AllFileNumber);
    %为了能让获取特征的过程能够以多线程方式执行，先把所有的数据都存储到一个cell矩阵的不同列中
    Features = cell(numOfFile, 1);
    Classes = cell(numOfFile, 1);
    parfor i = 1 : NumOfRRType%
        [features, classes] = getFeaturesAndClasses(AllFileNumber(i), tampletWaves, NumOfRRType, NumOfTamplet, AllRRType);
        Features{i} = features;
        Classes{i} = classes;
    end
    for i=1 : numOfFile
        features = Features{i};
        classes = Classes{i};
        allX = [allX; features];
        allY = [allY; classes];
    end
end

%% 按类别聚集
gatheredX = cell(NumOfRRType, 1);
gatheredY = cell(NumOfRRType, 1);
gatheredIndex = ones(NumOfRRType, 1);
for i = 1 : NumOfRRType
    gatheredX{i} = zeros(0, 5*NumOfRRType);
    gatheredY{i} = cell(0, 1);
end

for i = 1 : length(allX)
    type = char(allY{i});
    typeIndex = RRTypeMap(type);
    gatheredX{typeIndex} = [gatheredX{typeIndex}; allX(i, :)];
    gatheredY{typeIndex} = [gatheredY{typeIndex}; type];
end

%% 打乱每个类别的数据
for i = 1 : NumOfRRType
    if ~isempty(gatheredX{i})%
        x = gatheredX{i};
        p = randperm(length(x(:, 1)));
        randx = zeros(length(x(:, 1)), 5*NumOfRRType);
        for j = 1 : length(x(:, 1))
            randx(j, :) = x(p(j), :);
        end
        gatheredX{i} = x;
    end
end

%% 取得训练数据
trainX = zeros(0, 5*NumOfRRType);
trainY = cell(0, 1);
for i = 1 : NumOfRRType
    x = gatheredX{i};
    y = gatheredY{i};
    numOfX = length(x(:, 1));
    if numOfX>NumOfTrainData
        numOfTrainX = NumOfTrainData;
    else
        numOfTrainX = ceil(numOfX*(1-PercentageOfTestData));
    end
    trainX = [trainX; x(1:numOfTrainX, :)];
    trainY = [trainY; y(1:numOfTrainX)];
end