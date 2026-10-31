var center_x = 400;
var title_y = 150;

// Title
draw_set_font(fnt_title);
draw_set_color(c_red);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(center_x, title_y, "FAILED");

// Draw description (typed text with colored words)
draw_set_font(fnt_default);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

var red_words = ["FINISH", "THE", "JOB"];
draw_colored_text(100, title_y + 60, typed_desc, red_words);

// Draw blinking cursor at the end of typed text
if (cursor_visible && type_index_desc < string_length(full_desc)) {
    var cursor_x = string_width(typed_desc) + 100;
    var cursor_y = title_y + 60;
    draw_set_color(c_white);
    draw_text(cursor_x, cursor_y, "_");
}


// Menu items below description
var start_y = title_y + 150;
var spacing = 50;

for (var i = 0; i < array_length(menu_items); i++) {
    var _y = start_y + i * spacing;
    if (i == menu_selection) { draw_set_color(c_yellow); 
        draw_text(display_get_gui_width()/2, _y, "> " + menu_items[i]); } 
    else { draw_set_color(c_white); 
        draw_text(display_get_gui_width()/2, _y, menu_items[i]);
    }

}
