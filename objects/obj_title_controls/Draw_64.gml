

/// DRAW GUI EVENT

draw_set_font(fnt_title);
draw_set_color(c_lime);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// Title
draw_text(room_width/2, room_height/3, "[VERMIN]");

// Menu items
draw_set_font(fnt_default);
var spacing = room_height * 0.08; // relative spacing
var start_y = room_height/2;

for (var i = 0; i < array_length(menu_items); i++) {
    var _y = start_y + i * spacing;
    if (i == menu_selection) { draw_set_color(c_yellow); 
        draw_text(display_get_gui_width()/2, _y, "> " + menu_items[i]); } 
    else { draw_set_color(c_lime); 
        draw_text(display_get_gui_width()/2, _y, menu_items[i]);

    draw_text(room_width/2, _y, menu_items[i]);
}}

draw_set_font(fnt_default);
draw_set_color(c_white);
draw_text(display_get_gui_width() / 2, display_get_gui_height() - 72, "(PRESS Z TO INTERACT)");