engine.name = "MT7"

z = 0


function test ()
  if z == 0  then
    z = 1
    engine.start(1,1, 60,80)
  elseif z == 1 then 
    z = 0
    engine.stop(1,1)    
  end
end 

m = metro.init( test )
m:start(2)


