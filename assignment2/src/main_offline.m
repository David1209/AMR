%LASERSCAN_TEST
%
%   Author Davide Scaramuzza - davide.scaramuzza@ieee.org
%   ETH Zurich - April, 25, 2007

%stop(vid);
% Configure the object for manual trigger mode.
%triggerconfig(vid, 'manual');

% Now that the device is configured for manual triggering, call START.
% This will cause the device to send data back to MATLAB, but will not log
% frames to memory at this point.
%start(vid)

% -------------------------------------------------------------------------
% MOST IMPORTANT PARAMETERS
% -------------------------------------------------------------------------
% Rmax = 160;%        Max detectable distance, set to 160 pixels in VGA images.
%                     Rmax was already loaded when calling "calibrate_camera.m"
% Rmin = 77;%         Min detectable distance in pixels in VGA image
%                     Rmin was already loaded when calling "calibrate_camera.m"
% increase alpha so straight lines are striaght
alpha = 120;%          Radial distortion coefficient, YOU MAY NEED TO TUNE THIS PARAMETER!!!!!!!!!!!!!!!!!!!!!!!!!!!!
height = 0.17;%       camera height in meters, YOU MAY NEED TO TUNE THIS PARAMETER!!!!!!!!!!!!!!!!!!!!!!!!!!!!
BWthreshold = 200;%   Threshold for segment the image into Black & white colors, YOU MAY NEED TO TUNE THIS PARAMETER!!!!!!!!!!!!!!!!!!!!!!!!!!!!
angstep = 1.0;%       Angular step of the beam in degrees
axislimit = 0.8;%     Axis limit

Rmin = 80;            % Overwrite value from calibration step.

% -------------------------------------------------------------------------
% MAIN
% -------------------------------------------------------------------------
for i=1:35
    tic;%                               Start counting elapsed time
    
    file = 'c.jpg';
    snapshot = imread(file);
    
    snapshot = imflipud(snapshot); 
    %imagesc(snapshot);
    calibrate_camera_offline
    
    % Create rectangular image
    [undistortedimg, theta] = imunwrap(snapshot, center, angstep, Rmax, Rmin);
    %figure; 
    %imagesc(undistortedimg); 
    colormap(gray);

    % Black White image
    Bwthreshold = 100;
    BWimg = img2bw(undistortedimg, Bwthreshold); 
    figure;
    imagesc(BWimg);
    colormap(gray);

    % Wall contours
    rho = getpixeldistance( BWimg , Rmin ); 
    figure; 
    imagesc(snapshot); 
    hold on; 
    drawlaserbeam(center, theta, rho ); 
    hold off;
    
    % Real distances
    dist = undistort_dist_points(theta, rho, alpha, height); 
    figure; 
    draw_undistorted_beam(dist, theta, axislimit);
    
    
    % Remove infinite numbers in rho (bug)
    rep=find(rho==inf);
    rho(rep) = Rmax;
    % Error propagation
    sigma_rho = std(rho)*0.1;
    sigma_dist = compute_uncertainty(rho, sigma_rho, alpha, height);
    hold on; 
    draw_uncertainty(dist, theta, sigma_dist);

    
    % Compute the time per frame and effective frame rate.
    elapsedTime = toc;
    effectiveFrameRate = 1/elapsedTime
end