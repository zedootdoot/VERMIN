draw_self();

if ((phase == "dialogue" || phase == "respawn_dialogue") && dialogue_text != "") {
    var bw = 400;
    var bh = 90;
    var bx = x - bw/2;
    var by = y - 140;

    draw_set_alpha(0.9);
    draw_set_color(c_black);
    draw_rectangle(bx, by, bx + bw, by + bh, false);
    draw_set_alpha(1);

    draw_set_color(c_white);
    draw_rectangle(bx, by, bx + bw, by + bh, true);

    draw_set_font(fnt_default);
    draw_set_color(c_white);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_text_ext(bx + 16, by + 14, dialogue_text, 22, bw - 32);

    if (waiting_for_input) {
        draw_set_halign(fa_right);
        draw_set_color(c_gray);
        draw_text(bx + bw - 10, by + bh - 18, "[Z]");
    }

    draw_set_alpha(1);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}