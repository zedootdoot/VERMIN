// Input lock countdown
if (global.input_locked) {
    global.input_lock_timer--;
    if (global.input_lock_timer <= 0) global.input_locked = false;
}

// Type description
char_timer++;
if (char_timer >= char_delay) {
    char_timer = 0;
    if (type_index_desc < string_length(full_desc)) {
        type_index_desc++;
        typed_desc = string_copy(full_desc, 1, type_index_desc);
    }
}

// Type menu items
for (var i = 0; i < array_length(menu_items); i++) {
    if (type_index_options[i] < string_length(menu_items[i])) {
        type_index_options[i] += type_speed;
        typed_options[i] = string_copy(menu_items[i], 1, floor(type_index_options[i]));
    }
}

// Navigation and selection — only after description fully typed and input unlocked
if (type_index_desc >= string_length(full_desc) && !global.input_locked) {
    if (keyboard_check_pressed(vk_down)) {
        menu_selection = (menu_selection + 1) mod array_length(menu_items);
    }
    if (keyboard_check_pressed(vk_up)) {
        menu_selection = (menu_selection - 1 + array_length(menu_items)) mod array_length(menu_items);
    }

    if (keyboard_check_pressed(ord("Z"))) {
        switch (menu_selection) {
            case 0: // CONTINUE
                audio_stop_sound(global.current_music);
                global.current_music = noone;
                // Only set respawn flag if returning to rm_FINAL
                if (global.respawn_room == rm_FINAL) {
                    global.respawn_triggered = true;
                }
                room_goto(global.respawn_room);
                break;
            case 1: // RETURN TO TITLE
                audio_stop_sound(global.current_music);
                global.current_music     = noone;
                global.respawn_triggered = false;
                room_goto(rm_title);
                break;
        }
    }
}

// Cursor blink
cursor_timer++;
if (cursor_timer >= cursor_delay) {
    cursor_visible = !cursor_visible;
    cursor_timer   = 0;
}