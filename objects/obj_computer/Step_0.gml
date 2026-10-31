if (!ui_open && !just_closed_ui && keyboard_check_pressed(ord("Z")) 
    && distance_to_object(obj_player) <= interact_distance
    && !global.options_open) {
    
    // Check if player is facing the computer
    var angle_to_object = point_direction(obj_player.x, obj_player.y, x, y);
    var angle_diff = abs(angle_difference(obj_player.facing, angle_to_object));
    
    if (angle_diff < 45) { // Player must be facing within 45 degrees
        ui_open = true;
        instance_create_depth(0, 0, -100, obj_computer_ui);
    }
}

// Reset the flag each step
if (just_closed_ui) just_closed_ui = false;