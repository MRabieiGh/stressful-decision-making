close all
clear
clc

unicode = struct();
unicode.hello           = fliplr([65203, 65276, 65249, 33]);
unicode.press_space     = fliplr([65169, 65198, 65165, 65263, 32, ...
                                  65165, 65193, 65165, 65251, 65258, 32, ...
                                  65243, 65248, 65268, 65194, 32, ...\
                                  101, 99, 97, 112, 115, 32, ...
                                  65197, 65165, 32, ...
                                  65235, 65208, 65166, 65197, 32, ...
                                  65193, 65259, 65268, 65194, 46]);
unicode.press_f_or_j    = fliplr([65169, 65198, 65165, 65263, 32, ...
                                  65165 , 65255, 65176, 65192, 65166, 65167, 32, ...
                                  64404, 65200, 65267, 65256, 65258, 8204, 65263, 32, ...
                                  65203, 65252, 65174, 32, ...
                                  64380, 64343, 32, ...
                                  65243, 65248, 65268, 65194, 32, ...
                                  39, 102, 39, 32, ...
                                  65261, 32, ...
                                  65169, 65198, 65165, 65263, 32, ...
                                  64404, 65200, 65267, 65256, 65258, 658204, 65263, 32, ...
                                  65203, 65252, 65174, 32, ...
                                  65197, 65165, 65203, 65174, 32, ...
                                  65243, 65248, 65268, 65194, 32, ...
                                  39, 106, 39, 32, ...
                                  65197, 65165, 32, ...
                                  65235, 65208, 65166, 65197, 32, ...
                                  65193, 65259, 65268, 65194, 46]);
unicode.your_choice     = fliplr([65255, 65224, 65198, 32, ...
                                  65207, 65252, 65166]);
unicode.person_1_choice = fliplr([65255, 65224, 65198, 32, ...
                                  65207, 65192, 65210, 32, ...
                                  65165, 65261, 65245]);
unicode.person_2_choice = fliplr([65255, 65224, 65198, 32, ...
                                  65207, 65192, 65210, 32, ...
                                  65193, 65261, 65249]);
save("text.mat", "unicode")