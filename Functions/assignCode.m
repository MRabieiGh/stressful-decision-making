function code = assignCode()
%ADDPTB Assigns a new code to each session
%   Loads the contents of "/Misc/nSessions.txt" and increment it by 1.
%   Returns the incremented number as new session's code number and
%   overwrites it in the mentioned file.
fd = fopen(fullfile("Misc", "nSessions.txt"), "r+");
if fd == -1
    error("'nSessions.txt' could not be opened!");
end
code = fscanf(fd, "%d") + 1;
fclose(fd);

fd = fopen(fullfile("Misc", "nSessions.txt"), "w");
if fd == -1
    error("'nSessions.txt' could not be opened!");
end
fprintf(fd, "%d", code);
fclose(fd);

end

