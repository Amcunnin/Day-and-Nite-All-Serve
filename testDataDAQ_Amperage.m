%% last modified 2/23/2020 by AMC
%% Spec Sheet Information
% Response time: 2 sec
% Freq: 50/60 Hz Nominal
%
%% Main Code
clear
clc

% Initialization of DAQ
devices = daq.getDevices
s = daq.createSession('ni');
a1 = addAnalogInputChannel(s, 'DAQ2', 'ai0', 'Voltage');
a2 = addAnalogInputChannel(s, 'DAQ2', 'ai1', 'Voltage');
a3 = addAnalogInputChannel(s, 'DAQ2', 'ai2', 'Voltage');

a1.TerminalConfig = 'Differential';
a2.TerminalConfig = 'Differential';
a3.TerminalConfig = 'Differential';

% Data stream loop
counter = 0;
pause_delay = 2;

while(1) % hit ctrl+c to to terminate
    data = s.inputSingleScan;
    fprintf('Iteration: %d\tCurrent Delay: %d seconds\n',counter,pause_delay)
    ai0 = data(1);
    ai1 = data(2);
    ai2 = data(3);
    
    ai0_Amps = voltageToAmps(ai0);
    ai1_Amps = voltageToAmps(ai1);
    ai2_Amps = voltageToAmps(ai2);
    
    % Displaying Data
    fprintf('\nPort\tRaw Data\tCalc. Amps\n')
    fprintf('ai0\t\t%.4f\t\t%.2f\n',ai0,ai0_Amps)
    fprintf('ai1\t\t%.4f\t\t%.2f\n',ai1,ai1_Amps)
    fprintf('ai2\t\t%.4f\t\t%.2f\n',ai2,ai2_Amps)
    
    pause(pause_delay);
    counter = counter+1;
    clc
end