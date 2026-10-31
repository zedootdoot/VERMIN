if (!global.options_open) {
    // --- 1. Update knockback target ---
    if (alarm[1] >= 0) {
        target_x = x + kb_x;
        target_y = y + kb_y;
    }

    // --- 2. Compute movement direction ---
    var _hor = clamp(target_x - x, -1, 1);
    var _ver = clamp(target_y - y, -1, 1);

    // --- 3. Handle rotation ---
    if (can_rotate && instance_exists(obj_player)) {
        var angle_to_player = point_direction(x, y, obj_player.x, obj_player.y);
        target_angle = round(angle_to_player / 90) * 90;

        var angle_diff = angle_difference(target_angle, current_angle);
        if (abs(angle_diff) > rotation_speed) {
            current_angle += sign(angle_diff) * rotation_speed;
        } else {
            current_angle = target_angle;
        }

        current_angle = (current_angle + 360) mod 360;
        image_angle   = current_angle;
    }

    // --- 4. Move ---
    move_and_collide(_hor * move_speed, _ver * move_speed, [tilemap, obj_bed, obj_enemy_parent, obj_box]);

    // --- 5. Mirror sprite ---
    if (!can_rotate && (_hor != 0 || _ver != 0)) {
        if (_hor > 0)      image_xscale = -scale_multiplier;
        else if (_hor < 0) image_xscale =  scale_multiplier;
        image_yscale = scale_multiplier;
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