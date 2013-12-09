load 'LabeledLineSignaturesTestSet.mat';
load 'LabeledLineSignaturesTrainSet.mat';
load 'BlobSignaturesTestSet.mat';
load 'BlobSignaturesTrainSet.mat';

% Set size probability matrix
szX = size(PatStringsTestSet, 2);
szY = size(PatStringsTrainSet, 2);
confusion = zeros(szX, szY);

% Concatenate pattern string of blob and line fingerprints
for i=1:szX
    combinedTrain{i} = [PatStringsTrainSet{i} S_storeTrainSet{i}];
    combinedTest{i} = [PatStringsTestSet{i} S_storeTestSet{i}];
end

% Iterate over matrix, calculate probability based on levenshtein distance
for i = 1:szX
	for j = 1:szY
        lt = size(PatStringsTrainSet{i},2) + size(S_storeTrainSet{i},2);
        confusion(j,i) = ((lt - LevenshteinDistance(combinedTrain{i}, combinedTest{j})) / lt) * 100;
	end
end

% plot confusion matrix
figure;
colormap('gray')
imagesc(confusion);