%% Refresh Workspace
close all
clearvars
clear global
clc

addpath("Functions")
rng('default')

global state
state = "after-admin";

%% Per Subject Information
load currdir
load(fullfile(out_dir, 'config.mat'))

%% Initialize Result Variables
Subject.choices = [];
Subject.reaction_times = [];
Subject.alertness = [];

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
for i = 1:size(Config.condition.mat2, 1)
    % Inter Trial Interval
    Screen('DrawLine', window, 255, ...
        Config.graphics.coord.div.start(1), ...
        Config.graphics.coord.div.start(2), ...
        Config.graphics.coord.div.finish(1), ...
        Config.graphics.coord.div.finish(2), ...
        Config.graphics.option_pw);
    Screen('Flip', window);
    WaitSecs(Config.time.rest_base + rand()*Config.time.rest_max_jitter);
    
    % Onset
    so = putopt(window, Config, i);
    
    % Assess subject's choice
    timer = tic;
    key = pollev({'f', 'j'}, false);
    reaction_time = toc(timer);
    Subject.choices = [Subject.choices key];
    Subject.reaction_times = [Subject.reaction_times reaction_time];
    
    % View subject's chosen option
    Subject.alertness = [Subject.alertness, opreview(window, Config, i, key, so)];
    
    KbEventFlush();
end

%% Close and Save
Screen('CloseAll')

tbl = array2table([string(Subject.choices), ...
    num2str(Subject.reaction_times), num2str(Subject.alertness)]);
tbl.Properties.VariableNames = {'choice', 'reaction_time', 'is_alert'};
writetable(tbl, fullfile(out_dir, 'after.csv'))

save(fullfile(out_dir, 'after.mat'), 'Subject')