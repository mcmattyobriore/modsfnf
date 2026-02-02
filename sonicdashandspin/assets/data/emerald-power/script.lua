function opponentNoteHit();
       health = getProperty('health');
    if(getProperty('health') > 0.0){
       setProperty('health', health- 0.02);
	}
}
local angleshit = 1;
local angle = 1;
function onCreate();
	makeLuaSprite('bg','dmbg',-343.15, -295.45);
	addLuaSprite('bg',false);
}
function onBeatHit();
	if(curBeat < 9999999999999999){
		triggerEvent('Add Camera Zoom', 0.04,0.05);
		if(curBeat % 2 == 0){
			angleshit = angle;
		}else{
			angleshit = -angle;
		}
		setProperty('camHUD.angle',angleshit*3);
		setProperty('camGame.angle',angleshit*3);
		doTweenAngle('turn', 'camHUD', angleshit, stepCrochet*0.002, 'circOut');
		doTweenX('tuin', 'camHUD', -angleshit*8, crochet*0.001, 'linear');
		doTweenAngle('tt', 'camGame', angleshit, stepCrochet*0.002, 'circOut');
		doTweenX('ttrn', 'camGame', -angleshit*8, crochet*0.001, 'linear');
	}else{
		setProperty('camHUD.angle',0);
		setProperty('camHUD.x',0);
		setProperty('camHUD.x',0);
	}
}
function onStepHit();
	if(curBeat < 388){
		if(curStep % 4 == 0){
			doTweenY('rrr', 'camHUD', -12, stepCrochet*0.002, 'circOut');
			doTweenY('rtr', 'camGame.scroll', 12, stepCrochet*0.002, 'sineIn');
		}
		if(curStep % 4 == 2){
			doTweenY('rir', 'camHUD', 0, stepCrochet*0.002, 'sineIn');
			doTweenY('ryr', 'camGame.scroll', 0, stepCrochet*0.002, 'sineIn');
		}
	}
}
function onSongStart();
	noteTweenX("NoteMove1", 0, -1000, 0.5, cubeInOut);
	noteTweenX("NoteMove2", 1, -1000, 0.5, cubeInOut);
	noteTweenX("NoteMove3", 2, -1000, 0.5, cubeInOut);
	noteTweenX("NoteMove4", 3, -1000, 0.5, cubeInOut);
}
local stompcheck = true;
local bruh = 1;
local a = 1/120;
local x = {}
local y = {}
local modchart = false;
local aA = 0;
local start = false;
local speed = 1;
local modchart2 = false;
local md = 1;
local stompvalue = -40;
local stompmode = 0;
local condition = 8;
local stompcount = 0;
local zoom = 0;
local b = 1/100;
local xStomp = 30;
function flag();
  for i = 0,7 do;
    setPropertyFromGroup('strumLineNotes', i, 'y', y[i] + 20 * math.cos(i/1.5 + a));
    setPropertyFromGroup('strumLineNotes', i, 'x', x[i] + 20 * math.cos(a + i*0.80));
  }
}
function stomp(numbah);
  if(numbah % 2 == 0){
    for i = 0,7 do;
      noteTweenX('stompLeft'+i, i, x[i] + xStomp, 0.15, 'circInOut');
    }
    xStomp = xStomp*(-1);
  }else{
    for i = 0,7 do;
      noteTweenX('stompRight'+i, i, x[i], 0.15, 'circInOut');
    }
  }
  if(numbah == 1){
    for i = 0,7,2 do;
      noteTweenY('stompA'+i, i, y[i] - stompvalue, 0.2, 'circInOut');
    }
  }else if(numbah == 2){
    for i = 1,7,2 do;
      noteTweenY('stompB'+i, i, y[i] - stompvalue, 0.2, 'circInOut');
    }
  }else if(numbah == 3 || numbah == 4 || numbah == 5 || numbah == 6){
    noteTweenY('stompC'+numbah, (numbah-3), y[(numbah-3)], 0.2, 'circInOut');
    noteTweenY('stompD'+numbah, (numbah+1), y[(numbah+1)], 0.2, 'circInOut');
  }else if(numbah == 7 || numbah == 8 || numbah == 9 || numbah == 10){
    noteTweenY('stompE'+numbah, (numbah-7), y[(numbah-7)] - stompvalue, 0.2, 'circInOut');
    noteTweenY('stompF'+numbah, (numbah-3), y[(numbah-3)] - stompvalue, 0.2, 'circInOut');
  }else if(numbah == 11){
    for i = 0,7 do;
      noteTweenY('stompG'+i, i, y[i], 0.2, 'circInOut');
    }
  }
}
function onSongStart();
  zoom = getProperty('camGame.zoom');
  speed = 240 / getPropertyFromClass('ClientPrefs', 'framerate');
  if(downscroll){
    stompvalue = 40;
  }
  for i = 0,7 do;
    local xA = getPropertyFromGroup('strumLineNotes', i, 'x');
    local yB = getPropertyFromGroup('strumLineNotes', i, 'y');
    x[i] = xA;
    y[i] = yB;
  }
  for i = 0,7 do;
    noteTweenX(i  +  'xpos', i, x[i] + 30 * math.cos(a + i*0.80), 1, 'circInOut');
    noteTweenY(i  +  'ypos', i, y[i] + 30 * math.cos(i/1.5 + a), 1, 'circInOut');
  }
}
function onUpdate(elapsed);
  if(modchart == true){
    if(md == 1){
      flag();
      a = a + 1/120 * speed;
    }
  }
	if(del > 0){
		del = del - 1;
	}
	if(del2 > 0){
		del2 = del2 - 1;
	}
  if(followchars == true){
    if(mustHitSection == false){
      setProperty('defaultCamZoom',0.7);
      if(dad.animation.curAnim.name == 'singLEFT'){
        triggerEvent('Camera Follow Pos',xx-ofs,yy);
      }
      if(dad.animation.curAnim.name == 'singRIGHT'){
        triggerEvent('Camera Follow Pos',xx+ofs,yy);
      }
      if(dad.animation.curAnim.name == 'singUP'){
        triggerEvent('Camera Follow Pos',xx,yy-ofs);
      }
      if(dad.animation.curAnim.name == 'singDOWN'){
        triggerEvent('Camera Follow Pos',xx,yy+ofs);
      }
      if(dad.animation.curAnim.name == 'singLEFT-alt'){
        triggerEvent('Camera Follow Pos',xx-ofs,yy);
      }
      if(dad.animation.curAnim.name == 'singRIGHT-alt'){
        triggerEvent('Camera Follow Pos',xx+ofs,yy);
      }
      if(dad.animation.curAnim.name == 'singUP-alt'){
        triggerEvent('Camera Follow Pos',xx,yy-ofs);
      }
      if(dad.animation.curAnim.name == 'singDOWN-alt'){
        triggerEvent('Camera Follow Pos',xx,yy+ofs);
      }
      if(dad.animation.curAnim.name == 'idle-alt'){
        triggerEvent('Camera Follow Pos',xx,yy);
      }
      if(dad.animation.curAnim.name == 'idle'){
        triggerEvent('Camera Follow Pos',xx,yy);
      }
    }else{
      setProperty('defaultCamZoom',0.6);
      if(boyfriend.animation.curAnim.name == 'singLEFT'){
        triggerEvent('Camera Follow Pos',xx2-ofs,yy2);
      }
      if(boyfriend.animation.curAnim.name == 'singRIGHT'){
        triggerEvent('Camera Follow Pos',xx2+ofs,yy2);
      }
      if(boyfriend.animation.curAnim.name == 'singUP'){
        triggerEvent('Camera Follow Pos',xx2,yy2-ofs);
      }
      if(boyfriend.animation.curAnim.name == 'singDOWN'){
        triggerEvent('Camera Follow Pos',xx2,yy2+ofs);
      }
      if(boyfriend.animation.curAnim.name == 'idle-alt'){
        triggerEvent('Camera Follow Pos',xx2,yy2);
      }
      if(boyfriend.animation.curAnim.name == 'idle'){
        triggerEvent('Camera Follow Pos',xx2,yy2);
      }
    }
  }else{
    triggerEvent('Camera Follow Pos','','');
  }
}
function onStepHit();
  if(curStep == 99999999999999999){
    modchart = false;
    for i = 0,7 do;
      noteTweenX(i  +  'xposA', i, x[i], 0.8, 'circInOut');
      noteTweenY(i  +  'yposA', i, y[i], 0.8, 'circInOut');
      noteTweenAngle(i  +  'angleposA', i, 360, 0.5, 'circInOut');
    }
  }
}
function onTweenCompleted(tag);
  if(tag == '7ypos'){
    modchart = true;
    for i = 0,7 do;
      noteTweenAngle(i  +  'anglepos', i, 360, 1, 'circInOut');
    }
  }
  if(tag == 'stompLeft7' || tag == 'stompRight7'){
    stompcheck = true;
  }
}
function onTimerCompleted(tag, loops, loopsLeft);
  if(tag == 'start'){
    modchart = false;
  }
}
function onEvent(name, value1, value2);
  if(name == 'stomps' && stompcheck){
    stomp(bruh);
    if(bruh < 12){
      bruh = bruh + 1;
    }else{
      bruh = 1;
    }
    stompcheck = false;
  }
}
function onGameOver();
  modchart = false;
  return Function_Continue;
}
local allowCountdown = false;
function onStartCountdown();


	return Function_Continue;
}
function onCreatePost();
setProperty('timeBar.color', getColorFromHex('683AA0'));
}