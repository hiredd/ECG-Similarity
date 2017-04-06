learningResult = zeros(length(confmat1), 3);
accuracyNumCnt = 0;
for i=1:length(confmat1)
    learningResult(i, 1) = confmat1(i, i);
    learningResult(i, 2) = sum(confmat1(i, :)) -confmat1(i, i);
    learningResult(i, 3) = learningResult(i ,1) / sum(confmat1(i, :));
    accuracyNumCnt = accuracyNumCnt +confmat1(i, i);
end
accuracy = accuracyNumCnt / sum(sum(confmat1))
% HeatMap(confmat1, 'Annotate', 1, 'ColumnLabels',order, 'RowLabels', order);
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
