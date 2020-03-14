-- hack hack hack - I've taken L Azzarello's stuff 
-- and made it do my layer thing 
-- I know it is horrible but not got a better solution just yet 
-- working on one 
--
-- based on FM 7 lib
-- Engine params and functions
--
-- @module FM7
-- @release v0.0.1
-- @author Lee Azzarello

local ControlSpec = require "controlspec"

local MT7 = {}

local specs = {}
local options = {}

specs.OPAMP_A= ControlSpec.new(0.01,10,"lin",0,0.05,"ms")
specs.OPAMP_D= ControlSpec.new(0,2,"lin",0,0.1,"ms")
specs.OPAMP_S= ControlSpec.new(0,1,"lin",0,1,"db")
specs.OPAMP_R= ControlSpec.new(0.01,10,"lin",0,1,"ms")
specs.HZ = ControlSpec.new(0,5, "lin",0,1,"")
specs.PHASE = ControlSpec.new(0,2*math.pi, "lin",0,0,"rad")
specs.AMP = ControlSpec.new(0,1, "lin",0,1,"db")
specs.VELS = ControlSpec.new(0,1, "lin",0,1,"")
specs.HZHZ = ControlSpec.new(0,2*math.pi,"lin",0,0,"rad")
specs.CARRIERA = ControlSpec.new(0,1, "lin",0,0.3,"db")
specs.CARRIERb = ControlSpec.new(0,1, "lin",0,0,"db")

MT7.specs = specs



function MT7.add_params()
-- l 1
  params:add{type = "control", id = "l1_hz1",name = "l1_Osc 1 F-Mult", controlspec = specs.HZ, action = engine.l1_hz1}
  params:add{type = "control", id = "l1_hz2",name = "l1_Osc 2 F-Mult", controlspec = specs.HZ, action = engine.l1_hz2}
  params:add{type = "control", id = "l1_hz3",name = "l1_Osc 3 F-Mult", controlspec = specs.HZ, action = engine.l1_hz3}
  params:add{type = "control", id = "l1_hz4",name = "l1_Osc 4 F-Mult", controlspec = specs.HZ, action = engine.l1_hz4}
  params:add{type = "control", id = "l1_hz5",name = "l1_Osc 5 F-Mult", controlspec = specs.HZ, action = engine.l1_hz5}
  params:add{type = "control", id = "l1_hz6",name = "l1_Osc 6 F-Mult", controlspec = specs.HZ, action = engine.l1_hz6}
  params:add_separator()
  params:add{type = "control", id = "l1_phase1",name = "l1_Osc 1 Phase", controlspec = specs.PHASE, action = engine.l1_phase1}
  params:add{type = "control", id = "l1_phase2",name = "l1_Osc 2 Phase", controlspec = specs.PHASE, action = engine.l1_phase2}
  params:add{type = "control", id = "l1_phase3",name = "l1_Osc 3 Phase", controlspec = specs.PHASE, action = engine.l1_phase3}
  params:add{type = "control", id = "l1_phase4",name = "l1_Osc 4 Phase", controlspec = specs.PHASE, action = engine.l1_phase4}
  params:add{type = "control", id = "l1_phase5",name = "l1_Osc 5 Phase", controlspec = specs.PHASE, action = engine.l1_phase5}
  params:add{type = "control", id = "l1_phase6",name = "l1_Osc 6 Phase", controlspec = specs.PHASE, action = engine.l1_phase6}
  params:add_separator()
  params:add{type = "control", id = "l1_amp1",name = "l1_Osc 1 Amplitude", controlspec = specs.AMP, action = engine.l1_amp1}
  params:add{type = "control", id = "l1_amp2",name = "l1_Osc 2 Amplitude", controlspec = specs.AMP, action = engine.l1_amp2}
  params:add{type = "control", id = "l1_amp3",name = "l1_Osc 3 Amplitude", controlspec = specs.AMP, action = engine.l1_amp3}
  params:add{type = "control", id = "l1_amp4",name = "l1_Osc 4 Amplitude", controlspec = specs.AMP, action = engine.l1_amp4}
  params:add{type = "control", id = "l1_amp5",name = "l1_Osc 5 Amplitude", controlspec = specs.AMP, action = engine.l1_amp5}
  params:add{type = "control", id = "l1_amp6",name = "l1_Osc 6 Amplitude", controlspec = specs.AMP, action = engine.l1_amp6}
  params:add_separator()
  params:add{type = "control", id = "l1_vels1",name = "l1_Osc 1 Vel Sens", controlspec = specs.VELS, action = engine.l1_vels1}
  params:add{type = "control", id = "l1_vels2",name = "l1_Osc 2 Vel Sens", controlspec = specs.VELS, action = engine.l1_vels2}
  params:add{type = "control", id = "l1_vels3",name = "l1_Osc 3 Vel Sens", controlspec = specs.VELS, action = engine.l1_vels3}
  params:add{type = "control", id = "l1_vels4",name = "l1_Osc 4 Vel Sens", controlspec = specs.VELS, action = engine.l1_vels4}
  params:add{type = "control", id = "l1_vels5",name = "l1_Osc 5 Vel Sens", controlspec = specs.VELS, action = engine.l1_vels5}
  params:add{type = "control", id = "l1_vels6",name = "l1_Osc 6 Vel Sens", controlspec = specs.VELS, action = engine.l1_vels6}
  params:add_separator()
  params:add{type = "control", id = "l1_hz1_to_hz1",name = "l1_Osc1 * Osc1", controlspec = specs.HZHZ, action = engine.l1_hz1_to_hz1}
  params:add{type = "control", id = "l1_hz1_to_hz2",name = "l1_Osc1 * Osc2", controlspec = specs.HZHZ, action = engine.l1_hz1_to_hz2}
  params:add{type = "control", id = "l1_hz1_to_hz3",name = "l1_Osc1 * Osc3", controlspec = specs.HZHZ, action = engine.l1_hz1_to_hz3}
  params:add{type = "control", id = "l1_hz1_to_hz4",name = "l1_Osc1 * Osc4", controlspec = specs.HZHZ, action = engine.l1_hz1_to_hz4}
  params:add{type = "control", id = "l1_hz1_to_hz5",name = "l1_Osc1 * Osc5", controlspec = specs.HZHZ, action = engine.l1_hz1_to_hz5}
  params:add{type = "control", id = "l1_hz1_to_hz6",name = "l1_Osc1 * Osc6", controlspec = specs.HZHZ, action = engine.l1_hz1_to_hz6}
  params:add{type = "control", id = "l1_hz2_to_hz1",name = "l1_Osc2 * Osc1", controlspec = specs.HZHZ, action = engine.l1_hz2_to_hz1}
  params:add{type = "control", id = "l1_hz2_to_hz2",name = "l1_Osc2 * Osc2", controlspec = specs.HZHZ, action = engine.l1_hz2_to_hz2}
  params:add{type = "control", id = "l1_hz2_to_hz3",name = "l1_Osc2 * Osc3", controlspec = specs.HZHZ, action = engine.l1_hz2_to_hz3}
  params:add{type = "control", id = "l1_hz2_to_hz4",name = "l1_Osc2 * Osc4", controlspec = specs.HZHZ, action = engine.l1_hz2_to_hz4}
  params:add{type = "control", id = "l1_hz2_to_hz5",name = "l1_Osc2 * Osc5", controlspec = specs.HZHZ, action = engine.l1_hz2_to_hz5}
  params:add{type = "control", id = "l1_hz2_to_hz6",name = "l1_Osc2 * Osc6", controlspec = specs.HZHZ, action = engine.l1_hz2_to_hz6}
  params:add{type = "control", id = "l1_hz3_to_hz1",name = "l1_Osc3 * Osc1", controlspec = specs.HZHZ, action = engine.l1_hz3_to_hz1}
  params:add{type = "control", id = "l1_hz3_to_hz2",name = "l1_Osc3 * Osc2", controlspec = specs.HZHZ, action = engine.l1_hz3_to_hz2}
  params:add{type = "control", id = "l1_hz3_to_hz3",name = "l1_Osc3 * Osc3", controlspec = specs.HZHZ, action = engine.l1_hz3_to_hz3}
  params:add{type = "control", id = "l1_hz3_to_hz4",name = "l1_Osc3 * Osc4", controlspec = specs.HZHZ, action = engine.l1_hz3_to_hz4}
  params:add{type = "control", id = "l1_hz3_to_hz5",name = "l1_Osc3 * Osc5", controlspec = specs.HZHZ, action = engine.l1_hz3_to_hz5}
  params:add{type = "control", id = "l1_hz3_to_hz6",name = "l1_Osc3 * Osc6", controlspec = specs.HZHZ, action = engine.l1_hz3_to_hz6}
  params:add{type = "control", id = "l1_hz4_to_hz1",name = "l1_Osc4 * Osc1", controlspec = specs.HZHZ, action = engine.l1_hz4_to_hz1}
  params:add{type = "control", id = "l1_hz4_to_hz2",name = "l1_Osc4 * Osc2", controlspec = specs.HZHZ, action = engine.l1_hz4_to_hz2}
  params:add{type = "control", id = "l1_hz4_to_hz3",name = "l1_Osc4 * Osc3", controlspec = specs.HZHZ, action = engine.l1_hz4_to_hz3}
  params:add{type = "control", id = "l1_hz4_to_hz4",name = "l1_Osc4 * Osc4", controlspec = specs.HZHZ, action = engine.l1_hz4_to_hz4}
  params:add{type = "control", id = "l1_hz4_to_hz5",name = "l1_Osc4 * Osc5", controlspec = specs.HZHZ, action = engine.l1_hz4_to_hz5}
  params:add{type = "control", id = "l1_hz4_to_hz6",name = "l1_Osc4 * Osc6", controlspec = specs.HZHZ, action = engine.l1_hz4_to_hz6}
  params:add{type = "control", id = "l1_hz5_to_hz1",name = "l1_Osc5 * Osc1", controlspec = specs.HZHZ, action = engine.l1_hz5_to_hz1}
  params:add{type = "control", id = "l1_hz5_to_hz2",name = "l1_Osc5 * Osc2", controlspec = specs.HZHZ, action = engine.l1_hz5_to_hz2}
  params:add{type = "control", id = "l1_hz5_to_hz3",name = "l1_Osc5 * Osc3", controlspec = specs.HZHZ, action = engine.l1_hz5_to_hz3}
  params:add{type = "control", id = "l1_hz5_to_hz4",name = "l1_Osc5 * Osc4", controlspec = specs.HZHZ, action = engine.l1_hz5_to_hz4}
  params:add{type = "control", id = "l1_hz5_to_hz5",name = "l1_Osc5 * Osc5", controlspec = specs.HZHZ, action = engine.l1_hz5_to_hz5}
  params:add{type = "control", id = "l1_hz5_to_hz6",name = "l1_Osc5 * Osc6", controlspec = specs.HZHZ, action = engine.l1_hz5_to_hz6}
  params:add{type = "control", id = "l1_hz6_to_hz1",name = "l1_Osc6 * Osc1", controlspec = specs.HZHZ, action = engine.l1_hz6_to_hz1}
  params:add{type = "control", id = "l1_hz6_to_hz2",name = "l1_Osc6 * Osc2", controlspec = specs.HZHZ, action = engine.l1_hz6_to_hz2}
  params:add{type = "control", id = "l1_hz6_to_hz3",name = "l1_Osc6 * Osc3", controlspec = specs.HZHZ, action = engine.l1_hz6_to_hz3}
  params:add{type = "control", id = "l1_hz6_to_hz4",name = "l1_Osc6 * Osc4", controlspec = specs.HZHZ, action = engine.l1_hz6_to_hz4}
  params:add{type = "control", id = "l1_hz6_to_hz5",name = "l1_Osc6 * Osc5", controlspec = specs.HZHZ, action = engine.l1_hz6_to_hz5}
  params:add{type = "control", id = "l1_hz6_to_hz6",name = "l1_Osc6 * Osc6", controlspec = specs.HZHZ, action = engine.l1_hz6_to_hz6}
  params:add_separator()
  params:add{type = "control", id = "l1_carrier1",name = "l1_Cr 1 Amplitude", controlspec = specs.CARRIERA, action = engine.l1_carrier1}
  params:add{type = "control", id = "l1_carrier2",name = "l1_Cr 2 Amplitude", controlspec = specs.CARRIERB, action = engine.l1_carrier2}
  params:add{type = "control", id = "l1_carrier3",name = "l1_Cr 3 Amplitude", controlspec = specs.CARRIERB, action = engine.l1_carrier3}
  params:add{type = "control", id = "l1_carrier4",name = "l1_Cr 4 Amplitude", controlspec = specs.CARRIERB, action = engine.l1_carrier4}
  params:add{type = "control", id = "l1_carrier5",name = "l1_Cr 5 Amplitude", controlspec = specs.CARRIERB, action = engine.l1_carrier5}
  params:add{type = "control", id = "l1_carrier6",name = "l1_Cr 6 Amplitude", controlspec = specs.CARRIERB, action = engine.l1_carrier6}
  params:add_separator()
  params:add{type = "control", id = "l1_opAmpA1",name = "l1_Osc1 Attack", controlspec = specs.OPAMP_A, action = engine.l1_opAmpA1}
  params:add{type = "control", id = "l1_opAmpD1",name = "l1_Osc1 Decay", controlspec = specs.OPAMP_D, action = engine.l1_opAmpD1}
  params:add{type = "control", id = "l1_opAmpS1",name = "l1_Osc1 Sustain", controlspec = specs.OPAMP_S, action = engine.l1_opAmpS1}
  params:add{type = "control", id = "l1_opAmpR1",name = "l1_Osc1 Release", controlspec = specs.OPAMP_R, action = engine.l1_opAmpR1}
  params:add{type = "control", id = "l1_opAmpA2",name = "l1_Osc2 Attack", controlspec = specs.OPAMP_A, action = engine.l1_opAmpA2}
  params:add{type = "control", id = "l1_opAmpD2",name = "l1_Osc2 Decay", controlspec = specs.OPAMP_D, action = engine.l1_opAmpD2}
  params:add{type = "control", id = "l1_opAmpS2",name = "l1_Osc2 Sustain", controlspec = specs.OPAMP_S, action = engine.l1_opAmpS2}
  params:add{type = "control", id = "l1_opAmpR2",name = "l1_Osc2 Release", controlspec = specs.OPAMP_R, action = engine.l1_opAmpR2}
  params:add{type = "control", id = "l1_opAmpA3",name = "l1_Osc3 Attack", controlspec = specs.OPAMP_A, action = engine.l1_opAmpA3}
  params:add{type = "control", id = "l1_opAmpD3",name = "l1_Osc3 Decay", controlspec = specs.OPAMP_D, action = engine.l1_opAmpD3}
  params:add{type = "control", id = "l1_opAmpS3",name = "l1_Osc3 Sustain", controlspec = specs.OPAMP_S, action = engine.l1_opAmpS3}
  params:add{type = "control", id = "l1_opAmpR3",name = "l1_Osc3 Release", controlspec = specs.OPAMP_R, action = engine.l1_opAmpR3}
  params:add{type = "control", id = "l1_opAmpA4",name = "l1_Osc4 Attack", controlspec = specs.OPAMP_A, action = engine.l1_opAmpA4}
  params:add{type = "control", id = "l1_opAmpD4",name = "l1_Osc4 Decay", controlspec = specs.OPAMP_D, action = engine.l1_opAmpD4}
  params:add{type = "control", id = "l1_opAmpS4",name = "l1_Osc4 Sustain", controlspec = specs.OPAMP_S, action = engine.l1_opAmpS4}
  params:add{type = "control", id = "l1_opAmpR4",name = "l1_Osc4 Release", controlspec = specs.OPAMP_R, action = engine.l1_opAmpR4}
  params:add{type = "control", id = "l1_opAmpA5",name = "l1_Osc5 Attack", controlspec = specs.OPAMP_A, action = engine.l1_opAmpA5}
  params:add{type = "control", id = "l1_opAmpD5",name = "l1_Osc5 Decay", controlspec = specs.OPAMP_D, action = engine.l1_opAmpD5}
  params:add{type = "control", id = "l1_opAmpS5",name = "l1_Osc5 Sustain", controlspec = specs.OPAMP_S, action = engine.l1_opAmpS5}
  params:add{type = "control", id = "l1_opAmpR5",name = "l1_Osc5 Release", controlspec = specs.OPAMP_R, action = engine.l1_opAmpR5}
  params:add{type = "control", id = "l1_opAmpA6",name = "l1_Osc6 Attack", controlspec = specs.OPAMP_A, action = engine.l1_opAmpA6}
  params:add{type = "control", id = "l1_opAmpD6",name = "l1_Osc6 Decay", controlspec = specs.OPAMP_D, action = engine.l1_opAmpD6}
  params:add{type = "control", id = "l1_opAmpS6",name = "l1_Osc6 Sustain", controlspec = specs.OPAMP_S, action = engine.l1_opAmpS6}
  params:add{type = "control", id = "l1_opAmpR6",name = "l1_Osc6 Release", controlspec = specs.OPAMP_R, action = engine.l1_opAmpR6}
  params:add_separator()
  params:add_separator()

-- l 2
  params:add{type = "control", id = "l2_hz1",name = "l2_Osc 1 F-Mult", controlspec = specs.HZ, action = engine.l2_hz1}
  params:add{type = "control", id = "l2_hz2",name = "l2_Osc 2 F-Mult", controlspec = specs.HZ, action = engine.l2_hz2}
  params:add{type = "control", id = "l2_hz3",name = "l2_Osc 3 F-Mult", controlspec = specs.HZ, action = engine.l2_hz3}
  params:add{type = "control", id = "l2_hz4",name = "l2_Osc 4 F-Mult", controlspec = specs.HZ, action = engine.l2_hz4}
  params:add{type = "control", id = "l2_hz5",name = "l2_Osc 5 F-Mult", controlspec = specs.HZ, action = engine.l2_hz5}
  params:add{type = "control", id = "l2_hz6",name = "l2_Osc 6 F-Mult", controlspec = specs.HZ, action = engine.l2_hz6}
  params:add_separator()
  params:add{type = "control", id = "l2_phase1",name = "l2_Osc 1 Phase", controlspec = specs.PHASE, action = engine.l2_phase1}
  params:add{type = "control", id = "l2_phase2",name = "l2_Osc 2 Phase", controlspec = specs.PHASE, action = engine.l2_phase2}
  params:add{type = "control", id = "l2_phase3",name = "l2_Osc 3 Phase", controlspec = specs.PHASE, action = engine.l2_phase3}
  params:add{type = "control", id = "l2_phase4",name = "l2_Osc 4 Phase", controlspec = specs.PHASE, action = engine.l2_phase4}
  params:add{type = "control", id = "l2_phase5",name = "l2_Osc 5 Phase", controlspec = specs.PHASE, action = engine.l2_phase5}
  params:add{type = "control", id = "l2_phase6",name = "l2_Osc 6 Phase", controlspec = specs.PHASE, action = engine.l2_phase6}
  params:add_separator()
  params:add{type = "control", id = "l2_amp1",name = "l2_Osc 1 Amplitude", controlspec = specs.AMP, action = engine.l2_amp1}
  params:add{type = "control", id = "l2_amp2",name = "l2_Osc 2 Amplitude", controlspec = specs.AMP, action = engine.l2_amp2}
  params:add{type = "control", id = "l2_amp3",name = "l2_Osc 3 Amplitude", controlspec = specs.AMP, action = engine.l2_amp3}
  params:add{type = "control", id = "l2_amp4",name = "l2_Osc 4 Amplitude", controlspec = specs.AMP, action = engine.l2_amp4}
  params:add{type = "control", id = "l2_amp5",name = "l2_Osc 5 Amplitude", controlspec = specs.AMP, action = engine.l2_amp5}
  params:add{type = "control", id = "l2_amp6",name = "l2_Osc 6 Amplitude", controlspec = specs.AMP, action = engine.l2_amp6}
  params:add_separator()
  params:add{type = "control", id = "l2_vels1",name = "l2_Osc 1 Vel Sens", controlspec = specs.VELS, action = engine.l2_vels1}
  params:add{type = "control", id = "l2_vels2",name = "l2_Osc 2 Vel Sens", controlspec = specs.VELS, action = engine.l2_vels2}
  params:add{type = "control", id = "l2_vels3",name = "l2_Osc 3 Vel Sens", controlspec = specs.VELS, action = engine.l2_vels3}
  params:add{type = "control", id = "l2_vels4",name = "l2_Osc 4 Vel Sens", controlspec = specs.VELS, action = engine.l2_vels4}
  params:add{type = "control", id = "l2_vels5",name = "l2_Osc 5 Vel Sens", controlspec = specs.VELS, action = engine.l2_vels5}
  params:add{type = "control", id = "l2_vels6",name = "l2_Osc 6 Vel Sens", controlspec = specs.VELS, action = engine.l2_vels6}
  params:add_separator()
  params:add{type = "control", id = "l2_hz1_to_hz1",name = "l2_Osc1 * Osc1", controlspec = specs.HZHZ, action = engine.l2_hz1_to_hz1}
  params:add{type = "control", id = "l2_hz1_to_hz2",name = "l2_Osc1 * Osc2", controlspec = specs.HZHZ, action = engine.l2_hz1_to_hz2}
  params:add{type = "control", id = "l2_hz1_to_hz3",name = "l2_Osc1 * Osc3", controlspec = specs.HZHZ, action = engine.l2_hz1_to_hz3}
  params:add{type = "control", id = "l2_hz1_to_hz4",name = "l2_Osc1 * Osc4", controlspec = specs.HZHZ, action = engine.l2_hz1_to_hz4}
  params:add{type = "control", id = "l2_hz1_to_hz5",name = "l2_Osc1 * Osc5", controlspec = specs.HZHZ, action = engine.l2_hz1_to_hz5}
  params:add{type = "control", id = "l2_hz1_to_hz6",name = "l2_Osc1 * Osc6", controlspec = specs.HZHZ, action = engine.l2_hz1_to_hz6}
  params:add{type = "control", id = "l2_hz2_to_hz1",name = "l2_Osc2 * Osc1", controlspec = specs.HZHZ, action = engine.l2_hz2_to_hz1}
  params:add{type = "control", id = "l2_hz2_to_hz2",name = "l2_Osc2 * Osc2", controlspec = specs.HZHZ, action = engine.l2_hz2_to_hz2}
  params:add{type = "control", id = "l2_hz2_to_hz3",name = "l2_Osc2 * Osc3", controlspec = specs.HZHZ, action = engine.l2_hz2_to_hz3}
  params:add{type = "control", id = "l2_hz2_to_hz4",name = "l2_Osc2 * Osc4", controlspec = specs.HZHZ, action = engine.l2_hz2_to_hz4}
  params:add{type = "control", id = "l2_hz2_to_hz5",name = "l2_Osc2 * Osc5", controlspec = specs.HZHZ, action = engine.l2_hz2_to_hz5}
  params:add{type = "control", id = "l2_hz2_to_hz6",name = "l2_Osc2 * Osc6", controlspec = specs.HZHZ, action = engine.l2_hz2_to_hz6}
  params:add{type = "control", id = "l2_hz3_to_hz1",name = "l2_Osc3 * Osc1", controlspec = specs.HZHZ, action = engine.l2_hz3_to_hz1}
  params:add{type = "control", id = "l2_hz3_to_hz2",name = "l2_Osc3 * Osc2", controlspec = specs.HZHZ, action = engine.l2_hz3_to_hz2}
  params:add{type = "control", id = "l2_hz3_to_hz3",name = "l2_Osc3 * Osc3", controlspec = specs.HZHZ, action = engine.l2_hz3_to_hz3}
  params:add{type = "control", id = "l2_hz3_to_hz4",name = "l2_Osc3 * Osc4", controlspec = specs.HZHZ, action = engine.l2_hz3_to_hz4}
  params:add{type = "control", id = "l2_hz3_to_hz5",name = "l2_Osc3 * Osc5", controlspec = specs.HZHZ, action = engine.l2_hz3_to_hz5}
  params:add{type = "control", id = "l2_hz3_to_hz6",name = "l2_Osc3 * Osc6", controlspec = specs.HZHZ, action = engine.l2_hz3_to_hz6}
  params:add{type = "control", id = "l2_hz4_to_hz1",name = "l2_Osc4 * Osc1", controlspec = specs.HZHZ, action = engine.l2_hz4_to_hz1}
  params:add{type = "control", id = "l2_hz4_to_hz2",name = "l2_Osc4 * Osc2", controlspec = specs.HZHZ, action = engine.l2_hz4_to_hz2}
  params:add{type = "control", id = "l2_hz4_to_hz3",name = "l2_Osc4 * Osc3", controlspec = specs.HZHZ, action = engine.l2_hz4_to_hz3}
  params:add{type = "control", id = "l2_hz4_to_hz4",name = "l2_Osc4 * Osc4", controlspec = specs.HZHZ, action = engine.l2_hz4_to_hz4}
  params:add{type = "control", id = "l2_hz4_to_hz5",name = "l2_Osc4 * Osc5", controlspec = specs.HZHZ, action = engine.l2_hz4_to_hz5}
  params:add{type = "control", id = "l2_hz4_to_hz6",name = "l2_Osc4 * Osc6", controlspec = specs.HZHZ, action = engine.l2_hz4_to_hz6}
  params:add{type = "control", id = "l2_hz5_to_hz1",name = "l2_Osc5 * Osc1", controlspec = specs.HZHZ, action = engine.l2_hz5_to_hz1}
  params:add{type = "control", id = "l2_hz5_to_hz2",name = "l2_Osc5 * Osc2", controlspec = specs.HZHZ, action = engine.l2_hz5_to_hz2}
  params:add{type = "control", id = "l2_hz5_to_hz3",name = "l2_Osc5 * Osc3", controlspec = specs.HZHZ, action = engine.l2_hz5_to_hz3}
  params:add{type = "control", id = "l2_hz5_to_hz4",name = "l2_Osc5 * Osc4", controlspec = specs.HZHZ, action = engine.l2_hz5_to_hz4}
  params:add{type = "control", id = "l2_hz5_to_hz5",name = "l2_Osc5 * Osc5", controlspec = specs.HZHZ, action = engine.l2_hz5_to_hz5}
  params:add{type = "control", id = "l2_hz5_to_hz6",name = "l2_Osc5 * Osc6", controlspec = specs.HZHZ, action = engine.l2_hz5_to_hz6}
  params:add{type = "control", id = "l2_hz6_to_hz1",name = "l2_Osc6 * Osc1", controlspec = specs.HZHZ, action = engine.l2_hz6_to_hz1}
  params:add{type = "control", id = "l2_hz6_to_hz2",name = "l2_Osc6 * Osc2", controlspec = specs.HZHZ, action = engine.l2_hz6_to_hz2}
  params:add{type = "control", id = "l2_hz6_to_hz3",name = "l2_Osc6 * Osc3", controlspec = specs.HZHZ, action = engine.l2_hz6_to_hz3}
  params:add{type = "control", id = "l2_hz6_to_hz4",name = "l2_Osc6 * Osc4", controlspec = specs.HZHZ, action = engine.l2_hz6_to_hz4}
  params:add{type = "control", id = "l2_hz6_to_hz5",name = "l2_Osc6 * Osc5", controlspec = specs.HZHZ, action = engine.l2_hz6_to_hz5}
  params:add{type = "control", id = "l2_hz6_to_hz6",name = "l2_Osc6 * Osc6", controlspec = specs.HZHZ, action = engine.l2_hz6_to_hz6}
  params:add_separator()
  params:add{type = "control", id = "l2_carrier1",name = "l2_Cr 1 Amplitude", controlspec = specs.CARRIERA, action = engine.l2_carrier1}
  params:add{type = "control", id = "l2_carrier2",name = "l2_Cr 2 Amplitude", controlspec = specs.CARRIERB, action = engine.l2_carrier2}
  params:add{type = "control", id = "l2_carrier3",name = "l2_Cr 3 Amplitude", controlspec = specs.CARRIERB, action = engine.l2_carrier3}
  params:add{type = "control", id = "l2_carrier4",name = "l2_Cr 4 Amplitude", controlspec = specs.CARRIERB, action = engine.l2_carrier4}
  params:add{type = "control", id = "l2_carrier5",name = "l2_Cr 5 Amplitude", controlspec = specs.CARRIERB, action = engine.l2_carrier5}
  params:add{type = "control", id = "l2_carrier6",name = "l2_Cr 6 Amplitude", controlspec = specs.CARRIERB, action = engine.l2_carrier6}
  params:add_separator()
  params:add{type = "control", id = "l2_opAmpA1",name = "l2_Osc1 Attack", controlspec = specs.OPAMP_A, action = engine.l2_opAmpA1}
  params:add{type = "control", id = "l2_opAmpD1",name = "l2_Osc1 Decay", controlspec = specs.OPAMP_D, action = engine.l2_opAmpD1}
  params:add{type = "control", id = "l2_opAmpS1",name = "l2_Osc1 Sustain", controlspec = specs.OPAMP_S, action = engine.l2_opAmpS1}
  params:add{type = "control", id = "l2_opAmpR1",name = "l2_Osc1 Release", controlspec = specs.OPAMP_R, action = engine.l2_opAmpR1}
  params:add{type = "control", id = "l2_opAmpA2",name = "l2_Osc2 Attack", controlspec = specs.OPAMP_A, action = engine.l2_opAmpA2}
  params:add{type = "control", id = "l2_opAmpD2",name = "l2_Osc2 Decay", controlspec = specs.OPAMP_D, action = engine.l2_opAmpD2}
  params:add{type = "control", id = "l2_opAmpS2",name = "l2_Osc2 Sustain", controlspec = specs.OPAMP_S, action = engine.l2_opAmpS2}
  params:add{type = "control", id = "l2_opAmpR2",name = "l2_Osc2 Release", controlspec = specs.OPAMP_R, action = engine.l2_opAmpR2}
  params:add{type = "control", id = "l2_opAmpA3",name = "l2_Osc3 Attack", controlspec = specs.OPAMP_A, action = engine.l2_opAmpA3}
  params:add{type = "control", id = "l2_opAmpD3",name = "l2_Osc3 Decay", controlspec = specs.OPAMP_D, action = engine.l2_opAmpD3}
  params:add{type = "control", id = "l2_opAmpS3",name = "l2_Osc3 Sustain", controlspec = specs.OPAMP_S, action = engine.l2_opAmpS3}
  params:add{type = "control", id = "l2_opAmpR3",name = "l2_Osc3 Release", controlspec = specs.OPAMP_R, action = engine.l2_opAmpR3}
  params:add{type = "control", id = "l2_opAmpA4",name = "l2_Osc4 Attack", controlspec = specs.OPAMP_A, action = engine.l2_opAmpA4}
  params:add{type = "control", id = "l2_opAmpD4",name = "l2_Osc4 Decay", controlspec = specs.OPAMP_D, action = engine.l2_opAmpD4}
  params:add{type = "control", id = "l2_opAmpS4",name = "l2_Osc4 Sustain", controlspec = specs.OPAMP_S, action = engine.l2_opAmpS4}
  params:add{type = "control", id = "l2_opAmpR4",name = "l2_Osc4 Release", controlspec = specs.OPAMP_R, action = engine.l2_opAmpR4}
  params:add{type = "control", id = "l2_opAmpA5",name = "l2_Osc5 Attack", controlspec = specs.OPAMP_A, action = engine.l2_opAmpA5}
  params:add{type = "control", id = "l2_opAmpD5",name = "l2_Osc5 Decay", controlspec = specs.OPAMP_D, action = engine.l2_opAmpD5}
  params:add{type = "control", id = "l2_opAmpS5",name = "l2_Osc5 Sustain", controlspec = specs.OPAMP_S, action = engine.l2_opAmpS5}
  params:add{type = "control", id = "l2_opAmpR5",name = "l2_Osc5 Release", controlspec = specs.OPAMP_R, action = engine.l2_opAmpR5}
  params:add{type = "control", id = "l2_opAmpA6",name = "l2_Osc6 Attack", controlspec = specs.OPAMP_A, action = engine.l2_opAmpA6}
  params:add{type = "control", id = "l2_opAmpD6",name = "l2_Osc6 Decay", controlspec = specs.OPAMP_D, action = engine.l2_opAmpD6}
  params:add{type = "control", id = "l2_opAmpS6",name = "l2_Osc6 Sustain", controlspec = specs.OPAMP_S, action = engine.l2_opAmpS6}
  params:add{type = "control", id = "l2_opAmpR6",name = "l2_Osc6 Release", controlspec = specs.OPAMP_R, action = engine.l2_opAmpR6}
  params:add_separator()
  params:add_separator()

-- l 3
  params:add{type = "control", id = "l3_hz1",name = "l3_Osc 1 F-Mult", controlspec = specs.HZ, action = engine.l3_hz1}
  params:add{type = "control", id = "l3_hz2",name = "l3_Osc 2 F-Mult", controlspec = specs.HZ, action = engine.l3_hz2}
  params:add{type = "control", id = "l3_hz3",name = "l3_Osc 3 F-Mult", controlspec = specs.HZ, action = engine.l3_hz3}
  params:add{type = "control", id = "l3_hz4",name = "l3_Osc 4 F-Mult", controlspec = specs.HZ, action = engine.l3_hz4}
  params:add{type = "control", id = "l3_hz5",name = "l3_Osc 5 F-Mult", controlspec = specs.HZ, action = engine.l3_hz5}
  params:add{type = "control", id = "l3_hz6",name = "l3_Osc 6 F-Mult", controlspec = specs.HZ, action = engine.l3_hz6}
  params:add_separator()
  params:add{type = "control", id = "l3_phase1",name = "l3_Osc 1 Phase", controlspec = specs.PHASE, action = engine.l3_phase1}
  params:add{type = "control", id = "l3_phase2",name = "l3_Osc 2 Phase", controlspec = specs.PHASE, action = engine.l3_phase2}
  params:add{type = "control", id = "l3_phase3",name = "l3_Osc 3 Phase", controlspec = specs.PHASE, action = engine.l3_phase3}
  params:add{type = "control", id = "l3_phase4",name = "l3_Osc 4 Phase", controlspec = specs.PHASE, action = engine.l3_phase4}
  params:add{type = "control", id = "l3_phase5",name = "l3_Osc 5 Phase", controlspec = specs.PHASE, action = engine.l3_phase5}
  params:add{type = "control", id = "l3_phase6",name = "l3_Osc 6 Phase", controlspec = specs.PHASE, action = engine.l3_phase6}
  params:add_separator()
  params:add{type = "control", id = "l3_amp1",name = "l3_Osc 1 Amplitude", controlspec = specs.AMP, action = engine.l3_amp1}
  params:add{type = "control", id = "l3_amp2",name = "l3_Osc 2 Amplitude", controlspec = specs.AMP, action = engine.l3_amp2}
  params:add{type = "control", id = "l3_amp3",name = "l3_Osc 3 Amplitude", controlspec = specs.AMP, action = engine.l3_amp3}
  params:add{type = "control", id = "l3_amp4",name = "l3_Osc 4 Amplitude", controlspec = specs.AMP, action = engine.l3_amp4}
  params:add{type = "control", id = "l3_amp5",name = "l3_Osc 5 Amplitude", controlspec = specs.AMP, action = engine.l3_amp5}
  params:add{type = "control", id = "l3_amp6",name = "l3_Osc 6 Amplitude", controlspec = specs.AMP, action = engine.l3_amp6}
  params:add_separator()
  params:add{type = "control", id = "l3_vels1",name = "l3_Osc 1 Vel Sens", controlspec = specs.VELS, action = engine.l3_vels1}
  params:add{type = "control", id = "l3_vels2",name = "l3_Osc 2 Vel Sens", controlspec = specs.VELS, action = engine.l3_vels2}
  params:add{type = "control", id = "l3_vels3",name = "l3_Osc 3 Vel Sens", controlspec = specs.VELS, action = engine.l3_vels3}
  params:add{type = "control", id = "l3_vels4",name = "l3_Osc 4 Vel Sens", controlspec = specs.VELS, action = engine.l3_vels4}
  params:add{type = "control", id = "l3_vels5",name = "l3_Osc 5 Vel Sens", controlspec = specs.VELS, action = engine.l3_vels5}
  params:add{type = "control", id = "l3_vels6",name = "l3_Osc 6 Vel Sens", controlspec = specs.VELS, action = engine.l3_vels6}
  params:add_separator()
  params:add{type = "control", id = "l3_hz1_to_hz1",name = "l3_Osc1 * Osc1", controlspec = specs.HZHZ, action = engine.l3_hz1_to_hz1}
  params:add{type = "control", id = "l3_hz1_to_hz2",name = "l3_Osc1 * Osc2", controlspec = specs.HZHZ, action = engine.l3_hz1_to_hz2}
  params:add{type = "control", id = "l3_hz1_to_hz3",name = "l3_Osc1 * Osc3", controlspec = specs.HZHZ, action = engine.l3_hz1_to_hz3}
  params:add{type = "control", id = "l3_hz1_to_hz4",name = "l3_Osc1 * Osc4", controlspec = specs.HZHZ, action = engine.l3_hz1_to_hz4}
  params:add{type = "control", id = "l3_hz1_to_hz5",name = "l3_Osc1 * Osc5", controlspec = specs.HZHZ, action = engine.l3_hz1_to_hz5}
  params:add{type = "control", id = "l3_hz1_to_hz6",name = "l3_Osc1 * Osc6", controlspec = specs.HZHZ, action = engine.l3_hz1_to_hz6}
  params:add{type = "control", id = "l3_hz2_to_hz1",name = "l3_Osc2 * Osc1", controlspec = specs.HZHZ, action = engine.l3_hz2_to_hz1}
  params:add{type = "control", id = "l3_hz2_to_hz2",name = "l3_Osc2 * Osc2", controlspec = specs.HZHZ, action = engine.l3_hz2_to_hz2}
  params:add{type = "control", id = "l3_hz2_to_hz3",name = "l3_Osc2 * Osc3", controlspec = specs.HZHZ, action = engine.l3_hz2_to_hz3}
  params:add{type = "control", id = "l3_hz2_to_hz4",name = "l3_Osc2 * Osc4", controlspec = specs.HZHZ, action = engine.l3_hz2_to_hz4}
  params:add{type = "control", id = "l3_hz2_to_hz5",name = "l3_Osc2 * Osc5", controlspec = specs.HZHZ, action = engine.l3_hz2_to_hz5}
  params:add{type = "control", id = "l3_hz2_to_hz6",name = "l3_Osc2 * Osc6", controlspec = specs.HZHZ, action = engine.l3_hz2_to_hz6}
  params:add{type = "control", id = "l3_hz3_to_hz1",name = "l3_Osc3 * Osc1", controlspec = specs.HZHZ, action = engine.l3_hz3_to_hz1}
  params:add{type = "control", id = "l3_hz3_to_hz2",name = "l3_Osc3 * Osc2", controlspec = specs.HZHZ, action = engine.l3_hz3_to_hz2}
  params:add{type = "control", id = "l3_hz3_to_hz3",name = "l3_Osc3 * Osc3", controlspec = specs.HZHZ, action = engine.l3_hz3_to_hz3}
  params:add{type = "control", id = "l3_hz3_to_hz4",name = "l3_Osc3 * Osc4", controlspec = specs.HZHZ, action = engine.l3_hz3_to_hz4}
  params:add{type = "control", id = "l3_hz3_to_hz5",name = "l3_Osc3 * Osc5", controlspec = specs.HZHZ, action = engine.l3_hz3_to_hz5}
  params:add{type = "control", id = "l3_hz3_to_hz6",name = "l3_Osc3 * Osc6", controlspec = specs.HZHZ, action = engine.l3_hz3_to_hz6}
  params:add{type = "control", id = "l3_hz4_to_hz1",name = "l3_Osc4 * Osc1", controlspec = specs.HZHZ, action = engine.l3_hz4_to_hz1}
  params:add{type = "control", id = "l3_hz4_to_hz2",name = "l3_Osc4 * Osc2", controlspec = specs.HZHZ, action = engine.l3_hz4_to_hz2}
  params:add{type = "control", id = "l3_hz4_to_hz3",name = "l3_Osc4 * Osc3", controlspec = specs.HZHZ, action = engine.l3_hz4_to_hz3}
  params:add{type = "control", id = "l3_hz4_to_hz4",name = "l3_Osc4 * Osc4", controlspec = specs.HZHZ, action = engine.l3_hz4_to_hz4}
  params:add{type = "control", id = "l3_hz4_to_hz5",name = "l3_Osc4 * Osc5", controlspec = specs.HZHZ, action = engine.l3_hz4_to_hz5}
  params:add{type = "control", id = "l3_hz4_to_hz6",name = "l3_Osc4 * Osc6", controlspec = specs.HZHZ, action = engine.l3_hz4_to_hz6}
  params:add{type = "control", id = "l3_hz5_to_hz1",name = "l3_Osc5 * Osc1", controlspec = specs.HZHZ, action = engine.l3_hz5_to_hz1}
  params:add{type = "control", id = "l3_hz5_to_hz2",name = "l3_Osc5 * Osc2", controlspec = specs.HZHZ, action = engine.l3_hz5_to_hz2}
  params:add{type = "control", id = "l3_hz5_to_hz3",name = "l3_Osc5 * Osc3", controlspec = specs.HZHZ, action = engine.l3_hz5_to_hz3}
  params:add{type = "control", id = "l3_hz5_to_hz4",name = "l3_Osc5 * Osc4", controlspec = specs.HZHZ, action = engine.l3_hz5_to_hz4}
  params:add{type = "control", id = "l3_hz5_to_hz5",name = "l3_Osc5 * Osc5", controlspec = specs.HZHZ, action = engine.l3_hz5_to_hz5}
  params:add{type = "control", id = "l3_hz5_to_hz6",name = "l3_Osc5 * Osc6", controlspec = specs.HZHZ, action = engine.l3_hz5_to_hz6}
  params:add{type = "control", id = "l3_hz6_to_hz1",name = "l3_Osc6 * Osc1", controlspec = specs.HZHZ, action = engine.l3_hz6_to_hz1}
  params:add{type = "control", id = "l3_hz6_to_hz2",name = "l3_Osc6 * Osc2", controlspec = specs.HZHZ, action = engine.l3_hz6_to_hz2}
  params:add{type = "control", id = "l3_hz6_to_hz3",name = "l3_Osc6 * Osc3", controlspec = specs.HZHZ, action = engine.l3_hz6_to_hz3}
  params:add{type = "control", id = "l3_hz6_to_hz4",name = "l3_Osc6 * Osc4", controlspec = specs.HZHZ, action = engine.l3_hz6_to_hz4}
  params:add{type = "control", id = "l3_hz6_to_hz5",name = "l3_Osc6 * Osc5", controlspec = specs.HZHZ, action = engine.l3_hz6_to_hz5}
  params:add{type = "control", id = "l3_hz6_to_hz6",name = "l3_Osc6 * Osc6", controlspec = specs.HZHZ, action = engine.l3_hz6_to_hz6}
  params:add_separator()
  params:add{type = "control", id = "l3_carrier1",name = "l3_Cr 1 Amplitude", controlspec = specs.CARRIERA, action = engine.l3_carrier1}
  params:add{type = "control", id = "l3_carrier2",name = "l3_Cr 2 Amplitude", controlspec = specs.CARRIERB, action = engine.l3_carrier2}
  params:add{type = "control", id = "l3_carrier3",name = "l3_Cr 3 Amplitude", controlspec = specs.CARRIERB, action = engine.l3_carrier3}
  params:add{type = "control", id = "l3_carrier4",name = "l3_Cr 4 Amplitude", controlspec = specs.CARRIERB, action = engine.l3_carrier4}
  params:add{type = "control", id = "l3_carrier5",name = "l3_Cr 5 Amplitude", controlspec = specs.CARRIERB, action = engine.l3_carrier5}
  params:add{type = "control", id = "l3_carrier6",name = "l3_Cr 6 Amplitude", controlspec = specs.CARRIERB, action = engine.l3_carrier6}
  params:add_separator()
  params:add{type = "control", id = "l3_opAmpA1",name = "l3_Osc1 Attack", controlspec = specs.OPAMP_A, action = engine.l3_opAmpA1}
  params:add{type = "control", id = "l3_opAmpD1",name = "l3_Osc1 Decay", controlspec = specs.OPAMP_D, action = engine.l3_opAmpD1}
  params:add{type = "control", id = "l3_opAmpS1",name = "l3_Osc1 Sustain", controlspec = specs.OPAMP_S, action = engine.l3_opAmpS1}
  params:add{type = "control", id = "l3_opAmpR1",name = "l3_Osc1 Release", controlspec = specs.OPAMP_R, action = engine.l3_opAmpR1}
  params:add{type = "control", id = "l3_opAmpA2",name = "l3_Osc2 Attack", controlspec = specs.OPAMP_A, action = engine.l3_opAmpA2}
  params:add{type = "control", id = "l3_opAmpD2",name = "l3_Osc2 Decay", controlspec = specs.OPAMP_D, action = engine.l3_opAmpD2}
  params:add{type = "control", id = "l3_opAmpS2",name = "l3_Osc2 Sustain", controlspec = specs.OPAMP_S, action = engine.l3_opAmpS2}
  params:add{type = "control", id = "l3_opAmpR2",name = "l3_Osc2 Release", controlspec = specs.OPAMP_R, action = engine.l3_opAmpR2}
  params:add{type = "control", id = "l3_opAmpA3",name = "l3_Osc3 Attack", controlspec = specs.OPAMP_A, action = engine.l3_opAmpA3}
  params:add{type = "control", id = "l3_opAmpD3",name = "l3_Osc3 Decay", controlspec = specs.OPAMP_D, action = engine.l3_opAmpD3}
  params:add{type = "control", id = "l3_opAmpS3",name = "l3_Osc3 Sustain", controlspec = specs.OPAMP_S, action = engine.l3_opAmpS3}
  params:add{type = "control", id = "l3_opAmpR3",name = "l3_Osc3 Release", controlspec = specs.OPAMP_R, action = engine.l3_opAmpR3}
  params:add{type = "control", id = "l3_opAmpA4",name = "l3_Osc4 Attack", controlspec = specs.OPAMP_A, action = engine.l3_opAmpA4}
  params:add{type = "control", id = "l3_opAmpD4",name = "l3_Osc4 Decay", controlspec = specs.OPAMP_D, action = engine.l3_opAmpD4}
  params:add{type = "control", id = "l3_opAmpS4",name = "l3_Osc4 Sustain", controlspec = specs.OPAMP_S, action = engine.l3_opAmpS4}
  params:add{type = "control", id = "l3_opAmpR4",name = "l3_Osc4 Release", controlspec = specs.OPAMP_R, action = engine.l3_opAmpR4}
  params:add{type = "control", id = "l3_opAmpA5",name = "l3_Osc5 Attack", controlspec = specs.OPAMP_A, action = engine.l3_opAmpA5}
  params:add{type = "control", id = "l3_opAmpD5",name = "l3_Osc5 Decay", controlspec = specs.OPAMP_D, action = engine.l3_opAmpD5}
  params:add{type = "control", id = "l3_opAmpS5",name = "l3_Osc5 Sustain", controlspec = specs.OPAMP_S, action = engine.l3_opAmpS5}
  params:add{type = "control", id = "l3_opAmpR5",name = "l3_Osc5 Release", controlspec = specs.OPAMP_R, action = engine.l3_opAmpR5}
  params:add{type = "control", id = "l3_opAmpA6",name = "l3_Osc6 Attack", controlspec = specs.OPAMP_A, action = engine.l3_opAmpA6}
  params:add{type = "control", id = "l3_opAmpD6",name = "l3_Osc6 Decay", controlspec = specs.OPAMP_D, action = engine.l3_opAmpD6}
  params:add{type = "control", id = "l3_opAmpS6",name = "l3_Osc6 Sustain", controlspec = specs.OPAMP_S, action = engine.l3_opAmpS6}
  params:add{type = "control", id = "l3_opAmpR6",name = "l3_Osc6 Release", controlspec = specs.OPAMP_R, action = engine.l3_opAmpR6}
  params:add_separator()
  params:add_separator()

-- l 4
  params:add{type = "control", id = "l4_hz1",name = "l4_Osc 1 F-Mult", controlspec = specs.HZ, action = engine.l4_hz1}
  params:add{type = "control", id = "l4_hz2",name = "l4_Osc 2 F-Mult", controlspec = specs.HZ, action = engine.l4_hz2}
  params:add{type = "control", id = "l4_hz3",name = "l4_Osc 3 F-Mult", controlspec = specs.HZ, action = engine.l4_hz3}
  params:add{type = "control", id = "l4_hz4",name = "l4_Osc 4 F-Mult", controlspec = specs.HZ, action = engine.l4_hz4}
  params:add{type = "control", id = "l4_hz5",name = "l4_Osc 5 F-Mult", controlspec = specs.HZ, action = engine.l4_hz5}
  params:add{type = "control", id = "l4_hz6",name = "l4_Osc 6 F-Mult", controlspec = specs.HZ, action = engine.l4_hz6}
  params:add_separator()
  params:add{type = "control", id = "l4_phase1",name = "l4_Osc 1 Phase", controlspec = specs.PHASE, action = engine.l4_phase1}
  params:add{type = "control", id = "l4_phase2",name = "l4_Osc 2 Phase", controlspec = specs.PHASE, action = engine.l4_phase2}
  params:add{type = "control", id = "l4_phase3",name = "l4_Osc 3 Phase", controlspec = specs.PHASE, action = engine.l4_phase3}
  params:add{type = "control", id = "l4_phase4",name = "l4_Osc 4 Phase", controlspec = specs.PHASE, action = engine.l4_phase4}
  params:add{type = "control", id = "l4_phase5",name = "l4_Osc 5 Phase", controlspec = specs.PHASE, action = engine.l4_phase5}
  params:add{type = "control", id = "l4_phase6",name = "l4_Osc 6 Phase", controlspec = specs.PHASE, action = engine.l4_phase6}
  params:add_separator()
  params:add{type = "control", id = "l4_amp1",name = "l4_Osc 1 Amplitude", controlspec = specs.AMP, action = engine.l4_amp1}
  params:add{type = "control", id = "l4_amp2",name = "l4_Osc 2 Amplitude", controlspec = specs.AMP, action = engine.l4_amp2}
  params:add{type = "control", id = "l4_amp3",name = "l4_Osc 3 Amplitude", controlspec = specs.AMP, action = engine.l4_amp3}
  params:add{type = "control", id = "l4_amp4",name = "l4_Osc 4 Amplitude", controlspec = specs.AMP, action = engine.l4_amp4}
  params:add{type = "control", id = "l4_amp5",name = "l4_Osc 5 Amplitude", controlspec = specs.AMP, action = engine.l4_amp5}
  params:add{type = "control", id = "l4_amp6",name = "l4_Osc 6 Amplitude", controlspec = specs.AMP, action = engine.l4_amp6}
  params:add_separator()
  params:add{type = "control", id = "l4_vels1",name = "l4_Osc 1 Vel Sens", controlspec = specs.VELS, action = engine.l4_vels1}
  params:add{type = "control", id = "l4_vels2",name = "l4_Osc 2 Vel Sens", controlspec = specs.VELS, action = engine.l4_vels2}
  params:add{type = "control", id = "l4_vels3",name = "l4_Osc 3 Vel Sens", controlspec = specs.VELS, action = engine.l4_vels3}
  params:add{type = "control", id = "l4_vels4",name = "l4_Osc 4 Vel Sens", controlspec = specs.VELS, action = engine.l4_vels4}
  params:add{type = "control", id = "l4_vels5",name = "l4_Osc 5 Vel Sens", controlspec = specs.VELS, action = engine.l4_vels5}
  params:add{type = "control", id = "l4_vels6",name = "l4_Osc 6 Vel Sens", controlspec = specs.VELS, action = engine.l4_vels6}
  params:add_separator()
  params:add{type = "control", id = "l4_hz1_to_hz1",name = "l4_Osc1 * Osc1", controlspec = specs.HZHZ, action = engine.l4_hz1_to_hz1}
  params:add{type = "control", id = "l4_hz1_to_hz2",name = "l4_Osc1 * Osc2", controlspec = specs.HZHZ, action = engine.l4_hz1_to_hz2}
  params:add{type = "control", id = "l4_hz1_to_hz3",name = "l4_Osc1 * Osc3", controlspec = specs.HZHZ, action = engine.l4_hz1_to_hz3}
  params:add{type = "control", id = "l4_hz1_to_hz4",name = "l4_Osc1 * Osc4", controlspec = specs.HZHZ, action = engine.l4_hz1_to_hz4}
  params:add{type = "control", id = "l4_hz1_to_hz5",name = "l4_Osc1 * Osc5", controlspec = specs.HZHZ, action = engine.l4_hz1_to_hz5}
  params:add{type = "control", id = "l4_hz1_to_hz6",name = "l4_Osc1 * Osc6", controlspec = specs.HZHZ, action = engine.l4_hz1_to_hz6}
  params:add{type = "control", id = "l4_hz2_to_hz1",name = "l4_Osc2 * Osc1", controlspec = specs.HZHZ, action = engine.l4_hz2_to_hz1}
  params:add{type = "control", id = "l4_hz2_to_hz2",name = "l4_Osc2 * Osc2", controlspec = specs.HZHZ, action = engine.l4_hz2_to_hz2}
  params:add{type = "control", id = "l4_hz2_to_hz3",name = "l4_Osc2 * Osc3", controlspec = specs.HZHZ, action = engine.l4_hz2_to_hz3}
  params:add{type = "control", id = "l4_hz2_to_hz4",name = "l4_Osc2 * Osc4", controlspec = specs.HZHZ, action = engine.l4_hz2_to_hz4}
  params:add{type = "control", id = "l4_hz2_to_hz5",name = "l4_Osc2 * Osc5", controlspec = specs.HZHZ, action = engine.l4_hz2_to_hz5}
  params:add{type = "control", id = "l4_hz2_to_hz6",name = "l4_Osc2 * Osc6", controlspec = specs.HZHZ, action = engine.l4_hz2_to_hz6}
  params:add{type = "control", id = "l4_hz3_to_hz1",name = "l4_Osc3 * Osc1", controlspec = specs.HZHZ, action = engine.l4_hz3_to_hz1}
  params:add{type = "control", id = "l4_hz3_to_hz2",name = "l4_Osc3 * Osc2", controlspec = specs.HZHZ, action = engine.l4_hz3_to_hz2}
  params:add{type = "control", id = "l4_hz3_to_hz3",name = "l4_Osc3 * Osc3", controlspec = specs.HZHZ, action = engine.l4_hz3_to_hz3}
  params:add{type = "control", id = "l4_hz3_to_hz4",name = "l4_Osc3 * Osc4", controlspec = specs.HZHZ, action = engine.l4_hz3_to_hz4}
  params:add{type = "control", id = "l4_hz3_to_hz5",name = "l4_Osc3 * Osc5", controlspec = specs.HZHZ, action = engine.l4_hz3_to_hz5}
  params:add{type = "control", id = "l4_hz3_to_hz6",name = "l4_Osc3 * Osc6", controlspec = specs.HZHZ, action = engine.l4_hz3_to_hz6}
  params:add{type = "control", id = "l4_hz4_to_hz1",name = "l4_Osc4 * Osc1", controlspec = specs.HZHZ, action = engine.l4_hz4_to_hz1}
  params:add{type = "control", id = "l4_hz4_to_hz2",name = "l4_Osc4 * Osc2", controlspec = specs.HZHZ, action = engine.l4_hz4_to_hz2}
  params:add{type = "control", id = "l4_hz4_to_hz3",name = "l4_Osc4 * Osc3", controlspec = specs.HZHZ, action = engine.l4_hz4_to_hz3}
  params:add{type = "control", id = "l4_hz4_to_hz4",name = "l4_Osc4 * Osc4", controlspec = specs.HZHZ, action = engine.l4_hz4_to_hz4}
  params:add{type = "control", id = "l4_hz4_to_hz5",name = "l4_Osc4 * Osc5", controlspec = specs.HZHZ, action = engine.l4_hz4_to_hz5}
  params:add{type = "control", id = "l4_hz4_to_hz6",name = "l4_Osc4 * Osc6", controlspec = specs.HZHZ, action = engine.l4_hz4_to_hz6}
  params:add{type = "control", id = "l4_hz5_to_hz1",name = "l4_Osc5 * Osc1", controlspec = specs.HZHZ, action = engine.l4_hz5_to_hz1}
  params:add{type = "control", id = "l4_hz5_to_hz2",name = "l4_Osc5 * Osc2", controlspec = specs.HZHZ, action = engine.l4_hz5_to_hz2}
  params:add{type = "control", id = "l4_hz5_to_hz3",name = "l4_Osc5 * Osc3", controlspec = specs.HZHZ, action = engine.l4_hz5_to_hz3}
  params:add{type = "control", id = "l4_hz5_to_hz4",name = "l4_Osc5 * Osc4", controlspec = specs.HZHZ, action = engine.l4_hz5_to_hz4}
  params:add{type = "control", id = "l4_hz5_to_hz5",name = "l4_Osc5 * Osc5", controlspec = specs.HZHZ, action = engine.l4_hz5_to_hz5}
  params:add{type = "control", id = "l4_hz5_to_hz6",name = "l4_Osc5 * Osc6", controlspec = specs.HZHZ, action = engine.l4_hz5_to_hz6}
  params:add{type = "control", id = "l4_hz6_to_hz1",name = "l4_Osc6 * Osc1", controlspec = specs.HZHZ, action = engine.l4_hz6_to_hz1}
  params:add{type = "control", id = "l4_hz6_to_hz2",name = "l4_Osc6 * Osc2", controlspec = specs.HZHZ, action = engine.l4_hz6_to_hz2}
  params:add{type = "control", id = "l4_hz6_to_hz3",name = "l4_Osc6 * Osc3", controlspec = specs.HZHZ, action = engine.l4_hz6_to_hz3}
  params:add{type = "control", id = "l4_hz6_to_hz4",name = "l4_Osc6 * Osc4", controlspec = specs.HZHZ, action = engine.l4_hz6_to_hz4}
  params:add{type = "control", id = "l4_hz6_to_hz5",name = "l4_Osc6 * Osc5", controlspec = specs.HZHZ, action = engine.l4_hz6_to_hz5}
  params:add{type = "control", id = "l4_hz6_to_hz6",name = "l4_Osc6 * Osc6", controlspec = specs.HZHZ, action = engine.l4_hz6_to_hz6}
  params:add_separator()
  params:add{type = "control", id = "l4_carrier1",name = "l4_Cr 1 Amplitude", controlspec = specs.CARRIERA, action = engine.l4_carrier1}
  params:add{type = "control", id = "l4_carrier2",name = "l4_Cr 2 Amplitude", controlspec = specs.CARRIERB, action = engine.l4_carrier2}
  params:add{type = "control", id = "l4_carrier3",name = "l4_Cr 3 Amplitude", controlspec = specs.CARRIERB, action = engine.l4_carrier3}
  params:add{type = "control", id = "l4_carrier4",name = "l4_Cr 4 Amplitude", controlspec = specs.CARRIERB, action = engine.l4_carrier4}
  params:add{type = "control", id = "l4_carrier5",name = "l4_Cr 5 Amplitude", controlspec = specs.CARRIERB, action = engine.l4_carrier5}
  params:add{type = "control", id = "l4_carrier6",name = "l4_Cr 6 Amplitude", controlspec = specs.CARRIERB, action = engine.l4_carrier6}
  params:add_separator()
  params:add{type = "control", id = "l4_opAmpA1",name = "l4_Osc1 Attack", controlspec = specs.OPAMP_A, action = engine.l4_opAmpA1}
  params:add{type = "control", id = "l4_opAmpD1",name = "l4_Osc1 Decay", controlspec = specs.OPAMP_D, action = engine.l4_opAmpD1}
  params:add{type = "control", id = "l4_opAmpS1",name = "l4_Osc1 Sustain", controlspec = specs.OPAMP_S, action = engine.l4_opAmpS1}
  params:add{type = "control", id = "l4_opAmpR1",name = "l4_Osc1 Release", controlspec = specs.OPAMP_R, action = engine.l4_opAmpR1}
  params:add{type = "control", id = "l4_opAmpA2",name = "l4_Osc2 Attack", controlspec = specs.OPAMP_A, action = engine.l4_opAmpA2}
  params:add{type = "control", id = "l4_opAmpD2",name = "l4_Osc2 Decay", controlspec = specs.OPAMP_D, action = engine.l4_opAmpD2}
  params:add{type = "control", id = "l4_opAmpS2",name = "l4_Osc2 Sustain", controlspec = specs.OPAMP_S, action = engine.l4_opAmpS2}
  params:add{type = "control", id = "l4_opAmpR2",name = "l4_Osc2 Release", controlspec = specs.OPAMP_R, action = engine.l4_opAmpR2}
  params:add{type = "control", id = "l4_opAmpA3",name = "l4_Osc3 Attack", controlspec = specs.OPAMP_A, action = engine.l4_opAmpA3}
  params:add{type = "control", id = "l4_opAmpD3",name = "l4_Osc3 Decay", controlspec = specs.OPAMP_D, action = engine.l4_opAmpD3}
  params:add{type = "control", id = "l4_opAmpS3",name = "l4_Osc3 Sustain", controlspec = specs.OPAMP_S, action = engine.l4_opAmpS3}
  params:add{type = "control", id = "l4_opAmpR3",name = "l4_Osc3 Release", controlspec = specs.OPAMP_R, action = engine.l4_opAmpR3}
  params:add{type = "control", id = "l4_opAmpA4",name = "l4_Osc4 Attack", controlspec = specs.OPAMP_A, action = engine.l4_opAmpA4}
  params:add{type = "control", id = "l4_opAmpD4",name = "l4_Osc4 Decay", controlspec = specs.OPAMP_D, action = engine.l4_opAmpD4}
  params:add{type = "control", id = "l4_opAmpS4",name = "l4_Osc4 Sustain", controlspec = specs.OPAMP_S, action = engine.l4_opAmpS4}
  params:add{type = "control", id = "l4_opAmpR4",name = "l4_Osc4 Release", controlspec = specs.OPAMP_R, action = engine.l4_opAmpR4}
  params:add{type = "control", id = "l4_opAmpA5",name = "l4_Osc5 Attack", controlspec = specs.OPAMP_A, action = engine.l4_opAmpA5}
  params:add{type = "control", id = "l4_opAmpD5",name = "l4_Osc5 Decay", controlspec = specs.OPAMP_D, action = engine.l4_opAmpD5}
  params:add{type = "control", id = "l4_opAmpS5",name = "l4_Osc5 Sustain", controlspec = specs.OPAMP_S, action = engine.l4_opAmpS5}
  params:add{type = "control", id = "l4_opAmpR5",name = "l4_Osc5 Release", controlspec = specs.OPAMP_R, action = engine.l4_opAmpR5}
  params:add{type = "control", id = "l4_opAmpA6",name = "l4_Osc6 Attack", controlspec = specs.OPAMP_A, action = engine.l4_opAmpA6}
  params:add{type = "control", id = "l4_opAmpD6",name = "l4_Osc6 Decay", controlspec = specs.OPAMP_D, action = engine.l4_opAmpD6}
  params:add{type = "control", id = "l4_opAmpS6",name = "l4_Osc6 Sustain", controlspec = specs.OPAMP_S, action = engine.l4_opAmpS6}
  params:add{type = "control", id = "l4_opAmpR6",name = "l4_Osc6 Release", controlspec = specs.OPAMP_R, action = engine.l4_opAmpR6}
  params:bang()

end
return MT7
