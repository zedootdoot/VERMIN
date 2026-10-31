overlay_selection = 0;
menu_items = ["FULLSCREEN", "VOLUME", "RETURN TO HUB", "RETURN TO TITLE", "BACK"];

// Only initialize globals if they don't exist yet — don't wipe on room change
if (!variable_global_exists("options_open"))  global.options_open  = false;
if (!variable_global_exists("game_paused"))   global.game_paused   = false;

input_locked      = false;
input_lock_timer  = 0;