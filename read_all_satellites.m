%% Create a function that reads the TLE file and extracts the data for each satellite

% total : 143 Satellites 
% norad.tle have 429 rows (3 rows contain one satellite)
% tleFilePath = 'E:/MATLAB/碩士論文/Brian_Su/read_TLE/norad.tle';
% tleFilePath = 'E:/MATLAB/碩士論文/Brian_Su/read_TLE/TLE/starlink_constellation.TLE';

function SAT_constellation = read_all_satellites(tleFilePath)

    % Open the TLE file
    fid = fopen(tleFilePath, 'r');
    
    % Check if the file opened successfully
    if fid == -1
        error('Could not open the TLE file. Please check the path.');
    end
    
    SAT_constellation = {};  % Initialize a cell array to hold satellite data
    
    % Read the file line-by-line
    while ~feof(fid)
        % Read the first line (satellite name/ID)
        header = fgetl(fid);
        line1 = fgetl(fid);  % Read the first line of TLE
        line2 = fgetl(fid);  % Read the second line of TLE
        
        if ischar(header) && ischar(line1) && ischar(line2)
            % Store the satellite information in a structure
            sat_info = struct('header', header, 'line1', line1, 'line2', line2);
            SAT_constellation{end + 1} = sat_info;  % Append to the list
        end
    end     
        
    fclose(fid);  % Close the file
end

