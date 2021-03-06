function GetLinePattern()

NumStrings = 0;
PatStringsTrainSet = {};
PlaceIDTrainSet = [];
for i = 1:8
  NumStrings = NumStrings + 1;
  
  global file;
  file = ['../dataset/TrainSet/', int2str(i),'.jpg'];
  % Get a new scan
  XY = GetNextScan;
  XY = XY';
  
  % Plot raw scan
  figure(1), clf, axis([-0.5 0.5 -0.5 0.5]), grid on; hold on;
  plot(XY(1,:), XY(2,:), 'r.');

  % Extract line segments
  [NLines, r, alpha, segend, seglen] = recsplit(XY);
  disp(sprintf('Number of extracted lines: %d\n', NLines));

  % Plot extracted segments
  figure(2), clf, axis([-0.5 0.5 -0.5 0.5]), grid on; hold on;
  color = 0;
  for i=1:NLines
    if color == 0, c = 'r'; elseif color == 1, c = 'b'; else c = 'g'; end
    line([segend(i,1) segend(i,3)], [segend(i,2) segend(i,4)], ...
	 'color', c, 'linewidth', 3);
    color = mod(color+1, 3);
  end
  
  % Compute the string
  S = ComputePatStringLines(NLines, segend, seglen);
  disp(sprintf('Pattern string:  %s', num2str(S)));
  
  % Store the pattern string and place ID
  PatStringsTrainSet{NumStrings} = S;
end
save 'LabeledLineSignaturesTrainSet.mat' PatStringsTrainSet PlaceIDTrainSet;

% test set
NumStrings = 0;
PatStringsTestSet = {};
PlaceIDTestSet = [];
for i = 1:8
  NumStrings = NumStrings + 1;
  global file;
  file = ['../dataset/TestSet/', int2str(i),'.jpg'];
  % Get a new scan
  XY = GetNextScan;
  XY = XY';
  
  % Plot raw scan
  figure(1), clf, axis([-0.5 0.5 -0.5 0.5]), grid on; hold on;
  plot(XY(1,:), XY(2,:), 'r.');

  % Extract line segments
  [NLines, r, alpha, segend, seglen] = recsplit(XY);
  disp(sprintf('Number of extracted lines: %d\n', NLines));

  % Plot extracted segments
  figure(2), clf, axis([-0.5 0.5 -0.5 0.5]), grid on; hold on;
  color = 0;
  for i=1:NLines
    if color == 0, c = 'r'; elseif color == 1, c = 'b'; else c = 'g'; end
    line([segend(i,1) segend(i,3)], [segend(i,2) segend(i,4)], ...
	 'color', c, 'linewidth', 3);
    color = mod(color+1, 3);
 
  end
  
  
  % Compute the string
  S = ComputePatStringLines(NLines, segend, seglen);
  disp(sprintf('Pattern string:  %s', num2str(S)));
  
  % Store the pattern string and place ID
  PatStringsTestSet{NumStrings} = S;
end
save 'LabeledLineSignaturesTestSet.mat' PatStringsTestSet PlaceIDTestSet;

close all
return

