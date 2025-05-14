clc; clear; close all;

% Get current date in "Month Day Year" format
currentDate = datestr(now, 'mmm dd yyyy');

% Prompt user to select the spreadsheet file
fprintf('Please select the Flight Data Spreadsheet...\n');
[file, path] = uigetfile('*.xlsx', 'Select the Flight Data Spreadsheet');
if isequal(file, 0)
    error('No file selected. Script terminated.');
end
dataTable = readtable(fullfile(path, file));

% Extract columns
globalFlightNumbers = dataTable{:, 1}; % Column 1: Global Flight Number
sectionNumbers = dataTable{:, 2};      % Column 2: Section Number
teamNames = dataTable{:, 3};          % Column 3: Team Name
teamFlightNumbers = dataTable{:, 4};  % Column 4: Team Flight Number

% Prompt user to select the main folder containing all camera subfolders
fprintf('\nPlease select the folder that contains all 8 camera folders...\n');
mainVideoFolder = uigetdir(pwd, 'Select the Folder Containing All Camera Folders');
if mainVideoFolder == 0
    error('No folder selected. Script terminated.');
end

% Automatically detect and assign camera folders based on naming convention
cameraFolders = cell(1, 8);
for camNum = 1:8
    camFolderName = sprintf('Camera %d', camNum);
    camFolderPath = fullfile(mainVideoFolder, camFolderName);
    
    if exist(camFolderPath, 'dir')
        cameraFolders{camNum} = camFolderPath;
        fprintf('Detected Camera %d folder: %s\n', camNum, camFolderPath);
    else
        warning('Folder for Camera %d not found: %s. Skipping...', camNum, camFolderPath);
        cameraFolders{camNum} = ''; % Store empty to prevent errors
    end
end

% Define the main directory for processed flight videos
flightVideosDir = fullfile(pwd, sprintf('Flight Videos %s', currentDate));

% Create the main directory if it does not exist
if ~exist(flightVideosDir, 'dir')
    mkdir(flightVideosDir);
    fprintf('Created folder: %s\n', flightVideosDir);
end

tic; % Start timer AFTER last folder selection

% Initialize counters
totalFilesSorted = 0;
successfulFlightsSorted = 0;

% Process each flight entry from the spreadsheet
for i = 1:length(globalFlightNumbers)
    globalFlight = globalFlightNumbers(i);

    % Format folder names
    section = sprintf('Section_%03d', str2double(sectionNumbers(i)));
    team = char(teamNames(i));
    teamFlight = teamFlightNumbers(i);

    % Create folder structure
    sectionFolder = fullfile(flightVideosDir, section);
    if ~exist(sectionFolder, 'dir'), mkdir(sectionFolder); end
    
    teamFolder = fullfile(sectionFolder, team);
    if ~exist(teamFolder, 'dir'), mkdir(teamFolder); end
    
    flightFolder = fullfile(teamFolder, sprintf('Flight_%d', teamFlight));
    if ~exist(flightFolder, 'dir'), mkdir(flightFolder); end

    % Track success for this flight
    flightSorted = false;

    % Process each camera
    for camNum = 1:8
        camFolder = cameraFolders{camNum};
        if isempty(camFolder)
            continue;
        end

        camFiles = dir(fullfile(camFolder, '*.mp4'));
        [~, sortIdx] = sort([camFiles.datenum]);
        sortedFiles = camFiles(sortIdx);

        if length(sortedFiles) < globalFlight
            warning('Not enough videos in Camera %d for Flight %d. Skipping...', camNum, globalFlight);
            continue;
        end

        srcFile = fullfile(camFolder, sortedFiles(globalFlight).name);
        newFileName = sprintf('%s Flight %d Camera %d.mp4', team, teamFlight, camNum);
        destFile = fullfile(flightFolder, newFileName);

        % COPY, do not move or delete
        copyfile(srcFile, destFile);
        fprintf('Copied: %s -> %s\n', srcFile, destFile);
        totalFilesSorted = totalFilesSorted + 1;
        flightSorted = true;
    end

    if flightSorted
        successfulFlightsSorted = successfulFlightsSorted + 1;
    end
end

% Final report
elapsedTime = toc;
fprintf('\nSorting completed!\n');
fprintf('Total execution time: %.2f seconds\n', elapsedTime);
fprintf('Total videos sorted: %d\n', totalFilesSorted);
fprintf('Total flight tests successfully sorted: %d\n', successfulFlightsSorted);
disp('All files have been successfully grouped by flight number.');
