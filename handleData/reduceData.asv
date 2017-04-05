features = zeros(0, length(X(1, :)));
classes = cell(0,1);
typeMap = containers.Map();
for i=1:length(AllRRType)
    typeMap(AllRRType(i)) = 0;
end
for i=1:length(X)
    classVal = char(Y(i));
    cnt = typeMap(classVal);
    if cnt < NumOfTrainData
        features = [features ; X(i,:)];
        classes = [classes; Y(i,:)];
        typeMap(classVal) = cnt +1;
    end
end
XCopy = X;
YCopy = Y;
X = features;
Y = classes;