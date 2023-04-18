% SPDX-License-Identifier: MIT
% Copyright (c) 2022 Trevor Vannoy, Ross K. Snider  All rights reserved.
%--------------------------------------------------------------------------
% Description:  Matlab Function to create/set Simulation parameters for a
%               Simulink model simulation
%--------------------------------------------------------------------------
% Authors:      Ross K. Snider, Trevor Vannoy
% Company:      Montana State University
% Create Date:  April 5, 2022
% Revision:     1.0
% License: MIT  (opensource.org/licenses/MIT)
%--------------------------------------------------------------------------
function simParams = createSimParams(modelParams)

%--------------------------------------------------------------------------
% Audio file for simulation
%--------------------------------------------------------------------------
filename = 'CleanSampleChords.wav';
desiredFs = modelParams.audio.sampleFrequency;  % desired sample rate
desiredCh = 'left';  % desired channel
desiredNt = modelParams.audio.dataType;  % desired data type (Numeric type)
simParams.audioIn = getAudio(filename, desiredFs, desiredCh, desiredNt);
%--------------------------------------------------------------------------
% Simulation Parameters
%--------------------------------------------------------------------------
simParams.verifySimulation = false;  
simParams.playOutput       = true;
simParams.stopTime         = 20; % seconds

%--------------------------------------------------------------------------
% Model Parameters for simulation
%--------------------------------------------------------------------------
enable = 1;  % set value and data type from model parameters
simParams.enable = fi(enable,modelParams.enable.dataType);

volume = 1;  % set value and data type from model parameters
simParams.volume = fi(volume,modelParams.volume.dataType);

damp = 0.03;  % set value and data type from model parameters
simParams.damp = fi(damp,modelParams.damp.dataType);

minf = 100;  % set value and data type from model parameters
simParams.minf = fi(minf,modelParams.minf.dataType);

maxf = 3000;  % set value and data type from model parameters
simParams.maxf = fi(maxf,modelParams.maxf.dataType);

delta = 0.05;  % set value and data type from model parameters
simParams.delta = fi(delta,modelParams.delta.dataType);

wetDryMix = 0.5; % set value and data type from model parameters
simParams.wetDryMix= fi(wetDryMix,modelParams.wetDryMix.dataType);



