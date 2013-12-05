load 'BlobSignaturesTestSet.mat';
load 'BlobSignaturesTrainSet.mat';


szX = size(S_storeTestSet, 2);
szY = size(S_storeTrainSet, 2);
confusion = zeros(szX, szY);


for i = 1:szX
	for j = 1:szY
	    confusion(i,j) = LevenshteinDistance(S_storeTestSet(i).lev, S_storeTrainSet(j).lev);	
	end
end

% display results
confusion

% plot confusion matrix
colormap('gray')
xlabel('Train')
ylabel('Test')
imagesc(confusion);