load 'LabeledLineSignaturesTestSet.mat';
load 'LabeledLineSignaturesTrainSet.mat';


szX = size(PatStringsTestSet, 2);
szY = size(PatStringsTrainSet, 2);
confusion = zeros(szX, szY);


for i = 1:szX
	for j = 1:szY
        length = length(PatStringsTrainSet{i});
        confusion(j,i) = ((length - LevenshteinDistance(PatStringsTrainSet{i}, PatStringsTestSet{j})) / length) * 100;
	end
end

% plot confusion matrix
figure;
colormap('gray')
imagesc(confusion);