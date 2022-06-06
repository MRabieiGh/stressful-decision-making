function is_correct = opreview(win, config, trial, key, so)
%OPREVIEW Option Review (Selected Choice Review)
%   After decision making's offset, the window is refreshed and subject's
%   decision is displayed on the monitor, along with other options.
global state

if strcmp(state, 'before-admin')
    [A1, A2, B1, B2, prob, trialType] = ldtrialinfo(config.condition.mat1, trial);
elseif strcmp(state, 'after-admin')
    [A1, A2, B1, B2, prob, trialType] = ldtrialinfo(config.condition.mat2, trial);
end

coord = config.graphics.coord;
penWidth = config.graphics.option_pw;
r = config.graphics.option_r;

if strcmp(trname(trialType), "info: rr")
    upper_options = [B1, B2, B1, B2];
elseif strcmp(trname(trialType), "info: ss")
    upper_options = [A1, A2, A1, A2];
elseif strcmp(trname(trialType), "info: rs")
    if(so == 1)
        upper_options = [A1, A2, B1, B2];
    elseif (so == 2)
        upper_options = [B1, B2, A1, A2];
    end
end

if strcmp(key, 'f')
    selection = 1;
elseif strcmp(key, 'j')
    selection = 2;
else
    selection = 0;
end

Screen('DrawLine', win, 255, coord.div.start(1), coord.div.start(2), ...
    coord.div.finish(1), coord.div.finish(2), penWidth);
if ~strcmp(trname(trialType), "solo")
    drawoption(win, coord.option_c(1,:), r, 'PenWidth', penWidth, ...
        'OptionTitle', config.graphics.unicode.person_1_choice)
    drawoption(win, coord.option_c(2,:), r, 'PenWidth', penWidth, ...
        'OptionTitle', config.graphics.unicode.person_2_choice)
else
    drawoption(win, coord.option_c(1,:), r, 'PenWidth', penWidth, ...
        'OptionTitle', 8211, 'FrameColor', 255)
    drawoption(win, coord.option_c(2,:), r, 'PenWidth', penWidth, ...
        'OptionTitle', 8211, 'FrameColor', 255)
end

drawoption(win, coord.option_c(4,:), r, 'PenWidth', penWidth, ...
        'Probability', prob', 'Values', [A1, A2])
drawoption(win, coord.option_c(5,:), r, 'PenWidth', penWidth, ...
        'Probability', prob', 'Values', [B1, B2])
 
if selection == 1
    drawoption(win, coord.option_c(3,:), r, ...
        'PenWidth', penWidth, ...
        'OptionTitle', config.graphics.unicode.your_choice, ...
        'Probability', prob', ...
        'Values', [A1, A2])
elseif selection == 2
    drawoption(win, coord.option_c(3,:), r, ...
        'PenWidth', penWidth, ...
        'OptionTitle', config.graphics.unicode.your_choice, ...
        'Probability', prob', ...
        'Values', [B1, B2])
else
    drawoption(win, coord.option_c(3,:), r, ...
        'PenWidth', penWidth, ...
        'OptionTitle', config.graphics.unicode.your_choice, ...
        'NullSymbol', 63)
end

Screen('Flip', win);
WaitSecs(config.time.option_review);

% Attention Test
if ~strcmp(trname(trialType), "solo") && (randi(4) == 1)
    masked_option = randi(2);
    disp(masked_option)
    Screen('DrawLine', win, 255, coord.div.start(1), coord.div.start(2), ...
        coord.div.finish(1), coord.div.finish(2), penWidth);
    Screen('FrameRect', win, [147,112,219], config.screen.size, 30)
    if masked_option == 1
    drawoption(win, coord.option_c(1,:), r, 'PenWidth', penWidth, ...
        'OptionTitle', config.graphics.unicode.person_1_choice, ...
        'NullSymbol', 63)
    drawoption(win, coord.option_c(2,:), r, 'PenWidth', penWidth, ...
        'OptionTitle', config.graphics.unicode.person_2_choice, ...
        'Probability', prob', ...
        'Values', upper_options(3:4))
    elseif masked_option == 2
        drawoption(win, coord.option_c(1,:), r, 'PenWidth', penWidth, ...
        'OptionTitle', config.graphics.unicode.person_1_choice, ...
        'Probability', prob', ...
        'Values', upper_options(1:2))
    drawoption(win, coord.option_c(2,:), r, 'PenWidth', penWidth, ...
        'OptionTitle', config.graphics.unicode.person_2_choice, ...
        'NullSymbol', 63)
    end
    if selection == 1
        drawoption(win, coord.option_c(3,:), r, ...
            'PenWidth', penWidth, ...
            'OptionTitle', config.graphics.unicode.your_choice, ...
            'Probability', prob', ...
            'Values', [A1, A2])
    elseif selection == 2
        drawoption(win, coord.option_c(3,:), r, ...
            'PenWidth', penWidth, ...
            'OptionTitle', config.graphics.unicode.your_choice, ...
            'Probability', prob', ...
            'Values', [B1, B2])
    else
        drawoption(win, coord.option_c(3,:), r, ...
            'PenWidth', penWidth, ...
            'OptionTitle', config.graphics.unicode.your_choice, ...
            'NullSymbol', 63)
    end
    drawoption(win, coord.option_c(4,:), r, 'PenWidth', penWidth, ...
        'Probability', prob', 'Values', [A1, A2])
    drawoption(win, coord.option_c(5,:), r, 'PenWidth', penWidth, ...
        'Probability', prob', 'Values', [B1, B2])
    
    Screen('Flip', win);
    
    key = pollev({'f', 'j'}, false);
    if strcmp(key, 'f')
        ans_vals = [A1, A2];
    elseif strcmp(key, 'j')
        ans_vals = [B1, B2];
    end
    if masked_option == 1
        cor_vals = upper_options(1:2);
    elseif masked_option == 2
        cor_vals = upper_options(3:4);
    end
    if all(ans_vals == cor_vals)
        is_correct = true;
    else
        is_correct = false;
    end
    
else
    is_correct = NaN;
end


end

