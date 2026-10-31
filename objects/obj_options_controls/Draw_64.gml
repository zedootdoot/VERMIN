// --- Title ---
draw_set_font(fnt_title);
draw_set_color(c_lime);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

var center_x = display_get_gui_width() / 2;
var top_y = display_get_gui_height() / 4;

draw_text(center_x, top_y, "OPTIONS");

// --- Menu Items ---
draw_set_font(fnt_default);
var start_y = top_y + 80;
var spacing = 64;

for (var i = 0; i < array_length(menu_items); i++) {
    var _y = start_y + i * spacing;
    var text_to_draw = menu_items[i];

    // Add current values for settings
    switch (string_lower(menu_items[i])) {
        case "fullscreen":
            text_to_draw = "FULLSCREEN: " + ((window_get_fullscreen()) ? "ON" : "OFF");
            break;
        case "volume":
            // Ensure music_volume is defined and forced to string
            var vol = (variable_global_exists("music_volume")) ? global.music_volume : 10;
            text_to_draw = "VOLUME: " + string("ERROR");
            break;
        // RETURN TO TITLE and BACK stay unchanged
    }

    // Highlight current selection
    if (i == menu_selection) {
        draw_set_color(c_yellow);
        draw_text(center_x, _y, "> " + text_to_draw);
    } else {
        draw_set_color(c_lime);
        draw_text(center_x, _y, text_to_draw);
    }
}
