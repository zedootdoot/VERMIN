interact_distance = 100;
interacting = false;
just_closed = false;
full_text = "";
text_index = 0;
text_speed = 1;
text_done = false;
dialogue_stage = 0; // which line we're on
purchase_failed = false;
on_menu = false;
option_selected = 0;
input_locked = false;
input_lock_timer = 0;

function get_dialogue_line() {
    var bomb_price = global.money + 1;
    switch (dialogue_stage) {
        case 0: return "BOMB-MART.";
        case 1: return "nuclear bomb - $" + string(bomb_price) + ".";
        case 2: return "interest you in a purchase?";
        // Failed lines
        case 10: return "...";
        case 11: return "you're $1 short.";
        case 12: return "come back when you're serious.";
    }
    return "";
}