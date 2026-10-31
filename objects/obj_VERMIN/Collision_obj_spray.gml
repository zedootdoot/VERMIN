if (other.source != "player") exit;  // ignore VERMIN's own spray
if (iframes > 0) exit;

hp -= other.damage;
audio_play_sound(snd_boss_hit, 1, false);

var _dir    = point_direction(other.x, other.y, x, y);
kb_x        = 1;
kb_y        = 1;
kb_target_x = x + lengthdir_x(kb_strength, _dir);
kb_target_y = y + lengthdir_y(kb_strength, _dir);
hit_flash   = iframes_max;
iframes     = iframes_max;