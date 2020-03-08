local ControlSpec = require "controlspec"

local islands = {}

local specs = {}
local options = {}

-- specs.OPAMP_A1= ControlSpec.new(0.01,10,"lin",0,0.05,"ms")
--
-- options.SEQ_TYPE = {"Pattern","Soundscape","Kria"}

islands.specs = specs
islands.options = options

function islands.add_params()
  -- params:add{type = "option", id = "l1_seq_type", name = "L1 Seq Type", options = options.SEQ_TYPE, default = 1 }
  -- params:add{type = "option", id = "l2_seq_type", name = "L2 Seq Type", options = options.SEQ_TYPE, default = 1 }
  -- params:add{type = "option", id = "l3_seq_type", name = "L3 Seq Type", options = options.SEQ_TYPE, default = 1 }
  -- params:add{type = "option", id = "l4_seq_type", name = "L4 Seq Type", options = options.SEQ_TYPE, default = 1 }
  -- params:add_separator()
  params:add_separator()
  params:bang()

end
return islands
