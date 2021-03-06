
global center Rmax Rmin
path(path, './scans/');
configfile_blobs;

S_storeTrainSet = {};
PlaceIDTrainSet = {};
NumStrings = 0;
for i = 1:8
    global file;
    file = ['../dataset/TrainSet/', int2str(i),'.jpg'];
    snapshottmp = imread(file);
    img = imflipud(snapshottmp);
 	figure(12), clf; imshow(img);

	%% img center [row, col]
	img_center = center';
	radius = Rmax;
	radius_inner = Rmin;

	%% color segment
	[cl_angles, cl_center, cl_type] = color_segment(color_s, img, sat, lum, max_pxarea, min_pxarea, img_center, radius, radius_inner , stdthreshold);
	[ cl_center , cl_type ]

	%% just to see
	rad2deg(cl_angles)
	hold on
	plot([img_center(1, 1), img_center(1,1) + 100],[img_center(1,2), img_center(1,2)], 'y-');
	plot([img_center(1, 1), img_center(1,1)],[img_center(1,2), img_center(1,2) + 100], 'y-');
 
	if(isempty(cl_center) ~= 1)
		plot(cl_center(:, 2),  cl_center(:, 1), 'mx', 'MarkerSize', 5);
	end

	%% compute pattern string
	%% warning: angle=0 is center -> left
	S = ComputePatStringBlobs( cl_angles , cl_type);
	disp(sprintf('BLOB Pattern string:  %s', num2str(S)));

	S_storeTrainSet{i} = S;
	PlaceIDTrainSet{i} = i;
end
save 'BlobSignaturesTrainSet.mat' S_storeTrainSet PlaceIDTrainSet;

% Loop TestSet - while the user wants, get image, compute pattern, store pattern
S_storeTestSet = {};
PlaceIDTestSet = {};
NumStrings = 0;
for i = 1:8
    global file;
    file = ['../dataset/TestSet/', int2str(i),'.jpg'];
    snapshottmp = imread(file);
    img = imflipud(snapshottmp);
 	figure(12), clf; imshow(img);

	%% img center [row, col]
	img_center = center';
	radius = Rmax;
	radius_inner = Rmin;

	%% color segment
	[cl_angles, cl_center, cl_type] = color_segment(color_s, img, sat, lum, max_pxarea, min_pxarea, img_center, radius, radius_inner , stdthreshold);
	[ cl_center , cl_type ]

	%% just to see
	rad2deg(cl_angles)
	hold on
	plot([img_center(1, 1), img_center(1,1) + 100],[img_center(1,2), img_center(1,2)], 'y-');
	plot([img_center(1, 1), img_center(1,1)],[img_center(1,2), img_center(1,2) + 100], 'y-');
 
	if(isempty(cl_center) ~= 1)
		plot(cl_center(:, 2),  cl_center(:, 1), 'mx', 'MarkerSize', 5);
	end

	%% compute pattern string
	%% warning: angle=0 is center -> left
	S = ComputePatStringBlobs( cl_angles , cl_type);
	disp(sprintf('BLOB Pattern string:  %s', num2str(S)));

	S_storeTestSet{i} = S;
	PlaceIDTestSet{i} = i;
end
save 'BlobSignaturesTestSet.mat' S_storeTestSet PlaceIDTestSet;
close all