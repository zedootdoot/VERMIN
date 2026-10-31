if (interacting) {
    var box_left = 50;
    var box_top = display_get_gui_height() - 150;
    var box_right = display_get_gui_width() - 50;
    var box_bottom = display_get_gui_height() - 50;

    // Draw dialogue box
    draw_set_color(c_black);
    draw_rectangle(box_left, box_top, box_right, box_bottom, false);

    draw_set_color(c_white);

    // Draw text with typing effect
    draw_text(box_left + 20, box_top + 20, string_copy(full_text, 1, text_index));
}