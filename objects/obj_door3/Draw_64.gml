if (showing_dialogue) {
    var gui_w = display_get_gui_width();
    var gui_h = display_get_gui_height();
    
    // Calculate box dimensions
    var box_h = 80;
    var box_y = gui_h - box_h;
    var pad = 10;
    
    // Background
    draw_set_color(c_black);
    draw_set_alpha(0.85);
    draw_rectangle(0, box_y, gui_w, gui_h, false);
    draw_set_alpha(1);
    
    // Border
    draw_set_color(c_white);
    draw_rectangle(0, box_y, gui_w, gui_h, true);
    
    // Determine what to show
    var on_menu = (current_line >= array_length(dialogue_lines)) && has_menu;
    
    if (on_menu) {
        // --- Show menu options ---
        draw_set_font(fnt_default);
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        
        // Option 1 (PROCEED)
        draw_set_color(option_selected == 0 ? c_red : c_white);
        draw_text(gui_w * 0.3, box_y + box_h / 2, "> " + menu_option_1);
        
        // Option 2 (DON'T PROCEED)
        draw_set_color(option_selected == 1 ? c_red : c_white);
        draw_text(gui_w * 0.7, box_y + box_h / 2, "> " + menu_option_2);
        
    } else {
        // --- Show current dialogue line ---
        var text_to_show = "";
        if (current_line < array_length(dialogue_lines)) {
            text_to_show = dialogue_lines[current_line];
        }
        
        draw_set_font(fnt_default);
        draw_set_color(c_white);
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
        draw_text_ext(pad, box_y + pad, text_to_show, -1, gui_w - pad * 2);
        
        // Show progress indicator
        draw_set_halign(fa_right);
        draw_set_valign(fa_bottom);
        draw_set_color(c_gray);
        draw_text(gui_w - pad, gui_h - pad, 
            "[Z] " + string(current_line + 1) + "/" + string(array_length(dialogue_lines)));
    }
}