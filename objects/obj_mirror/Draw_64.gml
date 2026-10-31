show_debug_message("visible: [" + string_copy(full_text, 1, text_index) + "]");
draw_set_font(fnt_default);
if (interacting) {
    var box_left = 50;
    var box_top = display_get_gui_height() - 150;
    var box_right = display_get_gui_width() - 50;
    var box_bottom = display_get_gui_height() - 50;
    
    // Draw dialogue box
    draw_set_color(c_black);
    draw_rectangle(box_left, box_top, box_right, box_bottom, false);
    
    var x_pos = box_left + 20;
    var y_pos = box_top + 20;
    
    // Get visible text with typing effect
    var visible_text = string_copy(full_text, 1, text_index);

    // Define which words should be red
    var red_words = ["JOBS", "scratch", player_name];
    
    // Draw text with colored words
    var max_width = (box_right - box_left) - 40; // 20px padding on each side
    draw_colored_text(x_pos, y_pos, visible_text, red_words, max_width);
}