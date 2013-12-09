% adapted from luciano's test function

load 'LabeledLineSignaturesTrainSet.mat';

sz = size(PatStringsTrainSet, 2);
confusion = zeros(sz, sz);


for i = 1:sz
	for j = 1:sz
	    confusion(i,j) = LevenshteinDistance(PatStringsTrainSet{i}, PatStringsTrainSet{j});
	end
end

% display results
PlaceID
confusion

% plot confusion matrix
colormap('gray')
imagesc(confusion);