% SPDX-License-Identifier: MIT
% Copyright (c) 2022 Trevor Vannoy, Ross K. Snider  All rights reserved.
%--------------------------------------------------------------------------
% Description:  Matlab Function to create/set model parameters for a
%               Simulink model. 
%--------------------------------------------------------------------------
% Authors:      Ross K. Snider, Trevor Vannoy
% Company:      Montana State University
% Create Date:  April 5, 2022
% Revision:     1.0
% License: MIT  (opensource.org/licenses/MIT)
%--------------------------------------------------------------------------
function modelParams = createModelParams()

%--------------------------------------------------------------------------
% Audio signal path in model
%--------------------------------------------------------------------------
modelParams.audio.wordLength      = 24;     % word size of audio signal
modelParams.audio.fractionLength  = 23;     % fraction size of audio signal
modelParams.audio.signed          = true;   % audio is a signed signal type
modelParams.audio.dataType = numerictype(modelParams.audio.signed, ...
                                         modelParams.audio.wordLength, ... 
                                         modelParams.audio.fractionLength);
modelParams.audio.sampleFrequency = 48000; % sample rate (Hz)
modelParams.audio.samplePeriod    = 1/modelParams.audio.sampleFrequency;

%--------------------------------------------------------------------------
% Control Parameters that will be set in registers (Data Types)
% Note: the actual values are set in createSimParams.m
%--------------------------------------------------------------------------
modelParams.enable.wordLength     = 1;
modelParams.enable.fractionLength = 0;
modelParams.enable.signed         = false; 
modelParams.enable.dataType = numerictype(modelParams.enable.signed, ...
                                          modelParams.enable.wordLength, ... 
                                          modelParams.enable.fractionLength);

modelParams.volume.wordLength     = 16;
modelParams.volume.fractionLength = 16;
modelParams.volume.signed         = false; 
modelParams.volume.dataType = numerictype(modelParams.volume.signed, ...
                                          modelParams.volume.wordLength, ... 
                                          modelParams.volume.fractionLength);
modelParams.wetDryMix.wordLength     = 16;
modelParams.wetDryMix.fractionLength = 16;
modelParams.wetDryMix.signed         = false; 
modelParams.wetDryMix.dataType = numerictype(modelParams.wetDryMix.signed, ...
                                      modelParams.wetDryMix.wordLength, ... 
                                      modelParams.wetDryMix.fractionLength);

modelParams.damp.wordLength     = 16;
modelParams.damp.fractionLength = 16;
modelParams.damp.signed         = false; 
modelParams.damp.dataType = numerictype(modelParams.damp.signed, ...
                                          modelParams.damp.wordLength, ... 
                                          modelParams.damp.fractionLength);
modelParams.minf.wordLength     = 16;
modelParams.minf.fractionLength = 0;
modelParams.minf.signed         = false; 
modelParams.minf.dataType = numerictype(modelParams.minf.signed, ...
                                          modelParams.minf.wordLength, ... 
                                          modelParams.minf.fractionLength);

modelParams.maxf.wordLength     = 16;
modelParams.maxf.fractionLength = 0;
modelParams.maxf.signed         = false; 
modelParams.maxf.dataType = numerictype(modelParams.maxf.signed, ...
                                          modelParams.maxf.wordLength, ... 
                                          modelParams.maxf.fractionLength);

modelParams.delta.wordLength     = 16;
modelParams.delta.fractionLength = 16;
modelParams.delta.signed         = false; 
modelParams.delta.dataType = numerictype(modelParams.delta.signed, ...
                                          modelParams.delta.wordLength, ... 
                                          modelParams.delta.fractionLength);

%--------------------------------------------------------------------------
% Size of dual port memory used for circular buffer
% MemorySize = 2^AddressSize
%--------------------------------------------------------------------------
modelParams.dpramAddressSize = 16;