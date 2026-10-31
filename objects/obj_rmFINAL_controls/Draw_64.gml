// Error message
if (show_error_message) {
    var cx = display_get_gui_width()  / 2;
    var cy = display_get_gui_height() / 2;

    draw_set_font(fnt_default);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);

    if (error_persistent) {
        var gx = error_glitch_x;
        var gy = error_glitch_y;

        draw_set_color(c_red);
        draw_set_alpha(0.6);
        draw_text(cx - 4 + gx, cy + gy, "[ERROR: <player0> CANNOT PERISH]");

        draw_set_color(c_aqua);
        draw_set_alpha(0.6);
        draw_text(cx + 4 - gx, cy - gy, "[ERROR: <player0> CANNOT PERISH]");

        if ((error_flash mod 3) < 2) {
            draw_set_color(c_white);
            draw_set_alpha(1);
            draw_text(cx + gx, cy + gy, "[ERROR: <player0> CANNOT PERISH]");
        }

        if ((error_flash mod 20) < 4) {
            draw_set_alpha(0.15);
            draw_set_color(c_red);
            draw_rectangle(0, cy - 12, display_get_gui_width(), cy + 12, false);
        }
    } else {
        if ((error_flash mod 8) < 4) {
            draw_set_color(c_red);
            draw_set_alpha(1);
            draw_text(cx, cy, "[ERROR: <player0> CANNOT PERISH]");
        }
    }
    draw_set_alpha(1);
}

// Win phase — persistent black overlay that never drops
if (phase == "win") {
    // Persistent black base
    draw_set_alpha(1);
    draw_set_color(c_black);
    draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);

    // [VERMIN EXTERMINATED] — appears first
    if (exterminated_alpha > 0) {
        draw_set_alpha(exterminated_alpha);
        draw_set_font(fnt_title);
        draw_set_color(c_lime);
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_text(display_get_gui_width()/2, display_get_gui_height()/2,
                  "[VERMIN EXTERMINATED]");
    }

    // Monologue text
    if (mono_active) {
        draw_set_alpha(mono_alpha * mono_fade_alpha);
        draw_set_font(fnt_default);
        draw_set_color(c_white);
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_text(display_get_gui_width()/2, display_get_gui_height()/2, mono_text);

        if (mono_wait && !mono_fade_out) {
            draw_set_alpha(0.5 * mono_fade_alpha);
            draw_set_color(c_gray);
            draw_text(display_get_gui_width()/2, display_get_gui_height()/2 + 30, "[Z]");
        }
    }

    draw_set_alpha(1);
}