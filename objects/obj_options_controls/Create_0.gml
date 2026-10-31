// Track which room we came from
// REMOVE this default — we’ll set prev_room when opening Options
// if (!variable_instance_exists(instance_id, "prev_room")) {
//     prev_room = rm_title;
// }

// Menu setup
menu_items = ["FULLSCREEN", "VOLUME", "RETURN TO TITLE"];
menu_selection = 0;
global.next_room = noone;

// Settings
fullscreen = window_get_fullscreen();

input_locked = false;
input_lock_timer = 0;