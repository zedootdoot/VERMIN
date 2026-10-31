// Initialize variables in Create Event
if (!variable_instance_exists(id, "fade_timer")) fade_timer = 0;
if (!variable_instance_exists(id, "show_complete_message")) show_complete_message = false;

// Check if all enemies are defeated
var all_enemies_defeated = (instance_number(obj_enemy_parent) == 0);

// If the room is cleared and delay hasn't started yet, start delay
if (!room_cleared && all_enemies_defeated) {

    if (fade_timer <= 0) {
        fade_timer = room_speed * 2; // 2-second delay
        show_complete_message = true; // show the message
    } else {
        fade_timer -= 1; // countdown
    }

    // Once delay finishes
    if (fade_timer <= 0) {
        room_cleared = true;
        global.room_cleared = true; // track globally
        global.current_job = 3;
        
        show_complete_message = false; // hide message
        
        // Trigger room 2
        with (obj_fade) {
            fading_out = true;
            next_room = rm_title;
        }
    }
}