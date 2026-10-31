// Tracks whether we've already triggered room clearance
room_cleared = false;

// The next room to go to after clearing
next_room = noone; // can be set per instance in the Room Editor

// Delay before switching rooms (in seconds)
delay_seconds = 3;

// Convert delay to frames
alarm_delay = room_speed * delay_seconds;


fade_alpha = 0;
fade_speed = 0.05;
fading_out = false;
fading_in = false;

// music fade
music_fade_speed = 0.02;
music_fading = false;