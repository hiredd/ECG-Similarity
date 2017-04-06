% ʹ�����������ʽ������������ѡ���һ��������Ϊѵ���õ�����

%% ��ȡ�������ݵ������Լ����
if ~exist('allX','var')
    if ~exist('tampletWaves', 'var')
        loadTampletWaves;
    end
    allX = zeros(0, 5*NumOfRRType);
    allY = cell(0, 1);
    numOfFile = length(AllFileNumber);
    %Ϊ�����û�ȡ�����Ĺ����ܹ��Զ��̷߳�ʽִ�У��Ȱ����е����ݶ��洢��һ��cell����Ĳ�ͬ����
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

%% �����ۼ�
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

%% ����ÿ����������
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

%% ȡ��ѵ������
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