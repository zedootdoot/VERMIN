if (!instance_exists(obj_VERMIN)) exit;
if (obj_VERMIN.phase != "fight") exit;

var base_w = 200;
var bar_h  = 16;
var bar_w  = base_w * obj_VERMIN.bar_scale;
var bar_x  = display_get_gui_width()/2 - bar_w/2;
var bar_y  = display_get_gui_height() - 80;
// If locked, fill is always full and pulses red
var fill = (obj_VERMIN.hp / obj_VERMIN.max_hp) * bar_w;

// Background
draw_set_color(c_dkgray);
draw_rectangle(bar_x, bar_y, bar_x + bar_w, bar_y + bar_h, false);

// Fill — pulse red when locked
if (obj_VERMIN.hp_locked) {
    var pulse = 0.5 + 0.5 * sin(current_time / 80);
    draw_set_color(merge_colour(c_red, c_maroon, pulse));
    draw_rectangle(bar_x, bar_y, bar_x + bar_w, bar_y + bar_h, false);
} else {
    draw_set_color(c_red);
    draw_rectangle(bar_x, bar_y, bar_x + fill, bar_y + bar_h, false);
}

// Border — thicker when locked
draw_set_color(obj_VERMIN.hp_locked ? c_red : c_white);
draw_rectangle(bar_x, bar_y, bar_x + bar_w, bar_y + bar_h, true);

// Label
draw_set_font(fnt_default);
draw_set_color(obj_VERMIN.hp_locked ? c_red : c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_text(bar_x + bar_w/2, bar_y + bar_h + 4, "VERMIN");