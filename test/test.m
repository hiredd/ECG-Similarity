allRRType = getAllRRType();
i = 1;
while i <= length(classes)
    typeVal = char(classes(i));
    if ~isStrMatrixContain(allRRType, typeVal)
        classes{i} = [];
        features(i, :) = [];
    else
        i = i+1;
    end
end