function onBeatHit()

-- script by https://github.com/kingyomoma

setProperty('iconP1.scale.x', 1.3)

doTweenX('iconP1', 'iconP1.scale', 1, 0.2, 'easeOut')

setProperty('iconP1.angle', 15)

doTweenAngle('iconP1', 'iconP1', 0, 0.2, 'easeOut')

setProperty('iconP2.scale.x', 0.75)

doTweenX('iconP2', 'iconP2.scale', 1, 0.2, 'easeOut')

setProperty('iconP2.angle', -15)

doTweenAngle('iconP2', 'iconP2', 0, 0.2, 'easeOut')

if curBeat % 2 == 0 then

setProperty('iconP2.scale.x', 1.3)

doTweenX('iconP2', 'iconP2.scale', 1, 0.2, 'easeOut')

setProperty('iconP2.angle', 15)

doTweenAngle('iconP2', 'iconP2', 0, 0.2, 'easeOut')

setProperty('iconP1.scale.x', 0.75)

doTweenX('iconP1', 'iconP1.scale', 1, 0.2, 'easeOut')

setProperty('iconP1.angle', -15)

doTweenAngle('iconP1', 'iconP1', 0, 0.2, 'easeOut')

end
end