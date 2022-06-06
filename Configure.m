% Initialize Psychtoolbox Parameters
Config.screen.ptr               = 1;
Config.screen.w                 = Screen('Resolution', Config.screen.ptr).width;
Config.screen.h                 = Screen('Resolution', Config.screen.ptr).height;
Config.screen.pixelSize         = Screen('Resolution', Config.screen.ptr).pixelSize;
Config.screen.hz                = Screen('Resolution', Config.screen.ptr).hz;
Config.screen.size              = ceil([0, 0, Config.screen.w, Config.screen.h]);
Config.screen.num_buffers       = 2;

Config.color.white              = WhiteIndex(Config.screen.ptr);
Config.color.black              = BlackIndex(Config.screen.ptr);
Config.color.gray               = Config.color.white / 2;

Config.time.rest_base           = 0.50;
Config.time.rest_max_jitter     = 1.00;
Config.time.presentation_solo   = 2.00;
Config.time.option_review       = 1.00;
Config.time.presentation_other  = 4.00;

Config.time.thinking_duration   = 6.00;
Config.time.reveal_base         = 0.80;
Config.time.reveal_max_jitter   = 2.00;

Config.graphics.option_r        = 150;
Config.graphics.option_pw       = 1;
Config.graphics.frame_pw        = 10;

Config.font.huge                = 64;
Config.font.big                 = 42;
Config.font.medium              = 25;
Config.font.small               = 16;

Config.control.n_trial_type     = 4;
Config.control.n_lottery_menu   = 4;

clear ans