load 'LabeledLineSignaturesTestSet.mat';
load 'LabeledLineSignaturesTrainSet.mat';


szX = size(PatStringsTestSet, 2);
szY = size(PatStringsTrainSet, 2);
confusion = zeros(szX, szY);


for i = 1:szX
	for j = 1:szY
	    confusion(i,j) = LevenshteinDistance(PatStringsTestSet{i}, PatStringsTrainSet{j});	
	end
end

% display results
PlaceID
confusion

% plot confusion matrix
colormap('gray')
xlabel('Train')
ylabel('Test')
imagesc(confusion);