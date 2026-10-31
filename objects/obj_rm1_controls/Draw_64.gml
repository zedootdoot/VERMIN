if (show_complete_message && instance_exists(obj_player)) {
    draw_set_font(fnt_title);
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);
    draw_set_color(c_lime);
    
    var screen_center_x = display_get_gui_width() / 2;
    var screen_center_y = display_get_gui_height() / 3;
    
    draw_text(screen_center_x, screen_center_y, "[ROOM CLEANSED]");
}

if (text_timer > 0) {
    draw_set_font(fnt_default);
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_bottom);
    draw_text(display_get_gui_width() / 2, display_get_gui_height() - 94, "(X TO EXTERMINATE)");
}