// Only check if the room hasn't been cleared yet
if (!room_cleared) {
    // Check if all enemies (children of obj_enemy_parent) are gone
    if (instance_number(obj_enemy_parent) == 0) {
        room_cleared = true;   // mark so this triggers once
        alarm[0] = alarm_delay; // start the delay
    }
}


// Fade out logic
if (fading_out) {
    fade_alpha += fade_speed;

    // Gradually lower music
    global.music_volume = max(0, global.music_volume - 0.02);
    audio_master_gain(global.music_volume);

    if (fade_alpha >= 1) {
        fade_alpha = 1;
        fading_out = false;

        room_goto(next_room);

        fading_in = true;
    }
}
else if (fading_in) {
    fade_alpha -= fade_speed;

    // Gradually raise music
    global.music_volume = min(1, global.music_volume + 0.02);
    audio_master_gain(global.music_volume);

    if (fade_alpha <= 0) {
        fade_alpha = 0;
        fading_in = false;
    }
}
