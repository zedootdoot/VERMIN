// Fade out logic
if (fading_out) {
    fade_alpha += fade_speed;

    if (fade_alpha >= 1) {
        fade_alpha = 1;

        // Stop previous music
        if (next_room != noone && next_room != rm_job1_2 && next_room != rm_job2_2 && next_room != rm_job4_2 && next_room != rm_job4_3 && next_room != rm_job_unknown && next_room != rm_job5_main && next_room != rm_job1_2_silly) {
            if (global.current_music != noone) {
                audio_stop_sound(global.current_music);
                global.current_music = noone;
            }
        }

        // Go to the next room
        if (next_room != noone) room_goto(next_room);

        fading_out = false;
        fading_in = true;
    }
}

if (fading_in) {
    fade_alpha -= fade_speed;
    global.music_volume = min(1, global.music_volume + 0.02);
    audio_master_gain(global.music_volume);

    if (fade_alpha <= 0) {
        fade_alpha = 0;
        fading_in = false;
    }
}