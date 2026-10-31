if (interacting) {
    var box_left = 50;
    var box_top = display_get_gui_height() - 150;
    var box_right = display_get_gui_width() - 50;
    var box_bottom = display_get_gui_height() - 50;

    draw_set_color(c_black);
    draw_rectangle(box_left, box_top, box_right, box_bottom, false);
    draw_set_color(c_white);

    if (on_menu) {
        draw_set_font(fnt_default);
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        var mid_y = box_top + (box_bottom - box_top) / 2;
        draw_set_color(option_selected == 0 ? c_red : c_white);
        draw_text(box_left + (box_right - box_left) * 0.3, mid_y, "> BUY");
        draw_set_color(option_selected == 1 ? c_red : c_white);
        draw_text(box_left + (box_right - box_left) * 0.7, mid_y, "> LEAVE");
    } else {
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
        draw_set_color(c_white);
        draw_text(box_left + 20, box_top + 20, string_copy(full_text, 1, text_index));
    }
}