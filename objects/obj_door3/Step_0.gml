if (is_cleared) {
    instance_destroy();
    exit;
}
// Reset flag
if (just_closed) just_closed = false;

// --- Open dialogue ---
if (!showing_dialogue && !just_closed && !global.options_open) {
    if (keyboard_check_pressed(ord("Z")) && instance_exists(obj_player)) {
        var dist = point_distance(x, y, obj_player.x, obj_player.y);
        
        if (dist <= interact_distance) {
            var angle_to_obj = point_direction(obj_player.x, obj_player.y, x, y);
            var angle_diff = abs(angle_difference(obj_player.facing, angle_to_obj));
            var tolerance = (dist < 8) ? 90 : 45;
            
            if (angle_diff < tolerance) {
                showing_dialogue = true;
                current_line = 0;
                option_selected = 0;
                global.game_paused = true;
                input_locked = true;
                input_lock_timer = 10;
            }
        }
    }
}

// --- Handle dialogue input ---
if (showing_dialogue) {
    // Input lock
    if (input_locked) {
        input_lock_timer--;
        if (input_lock_timer <= 0) input_locked = false;
    } else {
        // Check if we're on the last line and showing menu
        var on_menu = (current_line >= array_length(dialogue_lines)) && has_menu;
        
        if (on_menu) {
            // --- Menu navigation ---
            if (keyboard_check_pressed(vk_left) || keyboard_check_pressed(vk_right)) {
                option_selected = 1 - option_selected;  // Toggle 0/1
                input_locked = true;
                input_lock_timer = 10;
            }
            
            // Confirm menu selection
            if (keyboard_check_pressed(ord("Z"))) {
                if (option_selected == 0 && target_room != -1) {
                    // PROCEED - go to room
                    showing_dialogue = false;
                    global.game_paused = false;
                    room_goto(target_room);
                } else {
                    // DON'T PROCEED or no room set - just close
                    showing_dialogue = false;
                    global.game_paused = false;
                    just_closed = true;
                }
                input_locked = true;
                input_lock_timer = 10;
            }
        } else {
            // --- Advance dialogue ---
            if (keyboard_check_pressed(ord("Z"))) {
                audio_play_sound(snd_dialogue, 1, false);
                current_line++;
                input_locked = true;
                input_lock_timer = 10;
                
                // If no more lines and no menu, close
                if (current_line >= array_length(dialogue_lines) && !has_menu) {
                    showing_dialogue = false;
                    global.game_paused = false;
                    just_closed = true;
                }
            }
        }
    }
}