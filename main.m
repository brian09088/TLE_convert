clc,clear,close all

% File path to the TLE file
tleFilePath = 'E:/MATLAB/碩士論文/Brian_Su/read_TLE/TLE/starlink_constellation.TLE';

% Get all satellites
satellites = read_all_satellites(tleFilePath);

% Check how many satellites were found
num_sats = length(satellites);
fprintf('Number of satellites found: %d\n', num_sats);

satellite_data = cell(num_sats, 1);  % To store data for all satellites

% Loop through each satellite to parse the orbital elements
for i = 1:num_sats
    % Get the raw TLE lines for the current satellite
    tle_lines = {satellites{i}.header, satellites{i}.line1, satellites{i}.line2};
    
    % Call the new `parse_tle` function to get the orbital elements
    [satnum, a, ecc, Incl, Omega, w, M, n] = parse_tle(tle_lines);
    
    % Store the parsed data in a structure
    satellite_data{i} = struct('satnum', satnum, 'semi_major_axis', a, ...
                               'eccentricity', ecc, 'inclination', Incl, ...
                               'RA_of_asc_node', Omega, 'Arg_of_perigee', w, ...
                               'Mean_anomaly', M, 'Mean_motion', n);
end

% Save the satellite orbital data to a MAT file
save('satellite_orbital_data.mat', 'satellite_data');