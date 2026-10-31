if (global.current_job == 0){
    if (text_timer > 0) {
        draw_set_font(fnt_default);
        draw_set_color(c_white);
        draw_set_halign(fa_center);
        draw_set_valign(fa_bottom);
        draw_text(display_get_gui_width() / 2, display_get_gui_height() - 72, "(USE ARROW KEYS TO MOVE)");
    }
}