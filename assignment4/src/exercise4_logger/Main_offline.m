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

% FREQUENCY OF ODOMETRY UPDATE:
F_O_U = 5;  %[Hz]

% NAME OF THE LOG FILE:
Log_name = 'log.txt';

%===================================%


% Open the log file for writing the data
FILE = fopen(Log_name, 'w');
data = Data();
for i = 11:71
    global file;
    file = ['../dataset/Onbewerkt/Picture ', int2str(i),'.jpg'];
    
    % Write encoder data to log file
    SaveEncoderData(FILE, toc, dx, dtheta, N); %get toc, dx and dtheta from data
    
    % Write laserscan data to log file
    laser_scans = GetLaserScans(N);
    SaveLaserData(FILE, toc, laser_scans);  %get toc form data
end
fclose(FILE);

display('Execution Complete!');
