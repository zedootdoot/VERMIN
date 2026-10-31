// Navigate menu
if (keyboard_check_pressed(vk_down)) {
    menu_selection += 1;
    if (menu_selection >= array_length(menu_items)) menu_selection = 0;
}

if (keyboard_check_pressed(vk_up)) {
    menu_selection -= 1;
    if (menu_selection < 0) menu_selection = array_length(menu_items) - 1;
}

switch (menu_selection) {
    case 0: // FULLSCREEN
        if (keyboard_check_pressed(vk_left) || keyboard_check_pressed(vk_right) || keyboard_check_pressed(ord("Z"))) {
            window_set_fullscreen(!window_get_fullscreen());
            input_locked = true; input_lock_timer = 1;
        }
        break;

    //case 1: // VOLUME
        //if (keyboard_check_pressed(vk_left)) {
            //global.music_volume = max(global.music_volume - 1, 0);
           // audio_master_gain(global.music_volume / 10);
            //input_locked = true; input_lock_timer = 1;
       // }
        //if (keyboard_check_pressed(vk_right)) {
            //global.music_volume = min(global.music_volume + 1, 10);
           // audio_master_gain(global.music_volume / 10);
           // input_locked = true; input_lock_timer = 1;
       // }
        //break;
}

// Select current option
if (keyboard_check_pressed(ord("Z"))) {
    var choice = menu_items[menu_selection];

    switch (choice) {

        case "RETURN TO TITLE":
            if (global.current_music != noone) {
                audio_stop_sound(global.current_music);
                global.current_music = noone;
            }
        
            // Lock input to prevent auto-start on title screen
            global.input_locked = true;
            global.input_lock_timer = room_speed * 0.25; // quarter-second delay
        
            room_goto(rm_title);
            break;
        
        case "MANAGER":
            audio_stop_sound(title_music);
            audio_stop_sound(global.current_music);
            global.current_job = 4;
            room_goto(rm_FINAL);
            break;
    }
}
