local magneto = Gpio.new(Gpio.C, 3, Gpio.OUTPUT)
local led_number = 7
local leds = Ledbar.new(led_number)
local rc = Sensors.rc
local blink = 0

function callback(event) end

local function changeColor(red, green, blue)
    for i = 0, led_number - 1 do
        leds:set(i, red, green, blue)
    end
end

cargoTimer = Timer.new(0.1, function()
    _, _, _, _, _, _, _, ch7 = rc()
    
    
    if ch7 < -0.1 then       
        magneto:set()
        changeColor(1, 0, 1)  
        
    elseif ch7 > 0.1 then     
        magneto:reset()
    
        if blink % 2 == 0 then
            changeColor(1, 0, 1)
        else
            changeColor(0, 0, 0)
        end
        blink = blink + 1
        
    else                      
        magneto:reset()
        changeColor(0, 0, 0)  --
    end
end)

cargoTimer:start()
