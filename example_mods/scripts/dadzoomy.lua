local turn = 15
local turn2 = 5
local y = 0;
local x = 0;
local canBob = true
local Strums = 'goodStrums'
function onCreate()
    math.randomseed(os.clock() * 1000);
    
    --doTweenAlpha("gone","camHUD",0,0.01)
end
function onUpdate(elapsed)
        if mustHitSection == false then
            setProperty('defaultCamZoom',0.7)
        else
           
            setProperty('defaultCamZoom',1.2)
        end
end

--[[function onTweenCompleted(tag)
	if string.find(tag,"wheeeup") then
        for i = 0,7 do
            local uhhh = curBeat % 8 * (i + i)
            local swag = i % 4 * 2.5 - uhhh
            if i > 3 then
                x =  getPropertyFromGroup('opponentStrums', i-10, 'x');
            else
                x =  getPropertyFromGroup('playerStrums', i, 'x');
            end
            --noteTweenY("wheeeup"..i,i,y + turn,crochet*0.002,"sineInOut")
            noteTweenX("wheeeleft"..i,i,x,crochet*0.002,"sineInOut")
        end
    end
end]] 