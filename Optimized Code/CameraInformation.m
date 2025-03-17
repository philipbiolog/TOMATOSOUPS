function camInfo = CameraInformation(x)

    switch x 
        case 1
            % Cam 1
            X = 5.23441573719257125;                        % Meters
            Z = 0.06492045842642645004;
            Y = 2.938185923755515905;
            
            camInfo.att = [0.5851339;0;89.7897107];         % Degrees
            camInfo.res = [3840;2160];
            
            camInfo.FOV_w = 107;
            camInfo.FOV_l = 74.22; % deg
  
        case 2
            % Cam 2
            X = 0;
            Y = 0;
            Z = 0;
    
            camInfo.att = [0;0;0];
            camInfo.res = [3840;2160];
            
            camInfo.FOV_w = 107;
            camInfo.FOV_l = 74.22; % deg
        case 3
        case 4
        case 5
        case 6
        case 7
        case 8
        otherwise
            camInfo = 0;
    end
    camInfo.pos = [X; Y; Z]; % 3x1 Vector

end
