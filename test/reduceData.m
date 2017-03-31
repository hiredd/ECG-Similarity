features = zeros(0, length(X(1, :)));
classes = cell(0,1);
typeMap = containers.Map();
allRRType = getAllRRType();
for i=1:length(allRRType)
    typeMap(allRRType(i)) = 0;
end
for i=1:length(X)
    classVal = char(Y(i));
    cnt = typeMap(classVal);
    if cnt < 2000
        features = [features ; X(i,:)];
        classes = [classes; Y(i,:)];
        typeMap(classVal) = cnt +1;
    end
end
X = features;
Y = classes;