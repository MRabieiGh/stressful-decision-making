%% Refresh Workspace
close all
clearvars
clear global
clc

addpath("Functions")
%% Per Subject Information
load currdir
load(fullfile(out_dir, 'config.mat'))

%% Begin the Task
% Hello, <space> to continue
wprint(window, Config.graphics.unicode.hello, Config.font.big, ...
    'center', 'center', Config.color.white);
wprint(window, Config.graphics.unicode.press_space, Config.font.medium, ...
    'center', 1.4*yCenter, Config.color.white);
Screen('Flip', window);
pollev({'space'}, true)

wprint(window, Config.graphics.unicode.press_f_or_j, Config.font.medium, ...
    'center', 'center', Config.color.white);
wprint(window, Config.graphics.unicode.press_space, Config.font.medium, ...
    'center', 1.4*yCenter, Config.color.white);
Screen('Flip', window);
pollev({'space'}, true)

% Trial window
for i = 4%size(Config.condition.mat, 1)
    % Onset
    so = putopt(window, Config, i);
    % Assess subject's choice
    timer = tic;
    key = pollev({'f', 'j'}, false);
    reaction_time = toc(timer);
    Subject.choices = [Subject.choices key];
    Subject.reaction_times = [Subject.reaction_times reaction_time];
    % View subject's chosen option
    opreview(window, Config, i, key, so)
    WaitSecs(Config.time.option_review);
    KbEventFlush();
    % Blank screen followed by next trial
    Screen('Flip', window);
    WaitSecs(Config.time.rest_base + rand()*Config.time.rest_max_jitter);
end

%% Close and Save
Screen('CloseAll')
save(fullfile(pwd, "Sessions", ...
    strcat(datestr(today, 'yyyymmdd'), "-", num2str(Subject.code))), ...
    'Subject', 'Config')