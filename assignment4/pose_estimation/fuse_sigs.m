load 'LabeledLineSignaturesTestSet.mat';
load 'LabeledLineSignaturesTrainSet.mat';
load 'BlobSignaturesTestSet.mat';
load 'BlobSignaturesTrainSet.mat';

szX = size(PatStringsTestSet, 2);
szY = size(PatStringsTrainSet, 2);
confusion = zeros(szX, szY);

for i=1:szX
    combinedTrain{i} = [PatStringsTrainSet{i} S_storeTrainSet{i}];
    combinedTest{i} = [PatStringsTestSet{i} S_storeTestSet{i}];
end

for i = 1:szX
	for j = 1:szY
        lt = length([S_storeTrainSet{i} PatStringsTrainSet{i}]);
        confusion(j,i) = ((lt - LevenshteinDistance(combinedTrain{i}, combinedTest{j})) / lt) * 100;
	end
end

% plot confusion matrix
figure;
colormap('gray')
imagesc(confusion);