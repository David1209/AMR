load 'BlobSignaturesTrainSet.mat';

% Set size Levenshtein distance matrix
sz = size(S_storeTrainSet, 2);     
confusion = zeros(sz, sz);

% Iterate over matrix, calculate Levenshtein distance
for i = 1:sz
	for j = 1:sz
	    confusion(i,j) = LevenshteinDistance(S_storeTrainSet{i}, S_storeTrainSet{j})
	end
end

% plot confusion matrix
colormap('gray')
imagesc(confusion);