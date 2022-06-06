%% Refresh Workspace
close all
clearvars
clear global
clc

addpath("Functions")
%% Per Subject Information
Subject.name = input("Please enter your name: ",'s');
Subject.code = assignCode();
Subject.date = datestr(today, 'yyyy/mm/dd');
%% Initialization
load(fullfile("Misc", "text.mat"))
load(fullfile("Misc", "menu.mat"))
Config.graphics.unicode = unicode;
clear unicode

% Initialize <Config> struct, containing task control variables
PsychDefaultSetup(0);
Screen('Preference', 'SkipSyncTests', 0);
Screen('Preference', 'TextRenderer', 1);
Screen('Preference', 'TextAntiAliasing', 1);
Screen('Preference', 'TextAlphaBlending', 0);
Screen('Preference', 'DefaultTextYPositionIsBaseline', 1);
Configure

% Initialize Psychtoolbox Video
[window, windowRect] = PsychImaging(...
    'OpenWindow', ...
    Config.screen.ptr, ...
    Config.color.black, ...
    Config.screen.size, ...
    Config.screen.pixelSize, ...
    Config.screen.num_buffers, ...
    [], ...
    [], ...
    kPsychNeed32BPCFloat...
    );

Screen('TextStyle', window, 0);
Screen('TextFont',  window, 'Sahel');

Config.graphics.coord = loccent(windowRect, Config.graphics.option_r);
[~, yCenter] = WindowCenter(window);
%% Initialize Result Variables
Subject.choices = [];
Subject.reaction_times = [];
%%
Config.condition.header = {'Condition Index', 'A1', 'A2', 'B1', 'B2', ...
    'Prob', 'Type (1:solo, 2:risky-risky, 3:risky-safe, 4:safe-safe', 'Safe Option'};
Config.condition.map = zeros(...
    Config.control.n_lottery_menu * 4 * length(Menu.probs), ...
    length(Config.condition.header));
Config.condition.selected_menus = randsample(8, 4);

counter = 1;
for m = 1:4
    for p = 1:length(Menu.probs)
        for t = 1:4
            safeOptionIndex                     = randi([1, 2]);
            Config.condition.map(counter, 1)    = counter;
            if safeOptionIndex == 1
                Config.condition.map(counter, 2:5)  = Menu.items(...
                    Config.condition.selected_menus(m), :);
            else
                Config.condition.map(counter, 2:5)  = [...
                    Menu.items(Config.condition.selected_menus(m), 3:4), ...
                    Menu.items(Config.condition.selected_menus(m), 1:2), ...
                    ];
            end
            Config.condition.map(counter, 6)    = Menu.probs(p);
            Config.condition.map(counter, 7)    = t;
            Config.condition.map(counter, 8)    = safeOptionIndex;
            counter = counter + 1;
        end
    end
end
clear m t p counter

Config.condition.mat = Config.condition.map(randperm(size(Config.condition.map, 1)), :);
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