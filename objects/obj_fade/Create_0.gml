// obj_fade Create Event
persistent = true;
fade_alpha = 0;
fade_speed = 0.05;
fading_out = false;
fading_in = false;
next_room = noone;
music_fade_speed = 0.02;
// Reset fade room
with (obj_fade) {
    next_room = noone;
    fading_out = false;
    fading_in = false;
    fade_alpha = 0;
}