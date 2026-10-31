draw_set_alpha(alpha);

// Glowing circle base
draw_set_color(c_yellow);
draw_circle(x, y + 4, 14, false);
draw_set_color(c_black);
draw_circle(x, y + 4, 10, false);

// Symbol — question mark
draw_set_font(fnt_default);
draw_set_color(c_yellow);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(x, y, "?");

draw_set_alpha(1);