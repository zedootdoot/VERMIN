/// STEP EVENT
if (global.options_open)
    exit;

// Countdown input lock
if (global.input_locked) {
    global.input_lock_timer -= 1;
    if (global.input_lock_timer <= 0) global.input_locked = false;
    // Skip input this frame
    exit;
}

// Navigation
if (keyboard_check_pressed(vk_down)) {
    menu_selection = (menu_selection + 1) mod array_length(menu_items);
}
if (keyboard_check_pressed(vk_up)) {
    menu_selection = (menu_selection - 1 + array_length(menu_items)) mod array_length(menu_items);
}

// Select menu item
if (keyboard_check_pressed(ord("Z"))) {
    var choice = menu_items[menu_selection];
    switch (choice) {
        case "BEGIN":
            audio_stop_sound(title_music);
            with (obj_fade) {
                fading_out = true;
                next_room = other.next_room;
            }
            break;
        case "OPTIONS":
            room_goto(rm_options)
            
            exit;
        case "QUIT":
            game_end();
            break;
    }
}

