// Interaction tracking
interacting = false;
interact_distance = 10; // distance player must be to interact

// Typing effect variables
full_text = "";
text_index = 0;
text_speed = 1;        // characters per step
text_done = false;    // whether typing has finished

// Get user and system names
player_name = environment_get_variable("USERNAME");
if (player_name == "") player_name = "Player"; // fallback

// Job-based text for mirror
mirror_texts = [
    "Time to start today's JOBS.",      // Job 0
    "Has that scratch always been there?",      // Job 1
    "Gotta wash this soon." , // Job 2
    "Strange vermin...\nThey looked weirdly human...",
    "............\n........." + player_name + "......"
];

if (!variable_global_exists("current_job")) {
    global.current_job = 0; // default starting job
}

draw_colored_text = function(xx, yy, text, red_words, max_width) {
    draw_set_font(fnt_default);
    draw_set_halign(fa_left);    // <-- add this
    draw_set_valign(fa_top);     // <-- and this
    
    var line_height = string_height("A") + 4;
    var x_offset = 0;
    var y_offset = 0;

    var lines = string_split(text, "\n");
    for (var l = 0; l < array_length(lines); l++) {
        var words = string_split(lines[l], " ");
        for (var w = 0; w < array_length(words); w++) {
            var word = words[w];
            if (word == "") continue;
            var word_width = string_width(word);
            var space_width = string_width(" ");
            if (x_offset > 0 && x_offset + word_width > max_width) {
                x_offset = 0;
                y_offset += line_height;
            }
            var clean = string_replace_all(word, ".", "");
            clean = string_replace_all(clean, ",", "");
            clean = string_replace_all(clean, "!", "");
            clean = string_replace_all(clean, "?", "");
            clean = string_replace_all(clean, ":", "");
            clean = string_replace_all(clean, ";", "");
            var is_red = false;
            for (var j = 0; j < array_length(red_words); j++) {
                if (clean == red_words[j]) { is_red = true; break; }
            }
            draw_set_color(is_red ? c_red : c_white);
            draw_text(xx + x_offset, yy + y_offset, word);
            x_offset += word_width + space_width;
        }
        x_offset = 0;
        y_offset += line_height;
    }
}