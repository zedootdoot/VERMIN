switch (card_state) {
    case "fade_in":
        card_alpha = min(card_alpha + FADE_SPEED, 1);
        if (card_alpha >= 1) {
            card_state  = "hold";
            state_timer = HOLD_FRAMES;
        }
        break;

    case "hold":
        state_timer--;
        if (state_timer <= 0) card_state = "fade_out";
        break;

    case "fade_out":
        card_alpha = max(card_alpha - FADE_SPEED, 0);
        if (card_alpha <= 0) {
            card_state  = "pause";   // NEW
            state_timer = PAUSE_FRAMES;
        }
        break;

    case "pause":
    state_timer--;
        if (state_timer <= 0) {
            card_index++;
            if (card_index >= array_length(cards)) {
                card_state = "wait_for_music";  // NEW — wait instead of leaving
                exit;
            }
            card_state = "fade_in";
        }
        break;
    
    case "wait_for_music":              // NEW
        if (!audio_is_playing(vermin_4)) {
            room_goto(rm_title);
        }
    break;
}
// --- Secret code detection ---
if (secret_cooldown > 0) secret_cooldown--;
if (secret_timeout > 0) {
    secret_timeout--;
    if (secret_timeout <= 0) secret_input = [];
}

if (secret_cooldown <= 0) {
    var key_pressed = -1;
    if      (keyboard_check_pressed(vk_left))  key_pressed = vk_left;
    else if (keyboard_check_pressed(vk_right)) key_pressed = vk_right;
    else if (keyboard_check_pressed(vk_up))    key_pressed = vk_up;
    else if (keyboard_check_pressed(vk_down))  key_pressed = vk_down;

    if (key_pressed != -1) {
        array_push(secret_input, key_pressed);
        secret_cooldown = 10;
        secret_timeout  = 120;

        var matches = true;
        if (array_length(secret_input) <= array_length(secret_code)) {
            for (var i = 0; i < array_length(secret_input); i++) {
                if (secret_input[i] != secret_code[i]) { matches = false; break; }
            }
        } else {
            matches = false;
        }

        if (!matches) secret_input = [];

        if (matches && array_length(secret_input) == array_length(secret_code)) {
            room_goto(rm_secret);
        }
    }
}