
esea = {}
-- pythagorean minor/major, kinda
local ratios = { 1, 9/8, 6/5, 5/4, 4/3, 3/2, 27/16, 16/9 }
local base = 27.5 -- low A
local notes = {"C","C#","D","Eb","E","F","F#","G","Ab","A","Bb","B"}
-- local colours = {7,0,2,0,2,2,0,2,0,2,0,2}
local colours = {7,2,0,2,0,2,0,2,2,0,2,0}

    
function esea.getHz(deg,oct)
  return base * ratios[deg] * (2^oct)
end

function esea.getHzET(note)
  return 55*2^(note/12)
end

function esea.note_name(x,y)
  local note = ((7-y)*5) + x
	return notes[((note-3)%12)+1]
end

function esea.note_colour(x,y)
  local note = ((7-y)*5) + x
	return colours[((note-3)%12)+1]
end



return esea
