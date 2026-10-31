depth = -10000
if (global.options_open) {
    var gui_w = display_get_gui_width();
    var gui_h = display_get_gui_height();

    draw_set_color(c_black);
    draw_set_alpha(0.7);
    draw_rectangle(0,0,gui_w,gui_h,false);
    draw_set_alpha(1);

    var win_w = gui_w*0.5;
    var win_h = gui_h*0.5;
    var win_x = gui_w/2 - win_w/2;
    var win_y = gui_h/2 - win_h/2;

    draw_set_color(c_dkgray);
    draw_rectangle(win_x, win_y, win_x+win_w, win_y+win_h, false);

    draw_set_font(fnt_title);
    draw_set_color(c_lime);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text(gui_w/2, win_y + win_h*0.15, "OPTIONS");

    draw_set_font(fnt_default);
    var start_y = win_y + win_h*0.35;
    var spacing = win_h*0.12;

    for (var i = 0; i < array_length(menu_items); i++) {
        var _y = start_y + i*spacing;
        var text = menu_items[i];

        switch(menu_items[i]){
            case "FULLSCREEN": text = "FULLSCREEN: " + (window_get_fullscreen() ? "ON" : "OFF"); break;
            case "VOLUME": text = "VOLUME: " + string("ERROR"); break;
        }

        if (i == overlay_selection) draw_set_color(c_yellow);
        else draw_set_color(c_white);

        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_text(gui_w/2, _y, "> " + text);
    }
}
