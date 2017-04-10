learningResult = zeros(length(confmat), 3);
accuracyNumCnt = 0;
for i=1:length(confmat)
    learningResult(i, 1) = confmat(i, i);
    learningResult(i, 2) = sum(confmat(i, :)) -confmat(i, i);
    learningResult(i, 3) = learningResult(i ,1) / sum(confmat(i, :));
    accuracyNumCnt = accuracyNumCnt +confmat(i, i);
end
accuracy = accuracyNumCnt / sum(sum(confmat))
% HeatMap(confmat, 'Annotate', 1, 'ColumnLabels',order, 'RowLabels', order);
% i = 1;
% while i <=length(learningResult)
%     if sum(learningResult(i))<=50
%         learningResult(i, :) = [];
%     else
%         i = i+1;
%     end
% end
% figure(1)
b = bar([learningResult(:, 3) 1-learningResult(:, 3)], 'stacked');
% for i=1:length(learningResult)
%     text(i-0.05, 1.05, labels(i));
% end
% figure(2)
% plot(learningResult(:, 1));
% hold on
% plot(learningResult(:, 2));
set(gca,'XTickLabel',order);
