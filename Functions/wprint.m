function wprint(win, text, textSize, x, y, color)
%WPRINT writes out the formatted unicode <text> on windows correspondind to
%<win>
%   <x> and <y> are the horizontal and vertical placement of text, <color>
%   is the color of text.
Screen('TextSize',  win, textSize);
DrawFormattedText(win, text, x, y, color);

end

