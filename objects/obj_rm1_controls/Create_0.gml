// Stop any lingering music first
if (global.current_music != noone) {
    audio_stop_sound(global.current_music);
}

// Start Job 1 music
global.current_music = audio_play_sound(job1_music, 1, true);


// Tracks whether the room has been cleared
room_cleared = false;

// Timer for delaying fade back to van
fade_timer = 0;

// Whether to show the "Job Complete" message
show_complete_message = false;

global.respawn_room = rm_job1;

global.options_allowed = true;
text_timer = 4 * room_speed; // 12 seconds (room_speed = steps per second)