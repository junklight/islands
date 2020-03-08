-- Soundscaper  - event looper
--
--

local soundscaper = {}
soundscaper.__index = soundscaper
local eventlooper = require 'Islands/lib/eventlooper'
 
-- sequencer modes 
-- 
local OFF_SEQMODE = 0
local PLAY_SEQMODE = 1
local REC_SEQMODE = 2
local OVERDUB_SEQMODE = 3
local seqmode = OFF_SEQMODE

function test(e) 
	print("vel testing")
	e.e.vel = e.e.vel - 0.03 
	if e.e.vel < 0.1 then
					return false 
	end
	return true
end

function soundscaper.new()
	local i = {}	
	-- need to make this so the package uses 
	-- one single metro instead of one 
	-- per sequencer
	i.blink = 1
  i.blinker = metro.init{event = function() if i.blink == 1 then i.blink = 0 else i.blink = 1 end end }
	i.pat = eventlooper.new()
	i.pat.process = function(e) e.fn(e.state,e.id,e.layer,e.hz,e.vel,e.x,e.y) end
	i.pat.test = test
	setmetatable(i,soundscaper)
	i.seqmode = OFF_SEQMODE
	i.open_notes = {}
	return i
end

function soundscaper:watch(fn,state,id,hz,vel,layer,x,y)
 	local e = {} 
	e.fn = fn
	e.state = state 
	e.id = id
	e.hz = hz
	e.vel = vel
	e.layer = layer
	e.x = x 
	e.y = y
	self.pat:watch(e)
	-- record open notes so we 
	-- can close them when we stop 
	-- recording
	if state == 1 then 
		print("open note")
		self.open_notes[id] = e
	elseif state == 0 then
		print("close note")
		self.open_notes[id] = nil
	end
end

function soundscaper:clear_on_notes()
	for k,e in pairs(self.open_notes) do 
		 local o = {}
		 o.fn = e.fn
		 o.state = 0
		 o.id = e.id
		 o.hz = e.hz
		 o.vel = e.vel
		 o.layer = e.layer
		 o.x = e.x
		 o.y = e.y
		 self.pat:watch(o)
		 print("adding close for ",e.id)
	end
	self.open_notes = {}
end




function soundscaper:event(x,y,z)
	-- we should only get events from {8-12,8} 
	-- but safe rather than sorry
	if y == 8 then 
		if x == 8 and z == 1 then 
			 if self.seqmode == PLAY_SEQMODE then 
					self.seqmode = OFF_SEQMODE
					self.pat:stop()
			 else 
					if self.seqmode == REC_SEQMODE then 
						self.blinker:stop()
						self:clear_on_notes()
				    self.pat:rec_stop()
					end
			 		self.seqmode = PLAY_SEQMODE 
					self.pat:start()
			 end
	  elseif x == 9 and z == 1 then 
			if self.seqmode == PLAY_SEQMODE or self.seqmode == OFF_SEQMODE then
			  self.seqmode = REC_SEQMODE
				self.pat:stop()
				self.pat:clear()
				self.pat:rec_start()
				self.blinker:start(0.5)
		  elseif self.seqmode == REC_SEQMODE then 
				self.seqmode = OVERDUB_SEQMODE
				self:clear_on_notes()
			  self.pat:rec_stop()
			  self.pat:start()
			  self.pat:overdub_start()
				self.blinker:start(1)
			else
				self.seqmode = OFF_SEQMODE
				self.pat:stop()
				self.blinker:stop()
			end
		end
	end
end

function soundscaper:draw_control_row(p)
	if self.seqmode == OFF_SEQMODE then 
		p:led(8,8,2)
		p:led(9,8,2)
	elseif self.seqmode == PLAY_SEQMODE then
		p:led(8,8,15)
		p:led(9,8,2)
	elseif self.seqmode == REC_SEQMODE or self.seqmode == OVERDUB_SEQMODE then 
		p:led(8,8,2)
		if self.blink == 1 then
			p:led(9,8,15)
		else
			p:led(9,8,7)
		end
	end
end

-- all sequencer plugins have 
-- a clock - soundscaper ignores it
-- (for now)

function soundscaper:clock()

end

return soundscaper
