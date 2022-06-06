function coord = loccent(winRect, r)
%LOCCENT Locates centers of task's positions
%   Inputs windowsRect, outputs center of circles and divider line's
%   coordinates
y1 = 1 * (winRect(4) - winRect(2)) / 4;
y2 = 2 * (winRect(4) - winRect(2)) / 4;
y3 = 3 * (winRect(4) - winRect(2)) / 4;

x2 = (winRect(3) - winRect(1)) / 2;
w = (winRect(3) - winRect(1) - 6 * r) / 6;
w = 2 * floor(w / 2);

coord.option_c = [
    x2-2*r-w,   y1;
    x2,         y1;
    x2+2*r+w,   y1;
    x2-r-w/2,   y3;
    x2+w/2+r,   y3
    ];

coord.div.start     = [winRect(1), y2];
coord.div.finish    = [winRect(3), y2];
end

