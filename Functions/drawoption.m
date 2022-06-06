function drawoption(win, center, r, varargin)
%DRAWOPTION Draws a pie-chart-like option on the PTB windows <win>
%   The option is originally a circle with center on <center> argument and
%   radius of r. If it is used with just these arguments, it will have a
%   dash symbol at the center of circle (or any other symbol specified by
%   <NullSymbol> argument) or you can specify a pair of <Probability> and
%   <Values> varargin which will indicate the pie-chart's ration and its
%   assigned values. Two optional graphical varargins may be passed to
%   function, <PenWidth> and <FrameColor>, which indicate the line
%   thickness and border color of options' circle. The optional varargins 
%   <OptionTitle> defines the title placed above the option.

values = []; prob = []; optTitle = []; penWidth = 7;
nullsym = 8211; frameColor = [147,112,219];

if mod(length(varargin), 2) == 1
    error("drawoption: Mismatched Input Arguments")
end
for i = 1:2:length(varargin)
    if strcmp(varargin{i}, "Probability")
        prob = varargin{i+1};
    elseif strcmp(varargin{i}, "Values")
        values = varargin{i+1};
    elseif strcmp(varargin{i}, "PenWidth")
        penWidth = varargin{i+1};
    elseif strcmp(varargin{i}, "OptionTitle")
        optTitle = varargin{i+1};
    elseif strcmp(varargin{i}, "NullSymbol")
        nullsym = varargin{i+1};
    elseif strcmp(varargin{i}, "FrameColor")
        frameColor = varargin{i+1};
    end
end
if ~isempty(values) && length(values) ~= 2
    error("drawoption: Values argument must be of length 2")
end
if xor(isempty(prob), isempty(values))
    error("You must specify both Probability and Values");
end

Screen('FillArc', win, 128, [center-r, center+r], 0, 360);
Screen('FrameArc', win, 255, [center-r, center+r], 0, 360, penWidth);

if ~isempty(prob)
    theta = prob / 100 * 2 *pi;
    [v1, v2] = pol2cart(theta/2, r*0.65);
    wprint(win, num2str(values(1)), 25, center(1)+v1, center(2)-v2, 255);
    wprint(win, num2str(values(2)), 25, center(1)-v1, center(2)+v2, 255);
    [v1, v2] = pol2cart(theta, r);
    Screen('DrawLine', win, 255, center(1), center(2), center(1)+r, center(2), penWidth);
    Screen('DrawLine', win, 255, center(1), center(2), center(1)+v1, center(2)-v2, penWidth);
else
    wprint(win, nullsym, 64, center(1)-10, center(2)+15, 255);
end

if(length(optTitle) == 1)
    wprint(win, optTitle, 64, center(1)-20, center(2)-r-25, 255);
else
    wprint(win, optTitle, 16, center(1)-4*length(optTitle), center(2)-r-30, 255);
end

if ~isempty(frameColor)
    penWidth = penWidth * 10;
    rPrime = r + penWidth;
    Screen('FrameArc', win, frameColor, ...
        [center-[rPrime,rPrime], center+[rPrime,rPrime]], ...
        0, 360, penWidth);
end

end

