% Get the current working directory (where the .m file is running)
current_folder = pwd;

% Prompt user to select a folder containing images
source_folder = uigetdir('', 'Select Folder Containing Images');
if source_folder == 0
    disp('No folder selected.');
    return;
end

% Get list of image files in the selected folder
image_extensions = {'*.png', '*.jpg', '*.jpeg', '*.tif', '*.bmp'};
image_files = [];
for i = 1:length(image_extensions)
    image_files = [image_files; dir(fullfile(source_folder, image_extensions{i}))];
end

% Check if there are any images in the folder
if isempty(image_files)
    disp('No images found in the selected folder.');
    return;
end

% Create a new folder in the current working directory for processed images
[~, folder_name] = fileparts(source_folder);
output_folder = fullfile(current_folder, [folder_name '_green']);
if ~exist(output_folder, 'dir')
    mkdir(output_folder);
end

% Process each image
for i = 1:length(image_files)
    img_path = fullfile(source_folder, image_files(i).name);
    img = imread(img_path);

    % Display the image for manual selection
    fig = figure;
    imshow(img);
    title('Draw a bounding box around the checkerboard, then double-click inside to confirm.');

    % Allow the user to manually select the bounding box
    h = imrect;
    position = wait(h); % Wait for user input

    % Get bounding box coordinates
    x_min = round(position(1));
    y_min = round(position(2));
    x_max = round(x_min + position(3));
    y_max = round(y_min + position(4));

    % Close the selection figure
    close(fig);

    % Create a green mask
    green_mask = img; % Copy the original image
    green_mask(:,:,1) = 0; % Remove red channel
    green_mask(:,:,2) = 255; % Max out green channel
    green_mask(:,:,3) = 0; % Remove blue channel

    % Retain the manually selected area in the original image
    green_mask(y_min:y_max, x_min:x_max, :) = img(y_min:y_max, x_min:x_max, :);

    % Generate output filename and save in the new folder
    output_filename = fullfile(output_folder, image_files(i).name);
    imwrite(green_mask, output_filename);

    fprintf('Processed and saved: %s\n', output_filename);
end

% Display completion message
msgbox(sprintf('Processing complete! Images saved in:\n%s', output_folder), 'Success');
