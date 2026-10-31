if (room != rm_credits && room != rm_title && room != rm_options && room != rm_death && room != rm_FINAL) {
 // Always-visible money counter (keep this part)
    var gui_w = display_get_gui_width();
    draw_set_font(fnt_default);
    draw_set_halign(fa_right);
    draw_set_valign(fa_top);
    draw_set_color(c_yellow);
    draw_text(gui_w - 10, 10, "$" + string(global.money));
    
    if (showing) {
        var box_left = 50;
        var box_top = display_get_gui_height() - 150;
        var box_right = display_get_gui_width() - 50;
        var box_bottom = display_get_gui_height() - 50;
    
        draw_set_color(c_black);
        draw_rectangle(box_left, box_top, box_right, box_bottom, false);
        draw_set_color(c_white);
        draw_set_font(fnt_default);
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
    
        draw_text(box_left + 20, box_top + 20, "You got $" + string(payment_amount) + "!");
        draw_set_color(c_yellow);
        draw_text(box_left + 20, box_top + 58, payment_text);
    }
}