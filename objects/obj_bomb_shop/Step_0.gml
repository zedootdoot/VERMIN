if (input_locked) {
    input_lock_timer--;
    if (input_lock_timer <= 0) input_locked = false;
}

if (just_closed) just_closed = false;

// Open
if (!interacting && !just_closed && !global.options_open) {
    if (keyboard_check_pressed(ord("Z")) && instance_exists(obj_player)) {
        var dist = point_distance(x, y, obj_player.x, obj_player.y);
        if (dist <= interact_distance) {
            var angle_to_obj = point_direction(obj_player.x, obj_player.y, x, y);
            var angle_diff = abs(angle_difference(obj_player.facing, angle_to_obj));
            if (angle_diff < 45) {
                interacting = true;
                purchase_failed = false;
                on_menu = false;
                dialogue_stage = 0;
                full_text = get_dialogue_line();
                text_index = 0;
                text_done = false;
                option_selected = 0;
                global.game_paused = true;
                input_locked = true;
                input_lock_timer = 10;
            }
        }
    }
}

// Typing effect
if (interacting && !text_done) {
    if (text_index < string_length(full_text)) {
        text_index += text_speed;
        
        // Play dialogue sfx per character — skip spaces and punctuation
        var _c = string_char_at(full_text, floor(text_index));
        if (_c != " " && _c != "," && _c != "!" && _c != "?") {
            var _s = audio_play_sound(snd_bomb_mart, 1, false);  // replace with your asset name
            audio_sound_pitch(_s, random_range(0.82, 1.08));    // slight pitch variation
        }
    } else {
        text_done = true;
    }
}

if (interacting && !input_locked) {
    if (!text_done) {
        // Skip to end of current line
        if (keyboard_check_pressed(ord("Z"))) {
            text_index = string_length(full_text);
            text_done = true;
        }
    } else if (on_menu) {
        // Menu navigation
        if (keyboard_check_pressed(vk_left) || keyboard_check_pressed(vk_right)) {
            option_selected = 1 - option_selected;
            input_locked = true;
            input_lock_timer = 10;
        }
        if (keyboard_check_pressed(ord("Z"))) {
            if (option_selected == 0) {
                // BUY - always fails
                purchase_failed = true;
                on_menu = false;
                dialogue_stage = 10;
                full_text = get_dialogue_line();
                text_index = 0;
                text_done = false;
            } else {
                // LEAVE
                interacting = false;
                global.game_paused = false;
                just_closed = true;
            }
            input_locked = true;
            input_lock_timer = 10;
        }
    } else {
        if (keyboard_check_pressed(ord("Z"))) {
            dialogue_stage++;
            // Normal flow ends at stage 2, then show menu
            if (!purchase_failed && dialogue_stage > 2) {
                on_menu = true;
            // Failed flow ends at stage 12, then close
            } else if (purchase_failed && dialogue_stage > 12) {
                interacting = false;
                global.game_paused = false;
                just_closed = true;
                purchase_failed = false;
                dialogue_stage = 0;
            } else {
                full_text = get_dialogue_line();
                text_index = 0;
                text_done = false;
            }
            input_locked = true;
            input_lock_timer = 10;
        }
    }
}