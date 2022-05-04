function onCreatePost()
	CamOffsetBF_X = 50
	CamOffsetDad_X = 450
	
	CamOffsetBF_Y = 50
	CamOffsetDad_Y = 300
	
	--the camera points for each char
	CamPointBF_X = getProperty('boyfriend.x')+CamOffsetBF_X
	CamPointBF_Y = getProperty('boyfriend.y')+CamOffsetBF_Y
	
	CamPointDad_X = getProperty('dad.x')+CamOffsetDad_X
	CamPointDad_Y = getProperty('dad.y')+CamOffsetDad_Y
end

local MoveCamBF=50
PlayerNoteFuncs = { --IM DRUNK WOOOOOOOOOO
	[1] = function() --left note
		triggerEvent('Camera Follow Pos', CamPointBF_X-MoveCamBF, CamPointBF_Y)
	end,
	[2]=function() --down note
		triggerEvent('Camera Follow Pos', CamPointBF_X, CamPointBF_Y+MoveCamBF)
	end,
	[3]=function() --up note
		triggerEvent('Camera Follow Pos', CamPointBF_X, CamPointBF_Y-MoveCamBF)
	end,
	[4]=function()--right note
		triggerEvent('Camera Follow Pos', CamPointBF_X+MoveCamBF, CamPointBF_Y)
	end
}

local MoveCamDad=50
EnemyNoteFuncs = { --IM DRUNK WOOOOOOOOOO
	[1] = function() --left note
		triggerEvent('Camera Follow Pos', CamPointDad_X-MoveCamDad, CamPointDad_Y)
	end,
	[2]=function() --down note
		triggerEvent('Camera Follow Pos', CamPointDad_X, CamPointDad_Y+MoveCamDad)
	end,
	[3]=function() --up note
		triggerEvent('Camera Follow Pos', CamPointDad_X, CamPointDad_Y-MoveCamDad)
	end,
	[4]=function()--right note
		triggerEvent('Camera Follow Pos', CamPointDad_X+MoveCamDad, CamPointDad_Y)
	end
}

function goodNoteHit(id, direction, noteType, isSustainNote)
    if PlayerNoteFuncs[direction+1] and mustHitSection == true then 
        PlayerNoteFuncs[direction+1]() -- Executes function at curStep in stepHitFuncs
    end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
    if EnemyNoteFuncs[direction+1] and mustHitSection == false then 
        EnemyNoteFuncs[direction+1]() -- Executes function at curStep in stepHitFuncs
    end
end

function onBeatHit()
	if curBeat%2==0 then
		if mustHitSection == false and getProperty('dad.animation.curAnim.name') == 'idle' then
			triggerEvent('Camera Follow Pos', '', '')
		elseif mustHitSection == true and getProperty('boyfriend.animation.curAnim.name') == 'idle' then
			triggerEvent('Camera Follow Pos', '', '')
		end
	end
end