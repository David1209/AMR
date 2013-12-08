load 'LabeledLineSignaturesTestSet.mat';
load 'LabeledLineSignaturesTrainSet.mat';
load 'BlobSignaturesTestSet.mat';
load 'BlobSignaturesTrainSet.mat';

szX = size(PatStringsTestSet, 2);
szY = size(PatStringsTrainSet, 2);
confusion = zeros(szX, szY);


for i = 1:szX
	for j = 1:szY
        lengthLines = length(PatStringsTrainSet{i});
        lengthBlobs = length(S_storeTrainSet{i});
        cfLines = ((lengthLines - LevenshteinDistance(PatStringsTrainSet{i}, PatStringsTestSet{j})) / lengthLines) * 100;
        cfBlobs = ((lengthBlobs - LevenshteinDistance(S_storeTrainSet{i}, S_storeTestSet{j})) / lengthBlobs) * 100;
        confusion(j,i) = (cfLines*0.5 + cfBlobs) / 1.5;
	end
end

% plot confusion matrix
figure;
colormap('gray')
imagesc(confusion);