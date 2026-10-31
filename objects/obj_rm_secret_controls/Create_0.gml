if (global.current_music != noone) {
    audio_stop_sound(global.current_music);
}
global.current_music = audio_play_sound(vermin15, 1, true);
// Tracks whether the room has been cleared
room_cleared = false;

// Timer for delaying fade back to van
fade_timer = 0;

// Whether to show the "Job Complete" message
show_complete_message = false;

global.respawn_room = rm_secret;

global.options_allowed = true;