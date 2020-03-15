-- Islands
-- based on earthsea + FM7 + kria + softcut
--
-- 4 layer instrument
-- using grid 
-- (also responds to midi for note playing) 
--
-- Button 2 - edit sound mode 
-- Button 3 - sequencer detail page
-- Button 2 + 3 - settings 
--
local islandsparams = require 'Islands/lib/islandsparams'
local MusicUtil = require "musicutil"
local MT = require 'Islands/lib/mt7'
local UI = require "ui"
local esea = require 'Islands/lib/esea'
local tab = require 'tabutil'
local util = require 'util'
engine.name = "MT7"
local g = grid.connect()

local kria = require 'Islands/lib/kria'

local options = {}
options.STEP_LENGTH_NAMES = {"1 bar", "1/2", "1/3", "1/4", "1/6", "1/8", "1/12", "1/16", "1/24", "1/32", "1/48", "1/64"}
options.STEP_LENGTH_DIVIDERS = {1, 2, 3, 4, 6, 8, 12, 16, 24, 32, 48, 64}

local BeatClock = require 'Islands/lib/beattest'
local clk = BeatClock.new()

local root = { x=5, y=5 }
local lit = {}
lit[1] = {}
lit[2] = {}
lit[3] = {}
lit[4] = {}
local screen_notes = { -1 , -1 , -1 , -1 }
local current_layer = 1

local note_list = {}

local loct = {} 
loct[1] = 1
loct[2] = 1
loct[3] = 1
loct[4] = 1

local screen_framerate = 15
local screen_refresh_metro
local MAX_NUM_VOICES = 16
-- trying to make the various modes a bit 
-- mode readable using constants 
--
-- ok some constants for modes 
local PLAY_MODE = 0
local EDIT_MODE = 1
local SEQ_MODE = 2
local SETTINGS_MODE = 3
-- modes as above ^^
local mode = PLAY_MODE

-- edit modes 
local OFF_EMODE = 0
local CARRIER_EMODE = 1
local MATRIX_EMODE = 2
local AMP_EMODE = 3
local FREQ_EMODE = 4
local A_EMODE = 5
local D_EMODE = 6
local S_EMODE = 7
local R_EMODE = 8
local PA_EMODE = 9
local PD_EMODE = 10
local PS_EMODE = 11
local PR_EMODE = 12
-- edit modes as above 
local emode = OFF_EMODE
local eop = 0
local modop = 0
local enote = 0

-- settings mode 
local OFF_SMODE = 0
local L1SEQ_SMODE = 1
local L2SEQ_SMODE = 2
local L3SEQ_SMODE = 3
local L4SEQ_SMODE = 4
-- settings mode variable
local smode = OFF_SMODE
-- preset mode 
local OFF_PSETMODE = 0
local READ_PSETMODE = 1
local WRITE_PSETMODE = 2
local pset_mode = OFF_PSETMODE 
local pmode_num = "-"

local buttons_down = {}

-- SOFTCUT 
local loopone = 0
local looponeedit = 0
local looptwo = 0
local looptwoedit = 0
local looplenspec = controlspec.new(.25, 60, "exp", .01, 2, "secs")
local loopdecspec = controlspec.new(0.0, 1.0, "lin", .01, 0.78, "")

local vel = 1.0

-- current count of active voices
local nvoices = 0
-- kria
--
local k
local note_off_list = {}
local ids = 10000
local clock_count = 1
local clocked = true
local preset_mode = false
local root_note = 60
local screen_notes = { -1 , -1 , -1 , -1 }
local playback_icon = UI.PlaybackIcon.new(121, 55)
playback_icon.status = 1

-- presets are slightly interesting 
-- there are 4 sets of identical params 
-- when set is saved a single set is put in the file 
-- AND can be loaded into a different set 
-- so new functions that save based on parameter prefix 
-- and load based on name matching to the given set 
-- these functions take advantage of the fact nothing is private in Lua 
-- objects - of which be thankful because it prevents the
-- need for other more evil coding techniques 
--
-- presets are stored in a set of numbered files  1..30 

local function quote(s)
  return '"'..s:gsub('"', '\\"')..'"'
end

local function unquote(s)
  return s:gsub('^"', ''):gsub('"$', ''):gsub('\\"', '"')
end

function write_preset(prefix,n) 
  -- write file
  local filename = n .. ".mt7preset"
  local fd = io.open(_path.data .. "Islands/"..filename, "w+")
  io.output(fd)
  for k,param in pairs(params.params) do
    if param.id and param.t ~= params.tTRIGGER then
       if string.find(param.id,prefix) == 1 then 
         local pname = string.sub(param.id,4)
         io.write(string.format("%s: %s\n", quote(pname), param:get()))
      end
    end
  end
  io.close(fd)
end

function read_preset(prefix,n)
  local parampat = "\"([%s%w%p]-)\"%s*:%s*([%d%p]+)%s*"
  local filename = n .. ".mt7preset"
  local fpath = _path.data .. "Islands/"..filename
  if util.file_exists(fpath) then
    local fd = io.open(fpath, "r")
    for pid, n in string.gmatch(fd:read("*all"),parampat ) do
      pid = prefix .. pid
      print(pid .. " -> " .. tonumber(n) )
      local index = params:set(pid, tonumber(n))
    end
    fd:close()
  end
end




function make_note(track,n,oct,dur,tmul,rpt,glide)
		local nte = k:scale_note(n)
		-- print("[" .. track  .. "] Note " .. nte .. "/" .. oct .. " for " .. dur .. " repeats " .. rpt .. " glide " .. glide  )
		-- ignore repeats and glide for now
		-- currently 1 == C3 (60 = 59 + 1)
		local r = rpt + 1
		local notedur = 6  * (dur/r * tmul)
		for rptnum = 1,r do
		  midi_note = nte + ( (oct - 3) * 12 ) + root_note
		  -- m:note_on(midi_note,100,midich)
		  table.insert(note_list,{ action = 1 , track = track , timestamp = clock_count + ( (rptnum - 1) * notedur), channel = midich , note = midi_note })
		  table.insert(note_list,{ action = 0 , track = track , timestamp = (clock_count + (rptnum * notedur)) - 0.1, channel = midich , note = midi_note })
		end
end

function step()
	clock_count = clock_count + 1
	table.sort(note_list,function(a,b) return a.timestamp < b.timestamp end)
	while note_list[1] ~= nil and note_list[1].timestamp <= clock_count do
		if note_list[1].action == 1 then 
		  local hz = MusicUtil.note_num_to_freq(note_list[1].note)
		  local vel = 0.8
		  makenote(1,note_list[1].note,note_list[1].track,hz,vel,0,0,nil)
		  screen_notes[note_list[1].track + 1] = note_list[1].note
		else 
		  local hz = MusicUtil.note_num_to_freq(note_list[1].note)
		  local vel = 0.8
		  makenote(0,note_list[1].note,note_list[1].track,hz,vel,0,0,nil)
		  screen_notes[note_list[1].track + 1] = -1
		end
		table.remove(note_list,1)
	end
	k:clock()
end

function init_sc_buffer(n)
  softcut.level_input_cut(1, n, 0.5)
  softcut.level_input_cut(2, n, 0.5)
  softcut.enable(n, 1)
  softcut.level(n, 1)
  softcut.buffer(n, n)

  softcut.rate(n, 3)
  softcut.play(n, 1)

  softcut.position(n, 1)
  softcut.fade_time(n, 0.25)

  softcut.loop(n, 1)
  softcut.loop_start(n, 0)
  softcut.loop_end(n, 60)

  softcut.rec(n, 1)
  softcut.rec_offset(n, -0.06)
  softcut.rec_level(n, 0)
  softcut.pre_level(n, .75)

  softcut.rate_slew_time(n, 0)
  softcut.level_slew_time(n, 0.25)
end
  
local function nsync(x)
	if x == 2 then
		k.note_sync = true
	else
		k.note_sync = false
	end
end

local function lsync(x)
	if x == 1 then
		k.loop_sync = 0
  elseif x == 2 then
		k.loop_sync = 1
  else
		k.loop_sync = 2
	end
end

function init()
  softcut.reset()
  softcut.buffer_clear()
  k = kria.loadornew("Islands/kria.data")
  k:init(make_note)
  clk:add_clock_params()
	params:add{type = "option", id = "step_length", name = "step length", options = options.STEP_LENGTH_NAMES, default = 6,
  action = function(value)
    clk.ticks_per_step = ( 96 / (options.STEP_LENGTH_DIVIDERS[value])  ) 
    clk.steps_per_beat = ( options.STEP_LENGTH_DIVIDERS[value] ) 
    -- clk.ticks_per_step = 24
    -- clk.steps_per_beat = 4
    clk:bpm_change(clk.bpm)
    print("clock " .. clk.ticks_per_step .. " steps " .. clk.steps_per_beat)
  end}
	clk.on_step = step
  clk.on_start = function() k:reset() end
  clk.beats_per_bar = 4
  clk.on_select_internal = function() clk:start() end
  clk.on_select_external = function() print("external") end
  
	params:add_separator()
	params:add{type="option",name="Note Sync",id="note_sync",options={"Off","On"},default=1, action=nsync}
	params:add{type="option",name="Loop Sync",id="loop_sync",options={"None","Track","All"},default=1, action=lsync}
	params:add_separator()
	params:add{type="control", name="loop length 1",id="loop_length_1", 
	  controlspec=looplenspec , 
	  action=function(x) softcut.loop_end(1, x) end  }
	params:add{type="control", name="loop decay 1",id="loop_decay_1", 
	  controlspec = loopdecspec,
	  action=function(x) softcut.pre_level(1, x) end  }
	params:add{type="control", name="loop length 2",id="loop_length_2", 
	  controlspec=looplenspec , 
	  action=function(x) softcut.loop_end(2, x) end  }
	params:add{type="control", name="loop decay 2",id="loop_decay_2", 
	  controlspec = loopdecspec,
	  action=function(x) softcut.pre_level(2, x) end  }
	islandsparams.add_params()
  MT.add_params()
  
  init_sc_buffer(1)
  init_sc_buffer(2)
  audio.level_eng_cut(1)



  -- clk.on_select_external = reset_pattern
	params:add_separator()
	params:add_number("clock_ticks", "clock ticks", 1, 96,1)
  params:bang()
  -- grid refresh timer, 15 fps
  metro_grid_redraw = metro.init{ event = function(stage) gridredraw() end, time = 1 / 15 }
  metro_grid_redraw:start()
  if g.device then gridredraw() end
  screen_refresh_metro = metro.init{ 
  event = function(stage)
		gridredraw()
    redraw()
  end ,
  time = 1 / screen_framerate }
  screen_refresh_metro:start()
end



function g.key(x, y, z)
  -- print("key",x,y,z)
	if mode == SEQ_MODE then 
	    k:event(x,y,z)
			gridredraw()
			return
	end
  if y ==8  then
		if mode == PLAY_MODE then
			if x >= 7 and x<= 10 then 
			  -- softcut loops 
			  if x == 7 and  z == 1 then 
				  looponeedit = 1
			  elseif x == 7 and  z == 0 then 
				  looponeedit = 0
				elseif x == 8 and  z == 1 then 
				  if loopone == 0 then 
				    loopone = 1
				    softcut.rec_level(1, 0.8)
				  else
				    loopone = 0
				    softcut.rec_level(1, 0)
				  end
				elseif x == 9 and  z == 1 then 
				  if looptwo == 0 then 
				    looptwo = 1
				    softcut.rec_level(2, 0.8)
				  else
				    looptwo = 0
				    softcut.rec_level(2, 0)
				  end
				elseif x == 10 and  z == 1 then 
				  looptwoedit = 1
			  elseif x == 10 and  z == 0 then 
				  looptwoedit = 0
				end
			else
				control_row_play(x,y,z)
			end
		elseif mode == EDIT_MODE then
			-- make an edit control row in a bit
			control_row_play(x,y,z)
			
		end
  else
		-- play or edit func
		if mode == PLAY_MODE then
			play_notes(x,y,z)
		elseif mode == EDIT_MODE then 
			edit_sound(x,y,z)
		elseif mode == SETTINGS_MODE then
			-- settings_event(x,y,z)
		end
  end
  gridredraw()
end

function gridredraw()
  g:all(0)
	-- display current layer - common to everything
  g:led(current_layer,8,10)
	if mode == PLAY_MODE then 
		draw_playnotes()
		draw_control_row_play()
	elseif mode == EDIT_MODE then 
		draw_soundedit()
		draw_control_row_edit()
	elseif mode == SEQ_MODE then 
		-- not made yet
		if preset_mode then 
			k:draw_presets(g)
		else 
			k:draw(g)
		end
	elseif mode == SETTINGS_MODE then 
	  draw_settings()
	end
  g:refresh()
end

function enc(n,delta)
  if n == 1 then
    mix:delta("output", delta)
  end
  if looponeedit == 1 or looptwoedit == 1 then 
    if looponeedit == 1 then
      if n == 2 then
        params:delta("loop_length_1", delta)
      elseif n == 3 then 
        params:delta("loop_decay_1", delta)
      end
    elseif looptwoedit == 1 then 
      if n == 2 then
        params:delta("loop_length_2", delta)
      elseif n == 3 then 
        params:delta("loop_decay_2", delta)
      end
    end 
    return
  elseif pset_mode ~= OFF_PSETMODE then 
    if n == 2 then
      if delta == 1 then 
         if pmode_num == "-" then
           pmode_num = 0
          elseif pmode_num < 30 then
            pmode_num = pmode_num + 1
          end
      elseif delta == -1 then 
          if pmode_num > 0 then
           pmode_num = pmode_num - 1
          elseif pmode_num <= 0  then
            pmode_num = "-"
          end
      end
    end
    return
	elseif mode == PLAY_MODE then 
		if n == 2 then 
				vel = vel + (delta/200)
				if vel < 0 then 
					vel = 0.0
				elseif vel > 1 then 
					vel = 1.0
				end
	  end
	elseif mode == EDIT_MODE then 
		edit_enc(n,delta)
	elseif mode == SETTINGS_MODE then
		settings_enc(n,delta)
	elseif mode == SEQ_MODE then 
	  kria_enc(n,delta)
	end 
end

function key(n,z)
  -- print("button",n,z)
	-- using the keys to switch between modes 
	-- 2    play <--> edit 
	-- 3    play <--> seq 
	-- 2 + 3   - settings mode 
	if z == 1 then 
		buttons_down[n] = true
	else
		buttons_down[n] = false
	end
	if n == 2 and z == 1 then 
		if mode == PLAY_MODE then
			 mode = EDIT_MODE 
		elseif mode == SEQ_MODE then 
			 mode = EDIT_MODE
		elseif mode == EDIT_MODE then 
			 mode = PLAY_MODE 
		elseif mode == SETTINGS_MODE then
			 mode = PLAY_MODE
		end
	elseif n ==3 and z == 1 then
		if mode == PLAY_MODE then
			 mode = SEQ_MODE 
		elseif mode == EDIT_MODE then 
			 mode = SEQ_MODE
		elseif mode == SEQ_MODE then 
			 mode = PLAY_MODE
		elseif mode == SETTINGS_MODE then
			 mode = SEQ_MODE
		end
	end
	if z == 1 then
	  if (n == 2 and buttons_down[3] == true ) or (n==3 and buttons_down[2] == true ) then 
			mode = SETTINGS_MODE
		end
	end
end

function draw_preset()
  local pmode = "unknown"
  if pset_mode == WRITE_PSETMODE then 
    pmode = "write"
  elseif pset_mode == READ_PSETMODE then
    pmode = "read"
  end
  screen.move(15,30)
	screen.text(pmode .. " - " .. pmode_num) 
  
end


function redraw()
  screen.clear()
  screen.aa(0)
  screen.line_width(1)
	-- the loop edit modes are temporary (holding a key down)
	-- and take over everything else 
	-- at somepoint maybe will get to refactor this into a 
	-- framework but just going with how it is for the moment
	-- thought: do we want to do a popup for these  
	-- like the nc01 drone controls ?? 
	if looponeedit == 1 or looptwoedit == 1 then 
	  if looponeedit == 1 then 
	    screen.move(44,25)
	    screen.text("Loop One")
	    screen.move(15,40)
	    screen.text("length: " .. params:get("loop_length_1") .. " decay: " .. params:get("loop_decay_1") )
	  else 
	    screen.move(44,25)
	    screen.text("Loop Two")
	    screen.move(15,40)
	    screen.text("length: " .. params:get("loop_length_2") .. " decay: " .. params:get("loop_decay_2") )
	  end
	else
	-- top line is mode line and common to all modes 
	-- except settings
	  if mode ~= SETTINGS_MODE then
	  	local layn = "Layer: " 
  		screen.move(0,10)
  		screen.text(layn .. current_layer)
  	end
  	screen.move(100,10)
  	if mode == PLAY_MODE then 
  		screen.text("play")
  		if pset_mode ~= OFF_PSETMODE then
  	    draw_preset()
  	   else
  		  screen_playnotes()
  		end
  	elseif mode == EDIT_MODE then
  		screen.text("edit")
  		if pset_mode ~= OFF_PSETMODE then
  	    draw_preset()
  	   else
  		  screen_editsound()
  		end
  	elseif mode == SEQ_MODE then 
  		screen_kria()
  	elseif mode == SETTINGS_MODE then 
  	  screen.move(90,10)
  		screen.text("settings")
  		screen_settings()
  	end
  end
  screen.update()
end



function cleanup()
end

function control_row_play(x,y,z) 
	if x >=1 and x <=4 then
		-- switch layer 
		-- if notes pressed - can't change layer
		-- for k,v in pairs(lit[current_layer]) do
		--	print("lit notes")
		--	return
		-- end
		current_layer = x
	elseif x == 13 and z == 1 then 
	  -- read preset 
	  pset_mode = READ_PSETMODE
	elseif x == 14 and z == 1 then
	  -- write preset 
	  pset_mode = WRITE_PSETMODE
	elseif (x == 13 or x ==14 ) and z == 0 then 
	  -- do preset action 
    if pset_mode == WRITE_PSETMODE then 
      if pmode_num ~= "-" then 
        print("write preset " .. pmode_num)
        write_preset("l" .. current_layer .. "_",pmode_num)
      end
    elseif pset_mode == READ_PSETMODE then
      print("read preset " .. pmode_num)
      read_preset("l" .. current_layer .. "_",pmode_num)
    end
	  pmode_num = "-"
	  pset_mode = OFF_PSETMODE
	elseif x == 5 then
		engine.stopAll()
	elseif x == 15 and z == 1 then

	  loct[current_layer] = loct[current_layer] / 2.0
	  if loct[current_layer] < 0.25 then 
	    loct[current_layer] = 0.25
	  end
	  print("oct down ".. loct[current_layer])
	elseif x == 16 and z == 1then
	  loct[current_layer] = loct[current_layer] * 2.0
	  if loct[current_layer] > 4.0 then 
	    loct[current_layer] = 4.0
	  end
	  print("oct up ".. loct[current_layer])
	end
end

function draw_control_row_play() 
  g:led(7,8,2)
	if loopone == 1 then 
	  g:led(8,8,13)
	else
	  g:led(8,8,0)
	end
	if looptwo == 1 then 
	  g:led(9,8,13)
	else
	  g:led(9,8,0)
	end 
	g:led(10,8,2)
	
	
	g:led(13,8,3)
	g:led(14,8,3)
	

	
	if loct[current_layer] < 1 then 
    if loct[current_layer] == 0.5 then 
      lvl = 5
    else
      lvl = 10
    end
    g:led(15,8,lvl)
    g:led(16,8,0)
	elseif loct[current_layer] > 1.0 then
    g:led(15,8,0)
    if loct[current_layer] == 2.0 then 
      lvl = 5
    else
      lvl = 10
    end
    g:led(16,8,lvl )
	else 
	  g:led(15,8,0)
	  g:led(16,8,0)
	end

end

--------------------------------------------------------------
----  Play Notes  Mode 
--------------------------------------------------------------
--

function screen_playnotes()
	local i = 2
	local cnt = 0
	local ln = "Notes:"
	for k,v in pairs(lit[current_layer]) do
	  if v.x ~= 0 and v.y ~= 0 then 
  		ln = ln .." " .. esea.note_name(v.x,v.y) 
  		cnt = cnt + 1
  		if cnt == 7 then 
  				screen.move(0,10*i)
  				screen.text(ln)
  				cnt = 0
  				i = i + 1
  				ln = "     "
  		end
		end
  end
  screen.move(0,10*i)
  screen.text(ln)
  for idx = 1,4 do 
      screen.move(15 + (idx - 1 ) * 27,33)
      if screen_notes[idx] > 0 then
       screen.text(MusicUtil.note_num_to_name(screen_notes[idx] , true))
      end
    end
	screen.move(0,10*5)
	screen.text("Velocity " .. vel)
end

function draw_playnotes()
  local scale = {} 
  local s = 0
  local note = 0
  for idx = 1,7 do
    s = k:scale_note(idx)
    -- print(idx,s)
    scale[s] = 1
  end
	for x = 1,16 do
		for y = 1,7 do
		   note = ( ((7-y)*5) + x ) - 3
		   -- g:led(x,y,note % 12)
		   if scale[note % 12] ~= nil then 
		     if note % 12 == root_note % 12  then
			      g:led(x,y,7)
	       else 
	         g:led(x,y,2)
	       end
			 else 
			   g:led(x,y,0)
			 end
		end
	end
  for i,e in pairs(lit[current_layer]) do
		if e ~= nil then
   	   g:led(e.x, e.y,15)
	  end
  end
end

function play_notes(x,y,z)
  local e = {}
  e.id = x*8 + y
  e.x = x
  e.y = y
  e.state = z
  grid_note(e,current_layer)
end

function makenote(state,id,layer,hz,vel,x,y,n) 
	if state == 1 then 
	-- print("engine start " .. layer .. " " .. id .. " " .. hz .. " " .. vel )
    engine.start(layer,id, hz,vel)
    lit[current_layer][id] = {}
    lit[current_layer][id].x = x
    lit[current_layer][id].y = y
	else
	 
	 lit[current_layer][id] = nil
   engine.stop(layer,id)
	end
end

function grid_note(e,layer)
  local note = ((7-e.y)*5) + e.x
  -- print('grid note',note)
	local hz = esea.getHzET(note) 
	if layer == nil then
		 layer = current_layer
	end
	-- local grid octave adjustment 
	hz = hz * loct[layer]
  if e.state > 0 then
    if nvoices < MAX_NUM_VOICES then
      makenote(1,e.id,layer,hz,vel,e.x,e.y,nil) 
      nvoices = nvoices + 1
    end
  else
    if lit[current_layer][e.id] ~= nil then
      makenote(0,e.id,layer,hz,vel,e.x,e.y,nil)
     	lit[current_layer][e.id] = nil
      nvoices = nvoices - 1
    end
  end
  gridredraw()
end


--------------------------------------------------------------
----  Sound Edit Mode 
--------------------------------------------------------------
--

local edit_display = {
	[OFF_EMODE] = function()
			return "Press parameter to edit"
	end,
	[CARRIER_EMODE] = function()
			local r = params:get("l" .. current_layer .. "_carrier" .. eop) 
			return "Carrier " .. eop .. " out: " .. r .. " dbs"
	end,
	[MATRIX_EMODE] = function()
			local r = params:get("l" .. current_layer .. "_hz"..(eop).."_to_hz"..modop) 
			return eop .. " --> " .. modop .. ": " .. string.format("%.2f",r) 
	end,
	[FREQ_EMODE] = function()
			local r = params:get("l" .. current_layer .. "_hz" .. eop) 
			local p = params:get("l" .. current_layer .. "_phase" .. eop) 
			return "Freq " .. eop .. " "  .. string.format("%.2f",r) .. " (" .. string.format("%.2f",p) .. ")"
	end,
	[AMP_EMODE] = function()
			local r = params:get("l" .. current_layer .. "_amp" .. eop) 
			local v = params:get("l" .. current_layer .. "_vels" .. eop) 
			return "Amp " .. eop .. " " .. r .. " (" .. v .. ")"
	end,
	[A_EMODE] = function()
			local r = params:get("l" .. current_layer .. "_opAmpA" .. eop ) 
			return "Attack " .. eop .. ": " .. r 
	end,
	[D_EMODE] = function()
			local r = params:get("l" .. current_layer .. "_opAmpD" .. eop ) 
			return "Decay " .. eop .. ": " .. r 
	end,
	[S_EMODE] = function()
			local r = params:get("l" .. current_layer .. "_opAmpS" .. eop )
			return "Sustain " .. eop .. ": " .. r 
	end,
	[R_EMODE] = function()
			local r = params:get("l" .. current_layer .. "_opAmpR" .. eop ) 
			return "Release " .. eop .. ": " .. r 
	end,
  default = function()
		  return "unknown"
	end,
}

function screen_editsound()
	-- if not in an EMODE do we want 
	-- to display some help ? 
	--
	-- display parameters to edit 
	screen.move(15,30)
	screen.text(edit_display[emode]())
end

function edit_sound(x,y,z)

	if x == 1 and y <= 6 and z == 1 then 
			emode = CARRIER_EMODE
			eop = y
	elseif x == 1 and y <= 6 and z == 0 then 
			-- emode = OFF_EMODE
			-- eop = 0
	end
	if x >= 3 and x <= 8 and y >= 1 and y <= 6 and z == 1 then 
			emode = MATRIX_EMODE
			eop = x - 2
			modop = y
	elseif x >= 3 and x <= 8 and y >= 1 and y <= 6 and z == 0  then 
			-- emode = OFF_EMODE
	end
	if z == 1 then 
			if x == 10 then 
				emode = FREQ_EMODE
				eop = y
			elseif x == 11 then 
				emode = AMP_EMODE
				eop = y
			elseif x == 13 then 
				emode = A_EMODE
				eop = y
			elseif x == 14 then 
				emode = D_EMODE
				eop = y
			elseif x == 15 then 
				emode = S_EMODE
				eop = y
			elseif x == 16 then 
				emode = R_EMODE
				eop = y
			end
	elseif z == 0 and x >= 10 and x <= 16 then 
			-- experimentaly - don't turn off 
			-- param edit on key lift 
			-- just leave us in that mode
			-- emode = OFF_EMODE
			-- eop = 0
	end
	if x == 2 and y == 7 and z == 1 then
      engine.start(current_layer,16, esea.getHzET(math.random(15) + math.random(15) + 30 ),0.7)
			enote = 1
	elseif x == 2 and y == 7 and z == 0 then
			engine.stop(current_layer,16)
			enote = 0
	end
	
end

function edit_enc(n,delta)
	if n == 2 then 
		if emode == CARRIER_EMODE then
			-- carriers 
			params:delta("l" .. current_layer .. "_carrier" .. eop,delta)
		elseif emode == MATRIX_EMODE then 
			params:delta("l" .. current_layer .. "_hz"..eop.."_to_hz"..modop,delta) 
		elseif emode == FREQ_EMODE then 
			params:delta("l" .. current_layer .. "_hz"..eop,delta) 
		elseif emode == AMP_EMODE then 
			params:delta("l" .. current_layer .. "_amp"..eop,delta) 
		elseif emode == A_EMODE then 
			params:delta("l" .. current_layer .. "_opAmpA".. eop ,delta) 
		elseif emode == D_EMODE then 
			params:delta("l" .. current_layer .. "_opAmpD".. eop ,delta) 
		elseif emode == S_EMODE then 
			params:delta("l" .. current_layer .. "_opAmpS".. eop ,delta) 
		elseif emode == R_EMODE then 
			params:delta("l" .. current_layer .. "_opAmpR".. eop ,delta) 
		end
	end
	if n == 3 and emode == FREQ_EMODE then 
	  params:delta("l" .. current_layer .. "_phase"..(eop),delta) 
	elseif n == 3 and emode == AMP_EMODE then 
	  params:delta("l" .. current_layer .. "_vels"..(eop),delta) 
	end
end

function draw_soundedit()
	local v,r
	if enote == 1 then
		g:led(2,7,15)
	end
	for j = 1,6 do 
			r = params:get("l" .. current_layer .. "_carrier" .. j) 
      v = (r*15.0) 
			g:led(1,j,math.floor(v))
	end
	for i = 3,8 do
		for j = 1,6 do 
			r = params:get("l" .. current_layer .. "_hz"..(i-2).."_to_hz"..j) 
      v = ((r/6.3)*13) + 2
			g:led(i,j,math.floor(v))
		end
	end
	-- frequency 
	for j = 1,6 do 
			r = params:get("l" .. current_layer .. "_hz"..j) 
			v = ((r/5)*13)+2
	    g:led(10,j,math.floor(v))
	end
	-- amplitude
	for j = 1,6 do 
			r = params:get("l" .. current_layer .. "_amp"..j) 
			v = ((r/5)*13)+2
	    g:led(11,j,math.floor(v))
	  g:led(11,j,2)
	end
	-- env a 
	for j = 1,6 do 
			r = params:get("l" .. current_layer .. "_opAmpA".. j ) 
			v = ((r/5)*13)+2
	    g:led(13,j,math.floor(v))
	end
	-- env d 
	for j = 1,6 do 
			r = params:get("l" .. current_layer .. "_opAmpD".. j ) 
			v = ((r/5)*13)+2
	    g:led(14,j,math.floor(v))
	end
	-- env s
	for j = 1,6 do 
			r = params:get("l" .. current_layer .. "_opAmpS".. j ) 
			v = ((r/5)*13)+2
	    g:led(15,j,math.floor(v))
	end
	-- env r
	for j = 1,6 do 
			r = params:get("l" .. current_layer .. "_opAmpR".. j ) 
			v = ((r/5)*13)+2
	    g:led(16,j,math.floor(v))
	end
	--for i = 13,16 do
	--	for j = 1,6 do 
	--		g:led(i,j,2)
	--	end
	--end
end

function draw_control_row_edit() 

end

--------------------------------------------------------------
----  Settings Mode 
--------------------------------------------------------------


local settings_display = {
}

function draw_settings() 
	local v,r
	--for j = 1,4 do 
	--		r = params:get("l" .. j .. "_seq_type") 
  --    v = ((r/3.0)*15.0) 
	--		g:led(2,j+1,math.floor(v))
	-- end
end

function screen_settings()
	screen.move(15,30)
	screen.text("unused")
end

function settings_enc(n,delta)
end

function settings_event(x,y,z)
end

--------------------------------------------------------------
----  Kria Mode 
--------------------------------------------------------------

function screen_kria() 
  screen.clear()

  if k.mode == kria.mScale then   
    screen.move(10,20)
    screen.text("Root: " .. MusicUtil.note_num_to_name(root_note,true))
    screen.font_size(8)
    screen.font_face(1)
    for idx = 1,7 do
      screen.move(15 + (idx - 1 ) * 16,40)
      local n =  k:scale_note(idx)  +  root_note 
      screen.text(MusicUtil.note_num_to_name(n))
    end
  else
    screen.move(10,20)
    screen.text("Root: " .. MusicUtil.note_num_to_name(root_note,true))
    screen.move(70,20)
    if clk.external then 
      screen.text("BPM: ext")
    else 
      screen.text("BPM: " .. params:get("bpm"))
    end
    for idx = 1,4 do 
      screen.move(15 + (idx - 1 ) * 27,40)
      if screen_notes[idx] > 0 then
       screen.text(MusicUtil.note_num_to_name(screen_notes[idx] , true))
      end
    end
    playback_icon:redraw()
  end
  screen.update()
end

function kria_enc(n,delta)
  if n == 2 then 
    root_note = util.clamp(root_note + delta, 24, 72)
    -- print(root_note)
  elseif n == 3 then       
    params:delta("bpm",delta)
  end
end


