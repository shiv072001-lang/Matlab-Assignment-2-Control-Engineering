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

