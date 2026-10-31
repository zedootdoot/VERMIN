// --- Background rectangle ---
draw_set_color(c_black);
draw_rectangle(80, 80, 700, 480, false);

// --- Title ---
draw_set_color(c_lime);
draw_text(100, 100, "JOBS:");

// --- Draw menu items (left panel) ---
for (var i = 0; i < array_length(menu_items); i++) {
    var _y = 140 + i*50;

    // Highlight current selection
    if (i == menu_selection) {
        draw_set_color(c_yellow);
        draw_text(110, _y, ">"); // indicator
    } else {
        draw_set_color(c_lime);
    }

    draw_text(130, _y, menu_items[i]);
}

// --- Draw description panel (right side) ---
draw_set_color(c_black);
draw_rectangle(260, 80, 590, 480, false);

draw_set_color(c_red);
draw_set_font(fnt_description);

// Draw the typed text for the selected job
if (menu_selection < array_length(job_descriptions)) {
    draw_text(270, 100, typed_text); // x, y, wrap width, line height
}