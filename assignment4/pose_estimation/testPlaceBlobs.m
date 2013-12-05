
load 'BlobSignaturesTrainSet.mat';

sz = size(S_store, 2);     
confusion = zeros(sz, sz);
S_store
for i = 1:sz
	for j = 1:sz
	    confusion(i,j) = LevenshteinDistance(S_store(i).lev, S_store(j).lev);	
	end
end  

% display results
PlaceID
confusion

% plot confusion matrix
colormap('gray')
imagesc(confusion);