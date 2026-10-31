if (!interacting && keyboard_check_pressed(ord("Z")) 
    && distance_to_object(obj_player) <= interact_distance
    && !global.options_open) {
    
    // Check if player is facing the mirror
    var angle_to_object = point_direction(obj_player.x, obj_player.y, x, y);
    var angle_diff = abs(angle_difference(obj_player.facing, angle_to_object));
    
    if (angle_diff < 45) {
        interacting = true;
        text_index = 0;
        full_text = mirror_texts[global.current_job];
        show_debug_message("full_text set to: [" + full_text + "]");
        text_done = false;
    }
}

// Typing effect
if (interacting && !text_done) {
    var old_index = floor(text_index);
    if (text_index < string_length(full_text)) {
        text_index = min(text_index + text_speed, string_length(full_text));
        var new_index = floor(text_index);
        if (new_index > old_index) {
            var _c = string_char_at(full_text, new_index);
            if (_c != " " && _c != "." && _c != "," && _c != "!" && _c != "?") {
                var _s = audio_play_sound(snd_dialogue, 1, false);
                audio_sound_pitch(_s, random_range(0.92, 1.08));
            }
        }
    } else {
        text_done = true;
    }
}

// Advance or close
if (interacting && text_done && keyboard_check_pressed(ord("Z")) && !global.options_open) {
    interacting = false;
}