if (!global.options_open) {
    // --- 1. Update knockback target ---
    if (alarm[1] >= 0) {
        target_x = x + kb_x;
        target_y = y + kb_y;
    }
    
    // --- 2. Compute movement direction ---
    var _hor = clamp(target_x - x, -1, 1);
    var _ver = clamp(target_y - y, -1, 1);
    
    // --- 3. Handle rotation (face the target, not movement direction) ---
    if (can_rotate && instance_exists(obj_player)) {
        // Get angle to PLAYER (not movement direction)
        var angle_to_player = point_direction(x, y, obj_player.x, obj_player.y);
        
        // Round to nearest 90 degrees (0, 90, 180, 270)
        target_angle = round(angle_to_player / 90) * 90;
        
        // Smoothly rotate towards target
        var angle_diff = angle_difference(target_angle, current_angle);
        if (abs(angle_diff) > rotation_speed) {
            current_angle += sign(angle_diff) * rotation_speed;
        } else {
            current_angle = target_angle;
        }
        
        // Normalize angle to 0-360
        current_angle = (current_angle + 360) mod 360;
        
        // Apply rotation to sprite
        image_angle = current_angle;
    }
    
    // --- 4. Move ---
    move_and_collide(_hor * move_speed, _ver * move_speed, [tilemap, obj_bed, obj_enemy_parent, obj_box]);
    
    // --- 5. Mirror sprite (only if not rotating) ---
    if (!can_rotate) {
        if (_hor > 0) image_xscale = -1;      // moving right
        else if (_hor < 0) image_xscale = 1;  // moving left
    }
    
    // --- 6. Attack system ---
    if (attack_range > 0 && attack_cooldown > 0) {
        attack_cooldown--;
    }
    
    if (attack_range > 0 && instance_exists(obj_player) && attack_cooldown <= 0) {
        var dist = distance_to_object(obj_player);
        if (dist <= attack_range) {
            perform_attack();
            attack_cooldown = attack_rate;
        }
    }
}