clc,clear,close all

%% Time Interval / Create and Vddisualize Scenario
startTime = datetime(2024,4,20,8,0,0);
stopTime = startTime + hours(8.5);
sampleTime = 30; % seconds
sc = satelliteScenario(startTime,stopTime,sampleTime);
viewer = satelliteScenarioViewer(sc,ShowDetails=false);

%% convert TLE file to orbit parameters
% tleFilePath = 'E:/MATLAB/碩士論文/Brian_Su/read_TLE/norad.tle';

fullPath = mfilename('fullpath');   % % Get full path of current function
[currentFolder, ~, ~] = fileparts(fullPath);   % Get the folder containing function
tleFileName = 'norad.tle';  % Define name of TLE file
tleFilePath = fullfile(currentFolder, tleFileName); % Construct full path

% convert from TLE files, get 6 orbit parameter elements
[A0, satnum, semi_major_axis, eccentricity, inclination,...
    RA_of_asc_node, Arg_of_perigee, Mean_anomaly, Mean_motion] = convert_TLE(tleFilePath);

disp("/*/*/*")
fprintf('Satellite Number: %d\n', satnum);
fprintf('Semi-Major Axis: %.2f km\n', semi_major_axis);
fprintf('Eccentricity: %.4f\n', eccentricity);
fprintf('Inclination: %.2f degrees\n', inclination);
fprintf('RA of Ascending Node: %.2f degrees\n', RA_of_asc_node);
fprintf('Argument of Perigee: %.2f degrees\n', Arg_of_perigee);
fprintf('Mean Anomaly: %.2f degrees\n', Mean_anomaly);
fprintf('Mean Motion: %.4f rev/day\n', Mean_motion);
disp("/*/*/*")

% Create satellite in MATLAB
%sat = satellite(sc, semi_major_axis, eccentricity, inclination, ...
%    rightAscensionOfAscendingNode, argumentOfPeriapsis, ...
%    trueAnomaly, Name="NORAD_1 ~ NORAD_66");
% show(sat)

function [A0, satnum, semi_major_axis, eccentricity, ...
    inclination, RA_of_asc_node, Arg_of_perigee, ...
    Mean_anomaly, Mean_motion] = convert_TLE(tleFilePath)

    % Earth's gravitational parameter
    % mu = 3.986e14;      % m^3/s^2
    
    % semi_major_axis;    % meters
    % eccentricity;
    % inclination;        % deg
    % RA_of_asc_node;     % deg
    % Arg_of_perigee;     % deg
    % Mean_anomaly;       % deg
    % Mean_motion;        % rev/day
    
    % Your TLE file path
    tleFilePath = 'E:/MATLAB/碩士論文/Brian_Su/read_TLE/norad.tle';
    
    % readtle(tleFilePath)

    % Read the TLE data
    [A0, satnum, a, ecc, Incl, Omega, w, M, n] = readtle(tleFilePath);

    semi_major_axis = a;  % Semi-major axis in km
    eccentricity = ecc;   % Eccentricity
    inclination = Incl;   % Inclination in degrees
    RA_of_asc_node = Omega;  % Right Ascension of Ascending Node in degrees
    Arg_of_perigee = w;  % Argument of Perigee in degrees
    Mean_anomaly = M;   % Mean Anomaly at epoch in degrees
    Mean_motion = n;    % Mean motion in revolutions per day

end