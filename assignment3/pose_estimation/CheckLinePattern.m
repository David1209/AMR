load 'LabeledLineSignaturesTestSet.mat';
load 'LabeledLineSignaturesTrainSet.mat';

% Set size probability matrix
szX = size(PatStringsTestSet, 2);
szY = size(PatStringsTrainSet, 2);
confusion = zeros(szX, szY);

% Iterate over matrix, calculate probability based on levenshtein distance
for i = 1:szX
	for j = 1:szY
        length = size(PatStringsTrainSet{i},2);
        confusion(j,i) = ((length - LevenshteinDistance(PatStringsTrainSet{i}, PatStringsTestSet{j})) / length) * 100;
	end
end

% plot probability matrix
figure;
colormap('gray')
imagesc(confusion);