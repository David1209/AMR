% =================================================================
% 
%  Main.m
%  Closed-loop position control for differential-drive robots.
% 
%  The calling syntax is:
%       Main
%
%  Reference:
%  Introduction to: Autonomous Mobile Robots, Chapter 3.
% 
%  This is an M-file for MATLAB.  
%  Tested in: Matlab 7.1.0
%  Date: 12.04.07
%
% =================================================================*/

path(path, './scans/');
path(path, './odometry/');

%===================================%
%   PARAMETERS TO CHANGE            %
%===================================%

% NUMBER OF SCANS:
N = 360;

% TIME BETWEEN TWO SNAPSHOTS:
T_b_S = 0.5;  %[s]

% NAME OF THE LOG FILE:
Log_name = 'log.txt';

global center;
center = [462; 340];

%===================================%


% Open the log file for writing the data
FILE = fopen(Log_name, 'w');
data = Data();
for i = 11:71
    % Skip corrupted photo
    if i == 24
        continue;
    end
    
    global file;
    file = ['../dataset/Onbewerkt/Picture', int2str(i),'.jpg'];
    
    elap_time = (i - 11) * T_b_S;
    
    % Write encoder data to log file
    SaveEncoderData(FILE, elap_time, 0.01*data(i-10,1), deg2rad(data(i-10,2)), N); %get toc, dx and dtheta from data
    
    % Write laserscan data to log file
    laser_scans = GetLaserScans(N);
    SaveLaserData(FILE, elap_time, laser_scans);  %get toc form data
    
    % Reset center from photo 50
    if i == 50
        center = [462; 335];
    end
end
fclose(FILE);

display('Execution Complete!');
