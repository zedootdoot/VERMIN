// Read respawn flag first, clear it immediately
is_respawn                = (global.respawn_triggered == true);
global.respawn_triggered  = false;

// Set phase on controls
phase  = is_respawn ? "respawn_dialogue" : "approach";
phase2 = false;

// Push phase and dialogue to VERMIN now that respawn flag is read
if (instance_exists(obj_VERMIN)) {
    if (is_respawn) {
        obj_VERMIN.phase    = "respawn_dialogue";
        obj_VERMIN.dialogue = ["I defeated you once.", "I'll do it again."];
    } else {
        obj_VERMIN.phase = "approach";
    }
}

// Audio
music_dialogue = vermin2;
music_fight    = title_music;
music_phase2   = sad_end;

if (global.current_music != noone) {
    audio_stop_sound(global.current_music);
    global.current_music = noone;
}

if (is_respawn) {
    current_music = audio_play_sound(music_fight, 1, true);
    music_swapped = true;
} else {
    current_music = audio_play_sound(music_dialogue, 1, true);
    music_swapped = false;
}
global.current_music = current_music;

// Player lock
player_locked = false;

// Error message
show_error_message = false;
error_timer        = 0;
error_flash        = 0;
error_persistent   = false;
error_glitch_x     = 0;
error_glitch_y     = 0;
error_glitch_timer = 0;

// Win / cutscene
win_alpha         = 0;
fading_out        = false;
player_dead_alpha = 0;
player_dead_done  = false;

// Monologue
monologue = [
    "...",
    "I told you.",
    "You were always just vermin.",
    "Scurrying around.",
    "Thinking it meant something.",
    "It didn't.",
    "I have EXTERMINATED you.",
    "I have EXTERMINATED THEM ALL.",
    "I have finished the job.",
    "You have served your purpose",
    "Your adventure is over."
];
mono_index      = 0;
mono_text       = "";
mono_char       = 0;
mono_char_timer = 0;
mono_char_delay = 3;
mono_done       = false;
mono_wait       = false;
mono_alpha      = 0;
mono_active     = false;
mono_fade_out   = false;
mono_fade_alpha = 1;

// Win text
exterminated_alpha = 0;
exterminated_done  = false;
exterminated_hold  = 180;
exterminated_timer = 0;

// Help tokens
heal_amount    = 5;
token_timer    = 300;
token_interval = 480;

// Tile degradation
layer_col    = layer_get_id("tiles_col");
layer_back   = layer_get_id("tiles_back");
tilemap_col  = layer_tilemap_get_id(layer_col);
tilemap_back = layer_tilemap_get_id(layer_back);

tile_size  = 16;
map_width  = room_width  div tile_size;
map_height = room_height div tile_size;

col_tiles  = [];
back_tiles = [];

for (var ty = 0; ty < map_height; ty++) {
    for (var tx = 0; tx < map_width; tx++) {
        var tile_col_val  = tilemap_get(tilemap_col,  tx, ty);
        var tile_back_val = tilemap_get(tilemap_back, tx, ty);
        var is_border     = (tx == 0 || tx == map_width - 1 || ty == 0 || ty == map_height - 1);
        if (is_border && tile_col_val != 0)  array_push(col_tiles,  {cx: tx, cy: ty});
        if (!is_border && tile_back_val != 0) array_push(back_tiles, {cx: tx, cy: ty});
    }
}

// Shuffle col_tiles
var _len = array_length(col_tiles);
for (var i = _len - 1; i > 0; i--) {
    var j        = irandom(i);
    var _temp    = col_tiles[i];
    col_tiles[i] = col_tiles[j];
    col_tiles[j] = _temp;
}

// Shuffle back_tiles
_len = array_length(back_tiles);
for (var i = _len - 1; i > 0; i--) {
    var j         = irandom(i);
    var _temp     = back_tiles[i];
    back_tiles[i] = back_tiles[j];
    back_tiles[j] = _temp;
}

degrade_timer     = 0;
degrade_rate_base = 90;
degrade_rate      = degrade_rate_base;
col_exhausted     = false;

// Globals
global.respawn_room           = rm_FINAL;
global.vermin_dialogue_active = false;
global.options_allowed        = true;