function [A1, A2, B1, B2, prob, trialType] = ldtrialinfo(cmat, trial)
%LDTRIALINFO Load Trial Info
%   inputs the config (in order to get access to condition.mat) and the row
%   of condition matrix we are at (trial), then parses the matrix and
%   returns options' weights (A1, A2, B1, B2) and chart's probability and
%   trialtype (solo or info)
A1          = cmat(trial, 2);
A2          = cmat(trial, 3);
B1          = cmat(trial, 4);
B2          = cmat(trial, 5);
prob        = cmat(trial, 6);
trialType   = cmat(trial, 7);
end

