local anims = {'singLEFT', 'singDOWN', 'singUP', 'singRIGHT'}

function noteMissPress(direction)
   characterPlayAnim('boyfriend', anims[direction + 1], true)
   setProperty('boyfriend.color', getColorFromHex('000084'));
end

function noteMiss(id, direction, noteType, isSustainNote)
   characterPlayAnim('boyfriend', anims[direction + 1], true)
   setProperty('boyfriend.color', getColorFromHex('000084'));
end

function goodNoteHit(id, direction, noteType, isSustainNote)
   setProperty('boyfriend.color', 16777215);
end

function onUpdate()
   if getProperty('boyfriend.animation.curAnim.name') == 'idle' or getProperty('boyfriend.animation.curAnim.name') == 'danceLeft' or getProperty('boyfriend.animation.curAnim.name') == 'danceRight' then
   setProperty('boyfriend.color', 16777215);
   end
end