if (keyboard_check_pressed(vk_f11)) {
    window_set_fullscreen(!window_get_fullscreen());
}

if (global.input_locked) {
    global.input_lock_timer -= 1;
    if (global.input_lock_timer <= 0) global.input_locked = false;
}