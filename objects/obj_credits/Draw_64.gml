draw_set_font(fnt_default);
draw_set_color(c_lime);
draw_set_alpha(card_alpha);        // actual transparency
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

if (card_index < array_length(cards)) {
    var card    = cards[card_index];
    var line_h  = 28;
    var total_h = (array_length(card) - 1) * line_h;
    var start_y = 270 - (total_h / 2);
    for (var i = 0; i < array_length(card); i++) {
        draw_text(400, start_y + (i * line_h), card[i]);
    }
}

draw_set_alpha(1);  // always reset after, or everything else in the room will be transparent too