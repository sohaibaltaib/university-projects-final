open_system('wahWahEffect');
open_system('gm_wahWahEffect');
cs.HiliteType = 'user1';
cs.ForegroundColor = 'black';
cs.BackgroundColor = 'cyan';
set_param(0, 'HiliteAncestorsData', cs);
hilite_system('gm_wahWahEffect/wahWahEffectSystem/stateVariableFilter/F1/Sine HDL Optimized/Look-Up Table', 'user1');
annotate_port('gm_wahWahEffect/wahWahEffectSystem/stateVariableFilter/F1/Sine HDL Optimized/Look-Up Table', 0, 1, 'Lookup Table mapped to RAM');
hilite_system('wahWahEffect/wahWahEffectSystem/stateVariableFilter/F1/Sine HDL Optimized/sine hdl/Look-Up Table', 'user1');
annotate_port('wahWahEffect/wahWahEffectSystem/stateVariableFilter/F1/Sine HDL Optimized/sine hdl/Look-Up Table', 0, 1, 'Lookup Table mapped to RAM');
