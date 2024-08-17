% Define FIS
fis = mamfis('Name', 'BasicFLC');

% Add Inputs and Output with modified ranges
fis = addInput(fis, [-15 15], 'Name', 'Error');
fis = addInput(fis, [-1 1], 'Name', 'ChangeInError'); % TO DO: range to be decided
fis = addOutput(fis, [-1 1], 'Name', 'ControlSignal');

% Define Membership Functions for Inputs with three MFs each
fis = addMF(fis, 'Error', 'trimf', [-15 -15 0], 'Name', 'Negative');
fis = addMF(fis, 'Error', 'trimf', [-15 0 15], 'Name', 'Zero');
fis = addMF(fis, 'Error', 'trimf', [0 15 15], 'Name', 'Positive');

fis = addMF(fis, 'ChangeInError', 'trimf', [-1 -1 0], 'Name', 'Minus');
fis = addMF(fis, 'ChangeInError', 'trimf', [-1 0 1], 'Name', 'Shuniya');
fis = addMF(fis, 'ChangeInError', 'trimf', [0 1 1], 'Name', 'Plus');

% Define Membership Functions for Output (Control Signal) with three MFs
fis = addMF(fis, 'ControlSignal', 'trimf', [-1 -1 0], 'Name', 'Negative');
fis = addMF(fis, 'ControlSignal', 'trimf', [-1 0 1], 'Name', 'Zero');
fis = addMF(fis, 'ControlSignal', 'trimf', [0 1 1], 'Name', 'Positive');

% Define simplified Rules
rules = [...
    "If Error is Negative and ChangeInError is Minus then ControlSignal is Negative", ...
    "If Error is Negative and ChangeInError is Shuniya then ControlSignal is Negative", ...
    "If Error is Negative and ChangeInError is Plus then ControlSignal is Negative", ...
    ...
    "If Error is Zero and ChangeInError is Minus then ControlSignal is Negative", ...
    "If Error is Zero and ChangeInError is Shuniya then ControlSignal is Zero", ...
    "If Error is Zero and ChangeInError is Plus then ControlSignal is Positive", ...
    ...
    "If Error is Positive and ChangeInError is Minus then ControlSignal is Positive", ...
    "If Error is Positive and ChangeInError is Shuniya then ControlSignal is Positive", ...
    "If Error is Positive and ChangeInError is Plus then ControlSignal is Positive"
];

fis = addRule(fis, rules);

% Evaluate FIS with example values
error = 5; % Example error within the range
change_in_error = 0; % Example change in error within the range

control_signal = evalfis(fis, [error change_in_error]);

disp(control_signal*15);
subplot(3, 1, 1)
plotmf(fis, 'input', 1, 1000);
subplot(3, 1, 2)
plotmf(fis, 'input', 2, 1000);
subplot(3, 1, 3)
plotmf(fis, 'output', 1, 1000);
