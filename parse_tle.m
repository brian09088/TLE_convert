function [satnum, a, ecc, Incl, Omega, w, M, n] = parse_tle(tle_lines)
    % Parse the TLE lines to extract satellite information
    
    % First line should be a header (not used for calculations)
    A0 = tle_lines{1};
    
    % Second and third lines are the TLE data
    A1 = tle_lines{2};
    A2 = tle_lines{3};
    
    % Extract the orbital elements
    satnum = str2double(A1(3:7));  % Satellite number
    Incl = str2double(A2(9:16));   % Inclination in degrees
    Omega = str2double(A2(18:25)); % RA of ascending node in degrees
    ecc = str2double(['.' A2(27:33)]);  % Eccentricity
    w = str2double(A2(35:42));  % Argument of perigee in degrees
    M = str2double(A2(44:51));  % Mean anomaly in degrees
    n = str2double(A2(53:63));  % Mean motion in revs per day
    
    % Compute the semi-major axis
    mu = 398.6e12;  % Standard gravitational parameter in m^3/s^2
    T = 86400 / n;  % Period of one orbit in seconds
    a = ((T / (2 * pi))^2 * mu)^(1/3);  % Semi-major axis in meters
end
