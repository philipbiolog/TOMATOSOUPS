classdef FileProcessingApp < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                     matlab.ui.Figure
        SelectFolderButton           matlab.ui.control.Button
        MethodDropDownLabel          matlab.ui.control.Label
        MethodDropDown               matlab.ui.control.DropDown
        StartProcessingButton        matlab.ui.control.Button
        
        % Internal Properties
        FolderPath                   char
        MethodChoice                 char
        OutputFromFirstFunction
    end

    methods (Access = private)

        % Button pushed function: SelectFolderButton
        function SelectFolderButtonPushed(app, event)
            folder = uigetdir;
            if folder ~= 0
                app.FolderPath = folder;
                uialert(app.UIFigure, ['Folder Selected: ' folder], 'Folder Selection');
            else
                uialert(app.UIFigure, 'No folder selected.', 'Warning');
            end
        end

        % Button pushed function: StartProcessingButton
        function StartProcessingButtonPushed(app, event)
            if isempty(app.FolderPath)
                uialert(app.UIFigure, 'Please select a folder first.', 'Error');
                return;
            end

            app.MethodChoice = app.MethodDropDown.Value;

            % Based on selection, call the right function
            switch app.MethodChoice
                case 'Manual Threshold Bounding'
                    app.OutputFromFirstFunction = manualThresholdBounding(app.FolderPath);
                case 'SAM AI Model'
                    app.OutputFromFirstFunction = samAIModel(app.FolderPath);
                otherwise
                    uialert(app.UIFigure, 'Invalid selection.', 'Error');
                    return;
            end

            % Prompt for extra data (adjustable input)
            promptData = promptUserData();

            % Call the next function with the output and additional data
            finalProcessing(app.OutputFromFirstFunction, promptData);
        end
    end

    methods (Access = public)

        % Construct app
        function app = FileProcessingApp
            createComponents(app)
        end

        % Code that executes before app deletion
        function delete(app)
            delete(app.UIFigure)
        end
    end

    methods (Access = private)

        % Create UI components
        function createComponents(app)
            app.UIFigure = uifigure('Position', [100 100 400 300]);
            app.SelectFolderButton = uibutton(app.UIFigure, 'push', ...
                'Text', 'Select Folder', ...
                'Position', [50 200 300 30], ...
                'ButtonPushedFcn', @(btn,event) SelectFolderButtonPushed(app, event));

            app.MethodDropDownLabel = uilabel(app.UIFigure, ...
                'Position', [50 150 100 22], ...
                'Text', 'Select Method:');

            app.MethodDropDown = uidropdown(app.UIFigure, ...
                'Position', [160 150 190 22], ...
                'Items', {'Manual Threshold Bounding', 'SAM AI Model'});

            app.StartProcessingButton = uibutton(app.UIFigure, 'push', ...
                'Text', 'Start Processing', ...
                'Position', [50 100 300 30], ...
                'ButtonPushedFcn', @(btn,event) StartProcessingButtonPushed(app, event));
        end
    end
end

%% === External helper functions ===

function output = manualThresholdBounding(folderPath)
    disp(['Running Manual Threshold Bounding on ' folderPath]);
    % --- Insert your actual manual threshold code here ---
    output = "ManualOutput"; % Dummy output, replace with your real output
end

function output = samAIModel(folderPath)
    disp(['Running SAM AI Model on ' folderPath]);
    % --- Insert your actual SAM model code here ---
    output = "SAMOutput"; % Dummy output, replace with your real output
end

function userInputData = promptUserData()
    % Modular input prompt
    prompt = {'Enter Experiment ID:', 'Enter User Notes:'};
    dlgtitle = 'Additional Information';
    dims = [1 35; 3 35]; % first input single-line, second input 3 lines
    definput = {'Exp001','No notes'};
    answer = inputdlg(prompt, dlgtitle, dims, definput);

    if isempty(answer)
        error('User canceled input');
    end

    userInputData.ExperimentID = answer{1};
    userInputData.Notes = answer{2};
end

function finalProcessing(initialOutput, userData)
    disp('Starting Final Processing...');
    disp(['Initial Output: ' initialOutput]);
    disp(['Experiment ID: ' userData.ExperimentID]);
    disp(['Notes: ' userData.Notes]);
    % --- Insert your actual final code here ---
end
