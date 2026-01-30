function onCreate()
    makeLuaSprite('bg','bgback',-290,100)
    setScrollFactor('bg',0.6,0.6)
    addLuaSprite('bg')
    
    makeLuaSprite('bg1','bgmain',-400,10)
    setScrollFactor('bg1',0.95,1)
    addLuaSprite('bg1')

    scaleObject('bg',2.3,2.3)
    scaleObject('bg1',2.5,2.5)
end

function onSectionHit()
    if mustHitSection then 
        callScript('scripts/neocam', 'zoom', {'game', 0.75, 1, 'quartout', false})
    else
        callScript('scripts/neocam', 'zoom', {'game', 0.65, 1, 'quartout', false})
    end
end
