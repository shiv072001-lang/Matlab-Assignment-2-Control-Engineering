%% GENG3402/4402 Milestone 2 - Dominant Pole Approximation
%% Basically this code is comparing higher order system with ones with reduced order system.
%% Dominant poles method is used for making the system more simple. 


clear;
clc;
close all;

% these two poles are dominant poles
dominantPoles = [-1 + 2i, -1 - 2i];

% these poles are faster poles are located in more left side
fastPoles = [-12, -15, -18, -22];

% Combining dominant and fast poles in one list
allPoles = [dominantPoles, fastPoles];

% Creating the original system

% Herein the Gain is calculated for making the steady state value equal to 1
Khigher = real(prod(-allPoles));

%Original system that we had taken has six poles and no zeroes.
Ghigher = zpk([], allPoles, Khigher);

% Creating the reduced system
%% Herein, the reduced system only keeps the dominant poles. Other four poles have been discarded.
Klower = real(prod(-dominantPoles));

%Reduced system is second order and it does not have any zeroes.
Glower = zpk([], dominantPoles, Klower);

%% Displaying both the systems

% Converting the original system into transfer function form.
Ghigher_tf = tf(Ghigher);

% Converting the reduced system into the transfer function form.
Glower_tf = tf(Glower);

disp('Original 6th order system is equal to:');
Ghigher_tf

disp('Reduced 2nd order system is equal to:');
Glower_tf


%% Pole and damping calculation

% Calculating the poles of the original system
pHigher = pole(Ghigher);

% Calculating the poles of reduced system
pLower = pole(Glower);

% Displaying all poles in the command window
disp('Poles of the original system are as follows:');
disp(pHigher);

disp('Poles of reduced system are as follows:');
disp(pLower);

% damp command is giving the natural frequency and damping ratio
[wnHigher, zetaHigher, pHigherDamp] = damp(Ghigher);
[wnLower, zetaLower, pLowerDamp] = damp(Glower);

% Creating tabulation for the original system pole details
higherPoleTable = table(pHigherDamp, wnHigher, zetaHigher, ...
    'VariableNames', {'Pole', 'NaturalFrequency', ...
    'DampingRatio'});

% Creating tabulation for the reduced system pole details
lowerPoleTable = table(pLowerDamp, wnLower, zetaLower, ...
    'VariableNames', {'Pole', 'NaturalFrequency', ...
    'DampingRatio'});
    
disp('Original system pole details are given as follows:');
disp(higherPoleTable);

disp('Reduced system Pole details are as follows:');
disp(lowerPoleTable);

%% Step response calculation are to be discussed in the below section

% Time is kept same for both the system
t = 0:0.01:10;

% Calculating the step response of original system
[yHigher, tHigher] = step(Ghigher, t);

% Calculating the step response of reduced system
[yLower, tLower] = step(Glower, t);

% Squeeze command is making the output into simple column
yHigher = squeeze(yHigher); 
yLower = squeeze(yLower);

% Stepinfo command is used in calculating the important response values
infoHigher = stepinfo(yHigher, tHigher, 1);
infoLower = stepinfo(yLower, tLower, 1);

% Stepinfo command is used in calculating important response values
infoHigher = stepinfo(yHigher, tHigher, 1);
infoLower = stepinfo(yLower, tLower, 1);

% delay time is taken when the output first reaches to 50 percent
indexHigher = find(yHigher >= 0.5, 1, 'first');
indexLower = find(yLower >= 0.5, 1, 'first');

% getting the time value from the index
delayHigher = tHigher(indexHigher);
delayLower = tLower(indexLower);

%% Creating comparison Table 

% Now incorporating names for both system
SystemName = {'Original 6th order'; ...
    'Reduced 2nd order'};

% Taking the real time values 
RiseTime = [infoHigher.RiseTime; ...
    infoLower.RiseTime];

% Taking the settling time values
SettlingTime = [infoHigher.SettlingTime; ...
    infoLower.SettlingTime];

 % Taking in the overshoot values
 Overshoot = [infoHigher.Overshoot; ...
    infoLower.Overshoot];

% Combining all the values into one table
resultTable = table(SystemName, RiseTime, DelayTime, ...
    SettlingTime, Overshoot);

disp('Time response comparison is as follows:');
disp(resultTable);

%% Percentage difference calculation 

% Finding the rise time difference between both system riseError = 100 * abs(infoLower.RiseTime ...
    - infoHigher.RiseTime) / infoHigher.RiseTime;

% Finding the delay time difference delayError = 100 * abs(delayLower ...
    - delayHigher) / delayHigher;

% Finding the settling time difference settlingError = 100 * abs(infoLower.SettlingTime ...
    - infoHigher.SettlingTime) ...
    / infoHigher.SettlingTime;

% Finding overshoot difference overshootError = 100 * abs(infoLower.Overshoot ...
    - infoHigher.Overshoot) ...
    / infoHigher.Overshoot;

% displaying all the differences in the command window 

fprintf('\nPercentage difference values:\n');

fprintf('Rise the time difference = %.2f %%\n', ... riseError);

fprintf('Delay time difference = %.2f %%\n', ...  delayError);

fprintf('Settling time difference = %.2f %%\n', ... settlingError);

fprintf('Overshoot difference = %.2f %%\n', ... overshootError);





    
