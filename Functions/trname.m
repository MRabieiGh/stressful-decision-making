function trial_name = trname(trial_code)
%TRNAME Returns name of trial type
if trial_code == 1
    trial_name = "solo";
elseif(trial_code == 2)
    trial_name = "info: rr";    
elseif(trial_code == 3)
    trial_name = "info: rs";
elseif(trial_code == 4)
    trial_name = "info: ss";
else
    error("Trial code must be an integer between 1-4")
end

