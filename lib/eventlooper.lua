-- eventlooper - frippertronics style event looping 
-- (rather than audio) 
-- initial record sets a loop length and records 0 or more events
-- start of each loop - current events are sorted and
-- played back in time order 
-- new events recorded at the end of the loop
-- to be incorporated next time
-- class structure etc evolved from pattern_time 
-- originally 

local eventlooper = {}
eventlooper.__index = eventlooper

function eventlooper.new()
  local i = {}
  setmetatable(i, eventlooper)
  i.rec = 0
	i.overdub = 0
  i.play = 0
  i.prev_time = 0
  i.events = {}
	i.remove = {}
  i.looplength = 0
	i.currentevent = 0
	i.ids = 0
  i.metro = metro.init{event = function() i:next_event() end, time = 1}
  i.process = function(e) print("event") end
	i.test = function(e) print("testing"); return true end
	i.update = function(e) print("update"); return true end
  return i
end

function eventlooper:clear()
  self.metro:stop() 
  self.rec = 0
	self.overdub = 0
	self.starttime = 0
	self.length = 0
  self.play = 0
  self.prev_time = 0
  self.looplength = 0
	self.currentevent = 0
	self.ids = 0
  self.events = {}
	self.remove = {}
end

function eventlooper:rec_start()
	if self.looplength == 0 then 
		print("eventlooper rec start")
		self.rec = 1
		self.play = 0
		self.overdub = 0
		self.ids = 0
		self.events = {}
		self.remove = {}
		self.starttime = util.time()
	end
end

function eventlooper:overdub_start()
  print("eventlooper overdub start")
	self.overdub = 1
	self.play = 0
	self.rec = 0
end

function eventlooper:rec_event(e)
	-- so basically just want to add the 
	-- event to the end of the current event 
	-- list - it will be incorporated
	-- at loop time
	local reltime = util.time() - self.starttime
	local loopevent = { id = self.ids , e = e, timestamp = reltime , cnt = 0 , highwatermark=false}
	table.insert(self.events, loopevent)
	self.ids = self.ids + 1
end

function eventlooper:rec_stop()
  if self.rec == 1 then
	  local reltime = util.time() - self.starttime
	  local loopevent = { id = self.ids , e = {}, timestamp = reltime + 0.01 , cnt = 0 , highwatermark=true}
	  table.insert(self.events, loopevent)
		self.ids = self.ids + 1
    self.rec = 0
		self.looplength = reltime
    print("recording stopped")
	elseif self.overdub == 1 then 
		self.overdub = 0
		print("stopped overdub")
  else 
		print("not recording")
  end
end

function eventlooper:watch(e)
  if self.rec == 1 or self.overdub == 1 then
    self:rec_event(e)
  end
end

function eventlooper:start_loop()
	-- start of loop playback do two things: 
	-- 			remove any expired items 
	-- 			sort loop to integrate new stuff
	--
	-- keep a list of items to remove 
	-- and remove them at the start of
	-- the loop 
	-- because it changes the indexes each time 
	-- you remove you need to find and remove -
	--
	-- this is horrible probably need to do it 
	-- without an iterator and manually advance 
	-- indexes taking advantage of sorting
	--
	for rk,rv in pairs(self.remove) do
	  for k,v in pairs(self.events) do
			if v.id == rv then
				print("removing " .. v.id )
			  table.remove(self.events,k)
			end
		end
	end
	self.remove = {}
	-- so all the events we currently have 
	-- sort them and keep a track
	-- of the highwater mark so we don't
	-- play past it
	table.sort(self.events,function(a,b) return a.timestamp < b.timestamp end)
	self.highwatermark = #self.events
	self.currentevent = 1
end

function eventlooper:start()
 print("start loop ")
 self:start_loop()
 self.play = 1
 self.starttime = util.time()
 self.prev_time = self.events[1].timestamp
 self.metro.time = self.events[1].timestamp
 self.metro:start() 
end 

function eventlooper:next_event()
	if self.events[self.currentevent].highwatermark then 
			-- when we get to the highwatermark 
			-- fake event then start again
			self:start()
	else
	  self.process(self.events[self.currentevent].e)
		-- see if that event has lived its life span
		self.events[self.currentevent].cnt = self.events[self.currentevent].cnt + 1
		-- just hardwire this for now - will be parameter
		-- self.events[self.currentevent] = self.update(self.events[self.currentevent])
		if self.test(self.events[self.currentevent]) ~= true then
			print("planning to remove " .. self.events[self.currentevent].id)
			table.insert(self.remove,self.events[self.currentevent].id)
		end
		-- and on to the next event
		self.currentevent = self.currentevent + 1
		self.metro.time = self.events[self.currentevent].timestamp - self.prev_time
		if self.events[self.currentevent].highwatermark then
			self.metro.time = self.events[self.currentevent].timestamp - self.prev_time - 0.01
		end
		self.prev_time = self.events[self.currentevent].timestamp
		self.metro:start() 
	end
end

function eventlooper:stop()
  self:rec_stop()
  self.play = 0
  self.metro:stop()
end

return eventlooper
