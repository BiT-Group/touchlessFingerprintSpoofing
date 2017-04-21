%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BEFORE RUNNING THIS SCRIPT, MAKE SURE YOU HAVE SETUP THE ENVIRONMENT PROPERLY.%
% RUNNING 'setupInputImages.m' and 'generateTextureDescriptors.m' SHOULD BE     %
% ENOUGH.                                                                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all;
% clear all;
clc;

%% Scenario 1: real fingers vs fake fingers (all classes togheter)
trainNN1();

%% Scenario 2: real fingers vs each fake finger's class (one against one)
trainNN2();

%% Scenario 3: all classes against all classes
trainNN3();