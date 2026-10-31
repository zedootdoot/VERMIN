// Input lock
global.input_locked     = true;
global.input_lock_timer = room_speed * 0.25;

// Music
if (global.current_music != noone) {
    audio_stop_sound(global.current_music);
    global.current_music = noone;
}
global.current_music = audio_play_sound(death_music, 1, true);
audio_master_gain(1.0);

// Menu
menu_items     = ["CONTINUE", "RETURN TO TITLE"];
menu_selection = 0;

// Text
full_desc       = "And the Vermin survives.\nWill you [FINISH THE JOB]?";
typed_desc      = "";
type_index_desc = 0;
type_speed      = 0.5;
char_timer      = 0;
char_delay      = 2;

typed_options      = array_create(array_length(menu_items), "");
type_index_options = array_create(array_length(menu_items), 0);

// Cursor
cursor_visible = true;
cursor_timer   = 0;
cursor_delay   = 30;

global.options_allowed = false;

// Colored text functions
draw_colored_text = function(xx, yy, text, red_words) {
    var x_offset   = 0;
    var y_offset   = 0;
    var curr_word  = "";
    var text_len   = string_length(text);
    for (var i = 1; i <= text_len; i++) {
        var ch = string_char_at(text, i);
        if (ch == "\n") {
            if (curr_word != "") {
                draw_word_with_color(xx + x_offset, yy + y_offset, curr_word, red_words);
                x_offset += string_width(curr_word);
                curr_word = "";
            }
            y_offset += string_height("A");
            x_offset  = 0;
        } else if (ch == " " || i == text_len) {
            if (i == text_len && ch != " ") curr_word += ch;
            if (curr_word != "") {
                draw_word_with_color(xx + x_offset, yy + y_offset, curr_word, red_words);
                x_offset += string_width(curr_word);
                curr_word = "";
            }
            if (ch == " ") {
                draw_set_color(c_white);
                draw_text(xx + x_offset, yy + y_offset, " ");
                x_offset += string_width(" ");
            }
        } else {
            curr_word += ch;
        }
    }
}

draw_word_with_color = function(xx, yy, word, red_words) {
    var leading  = "";
    var core     = word;
    var trailing = "";
    while (string_length(core) > 0 && string_pos(string_char_at(core, 1), "[({") > 0) {
        leading += string_char_at(core, 1);
        core     = string_delete(core, 1, 1);
    }
    while (string_length(core) > 0 && string_pos(string_char_at(core, string_length(core)), "])}.,!?:;") > 0) {
        trailing = string_char_at(core, string_length(core)) + trailing;
        core     = string_delete(core, string_length(core), 1);
    }
    var x_pos = xx;
    if (leading != "") {
        draw_set_color(c_white);
        draw_text(x_pos, yy, leading);
        x_pos += string_width(leading);
    }
    var is_red = false;
    for (var j = 0; j < array_length(red_words); j++) {
        if (core == red_words[j]) { is_red = true; break; }
    }
    draw_set_color(is_red ? c_red : c_white);
    draw_text(x_pos, yy, core);
    x_pos += string_width(core);
    if (trailing != "") {
        draw_set_color(c_white);
        draw_text(x_pos, yy, trailing);
    }
}