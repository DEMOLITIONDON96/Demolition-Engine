function onUpdate(elapsed)
    if curStep >= 1 and curStep < 20 then
    noteTweenY('left0', 0, 200, 1, 'linear');
    noteTweenY('left1', 1, -100, 1, 'linear');
    noteTweenY('left2', 2, 300, 1, 'linear');
    noteTweenY('left3', 3, 50, 1, 'linear');
    end

    if curStep >= 20 and curStep < 40 then
        noteTweenY('left0', 0, -200, 1, 'linear');
        noteTweenY('left1', 1, 100, 1, 'linear');
        noteTweenY('left2', 2, -300, 1, 'linear');
        noteTweenY('left3', 3, -50, 1, 'linear');
    end

    if curStep >= 40 and curStep < 60 then
        noteTweenY('left0', 0, 200, 1, 'linear');
        noteTweenY('left1', 1, -100, 1, 'linear');
        noteTweenY('left2', 2, 300, 1, 'linear');
        noteTweenY('left3', 3, 50, 1, 'linear');
    end

    if curStep >= 60 and curStep < 80 then
        noteTweenY('left0', 0, -200, 1, 'linear');
        noteTweenY('left1', 1, 100, 1, 'linear');
        noteTweenY('left2', 2, -300, 1, 'linear');
        noteTweenY('left3', 3, -50, 1, 'linear');

        noteTweenY('right0', 4, -200, 1, 'linear');
        noteTweenY('right1', 5, 100, 1, 'linear');
        noteTweenY('right2', 6, -300, 1, 'linear');
        noteTweenY('right3', 7, -50, 1, 'linear');
    end

    if curStep >= 80 and curStep < 100 then
        noteTweenY('left0', 0, 200, 1, 'linear');
        noteTweenY('left1', 1, -100, 1, 'linear');
        noteTweenY('left2', 2, 300, 1, 'linear');
        noteTweenY('left3', 3, 50, 1, 'linear');

        noteTweenY('right0', 4, 200, 1, 'linear');
        noteTweenY('right1', 5, -100, 1, 'linear');
        noteTweenY('right2', 6, 300, 1, 'linear');
        noteTweenY('right3', 7, 50, 1, 'linear');
    end

    if curStep >= 100 and curStep < 120 then
        noteTweenY('left0', 0, 50, 1, 'linear');
        noteTweenY('left1', 1, 50, 1, 'linear');
        noteTweenY('left2', 2, 50, 1, 'linear');
        noteTweenY('left3', 3, 50, 1, 'linear');

        noteTweenY('right0', 4, 50, 1, 'linear');
        noteTweenY('right1', 5, 50, 1, 'linear');
        noteTweenY('right2', 6, 50, 1, 'linear');
        noteTweenY('right3', 7, 50, 1, 'linear');
    end

    if curStep >= 128 and curStep < 160 then
        noteTweenAngle('spin0', 0, 360, 1, 'circOut');
        noteTweenAngle('spin1', 1, 360, 1, 'circOut');
        noteTweenAngle('spin2', 2, 360, 1, 'circOut');
        noteTweenAngle('spin3', 3, 360, 1, 'circOut');

        noteTweenY('up0', 0, -200, 0.2, 'linear');
        noteTweenY('up1', 1, 200, 0.2, 'linear');
        noteTweenY('up2', 2, -200, 0.2, 'linear');
        noteTweenY('up3', 3, 200, 0.2, 'linear');
    end

    if curStep >= 160 and curStep < 161 then
        noteTweenY('left0', 0, 50, 0.1, 'linear');
        noteTweenY('left1', 1, 50, 0.1, 'linear');
        noteTweenY('left2', 2, 50, 0.1, 'linear');
        noteTweenY('left3', 3, 50, 0.1, 'linear');
    end

    if curStep >= 161 and curStep < 181 then
        noteTweenAngle('spin0', 0, 360, 1, 'circOut');
        noteTweenAngle('spin1', 1, 360, 1, 'circOut');
        noteTweenAngle('spin2', 2, 360, 1, 'circOut');
        noteTweenAngle('spin3', 3, 360, 1, 'circOut');

        noteTweenY('up0', 0, -200, 0.2, 'linear');
        noteTweenY('up1', 1, 200, 0.2, 'linear');
        noteTweenY('up2', 2, -200, 0.2, 'linear');
        noteTweenY('up3', 3, 200, 0.2, 'linear');
    end
end