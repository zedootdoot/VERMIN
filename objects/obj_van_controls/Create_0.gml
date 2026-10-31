// Play music
if (global.current_job >= 0 and global.current_job < 2) {
    global.current_music = audio_play_sound(van_music, 1, true);
}
else if (global.current_job == 2) {
    global.current_music = audio_play_sound(van_music2, 1, true);
}
else if (global.current_job = 3) {
    global.current_music = audio_play_sound(van_music2_reverse, 1, true);
}
else if (global.current_job >= 4) {
    global.current_music = audio_play_sound(vermin13, 1, true);
}
text_timer = 2 * room_speed;

// Hide all tile layers
layer_set_visible("tiles_col_1", false);
layer_set_visible("tiles_col_2", false);
layer_set_visible("tiles_col_3", false);
layer_set_visible("tiles_back_1", false);
layer_set_visible("tiles_back_2", false);
layer_set_visible("tiles_back_3", false);

// Get the correct layer IDs
var active_layer_1 = -1;
var active_layer_2 = -1;

switch (global.current_job) {
    case 0:
    case 1:
    case 2:
        active_layer_1 = layer_get_id("Instances_1");
        layer_set_visible("tiles_col_1", true);
        layer_set_visible("tiles_back_1", true);
        obj_player.tilemap = layer_tilemap_get_id(layer_get_id("tiles_col_1"));
        break;
    
    case 3:
        active_layer_1 = layer_get_id("Instances_25");
        active_layer_2 = layer_get_id("Instances_2");
        layer_set_visible("tiles_col_2", true);
        layer_set_visible("tiles_back_2", true);
        obj_player.tilemap = layer_tilemap_get_id(layer_get_id("tiles_col_2"));
        break;
    
    case 4:
    default:
        active_layer_1 = layer_get_id("Instances_35");
        active_layer_2 = layer_get_id("Instances_3");
        layer_set_visible("tiles_col_3", true);
        layer_set_visible("tiles_back_3", true);
        obj_player.tilemap = layer_tilemap_get_id(layer_get_id("tiles_col_3"));
        break;
}

// List of all object types with the parent
var object_types = [obj_computer, obj_mirror, obj_player, obj_cot, obj_box, obj_blood, obj_bomb_shop];

// Destroy instances on wrong layers
for (var obj_type = 0; obj_type < array_length(object_types); obj_type++) {
    var obj = object_types[obj_type];
    for (var i = instance_number(obj) - 1; i >= 0; i--) {
        var inst = instance_find(obj, i);
        
        // Don't destroy the options object!
        if (inst.object_index == obj_options_overlay) continue;
        
        // Keep if on EITHER active layer, destroy otherwise
        // Handle case where active_layer_2 is -1 (not used)
        var on_active_layer = (inst.layer == active_layer_1);
        if (active_layer_2 != -1) {
            on_active_layer = on_active_layer || (inst.layer == active_layer_2);
        }
        
        if (!on_active_layer) {
            instance_destroy(inst);
        }
    }
}

global.options_allowed = true;