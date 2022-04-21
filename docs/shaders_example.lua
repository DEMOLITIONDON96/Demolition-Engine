function onCreatePost()
    addEffect1('game', 0.005); --This is Chromatic Abbrevation
    addEffect2('game', false); --Scanline effect :)
    addEffect3('game', 0.2, 0.4, false); --Grain effect
    addEffect4('game', 0.2, 0.1); --Blur Effect (Tiltshift)
    addEffect5('game', 0.0, true, true, true); --VCR effect, go nuts
    addEffect6('game', 0.1, 0.1, 0.1); --D&B Shaders
    addEffect7('game', 0.1, 0.1, 0.1); --D&B Shaders
    addEffect8('game', 0.1, 0.1, 0.1); --D&B Shaders
    addEffect9('game', false); --Invert Colors
    addEffect10('game'); --Greyscale, funi suicide mouse mods 
    addEffect11('game'); --Greyscale, funi suicide mouse mods 
    addEffect12('game', 0, 0, 0, 0); --3D/Triangle Effect
    addEffect13('game', 0.35, 1.0); --Bloom Effect
    die('game'); --removes all shaders in script
end
