function addptb()
%ADDPTB Adds PsychToolBox to MATLAB's path
%   Checks out the contents of "/Misc/path2ptb.txt" and checks if it
%   contains the root folder of psychtoolbox. if not, it'll prompts user to
%   locate PTB root on his/her system. The located folder will be saved for
%   next attempts.
fd = fopen(fullfile("Misc", "path2ptb.txt"), "r+");
if fd == -1
    error("'path2ptb.txt' could not be opened!");
end

path2ptb = fscanf(fd, "%s");
if ~isfolder(path2ptb)
    path2ptb = uigetdir([], "Path to Psychtoolbox Root Folder");
    fprintf(fd, "%s", path2ptb);
end

addpath(path2ptb);
fclose(fd);

end

