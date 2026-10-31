overlay_selection = clamp(overlay_selection, 0, array_length(menu_items) - 1);

// Only allow options if permitted AND not in rm_options (has its own menu)
if (keyboard_check_pressed(vk_escape) && global.options_allowed && room != rm_options) {
    global.options_open = !global.options_open;
    global.game_paused  = global.options_open;
    if (global.options_open) overlay_selection = 0;
    input_locked      = true;
    input_lock_timer  = 4;
}

if (!global.options_open) exit;

if (input_locked) {
    input_lock_timer--;
    if (input_lock_timer <= 0) input_locked = false;
    exit;
}

if (keyboard_check_pressed(vk_down)) {
    overlay_selection = (overlay_selection + 1) mod array_length(menu_items);
    input_locked = true;
    input_lock_timer = 10;
}
if (keyboard_check_pressed(vk_up)) {
    overlay_selection = (overlay_selection - 1 + array_length(menu_items)) mod array_length(menu_items);
    input_locked = true;
    input_lock_timer = 10;
}

switch (overlay_selection) {
    case 0:
        if (keyboard_check_pressed(vk_left) || keyboard_check_pressed(vk_right) || keyboard_check_pressed(ord("Z"))) {
            window_set_fullscreen(!window_get_fullscreen());
            input_locked = true;
            input_lock_timer = 10;
        }
        break;
    case 1:
        break;
    case 2:
        if (keyboard_check_pressed(ord("Z"))) {
            if (room != rm_van) {
                audio_stop_all();
                global.options_open = false;
                global.game_paused  = false;
                overlay_selection   = 0;
                room_goto(rm_van);
            }
        }
        break;
    case 3:
        if (keyboard_check_pressed(ord("Z"))) {
            audio_stop_all();
            global.options_open = false;
            global.game_paused  = false;
            overlay_selection   = 0;
            room_goto(rm_title);
        }
        break;
    case 4:
        if (keyboard_check_pressed(ord("Z"))) {
            global.options_open = false;
            global.game_paused  = false;
        }
        break;
}