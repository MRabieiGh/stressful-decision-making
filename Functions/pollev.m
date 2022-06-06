function keyCode = pollev(keyset, is_introductory, varargin)
%POLLEV polls on keyboard until one of a specific set of keys is pressed
%   <keyset> is a vector of characters. Program halts at this command until
%   one of these keys is pressed. <is_introductory> is a controlling
%   argument. If is_introductory = false, function doesn't wait after 
%   breaking from while loop. This mode is designed for receiving keyboard 
%   commands during trials. is_introductory = true on the other hand, is 
%   used for introductory slides and waits for an additional 500 ms to 
%   assure flushing of keyboard event buffer. The optional varargin
%   <TimeoutDuration> may be passed to this function to set a timer at the
%   end of which the loop breaks anyway.

if mod(length(varargin), 2) == 1
    error("drawoption: Mismatched Input Arguments")
end
timeout_duration = 0;
for i = 1:2:length(varargin)
    if strcmp(varargin{i}, "TimeoutDuration")
        timeout_duration = varargin{i+1};
    end
end

if(~islogical(is_introductory))
    error("pollev: is_introductory is a logical variable")
end

if timeout_duration ~= 0
    timeout = tic;
end

is_pressed = false;
while ~is_pressed
    if timeout_duration ~= 0
        if (toc(timeout) >= timeout_duration)
            keyCode = 'none';
            break
        end
    end
    
    [keyIsDown, ~, key] = KbCheck();
    if (keyIsDown)
        keyCode = KbName(key);
        for i = 1:length(keyset)
            if strcmp(keyCode, keyset{i})
                is_pressed = true;
                break
            end
        end
        if strcmp(keyCode, 'q')
            Screen('CloseAll')
            break
        end
    end
end

if(is_introductory)
    WaitSecs(0.5);
    KbEventFlush();
end

end
