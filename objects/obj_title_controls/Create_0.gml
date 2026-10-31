/// CREATE EVENT

// Reset globals
global.options_open = false;
global.game_paused = false;
global.input_locked = true;
global.input_lock_timer = room_speed * 0.25; // short input lock

// Title menu
menu_items = ["BEGIN", "OPTIONS", "QUIT"];
menu_selection = 0;

// Play title music (looping)
if (!audio_is_playing(title_music)) {
    audio_play_sound(title_music, 1, true);
}

// Reset fade logic (if obj_fade exists)
with (obj_fade) {
    fading_out = false;
    fading_in = false;
    fade_alpha = 0;
    next_room = noone;
}

// First gameplay room
next_room = rm_van;

global.options_allowed = false;