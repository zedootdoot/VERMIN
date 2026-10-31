// Hit other enemies (not VERMIN — handled by collision event)
if (source == "player") {
    if (place_meeting(x, y, obj_enemy_parent)) {
        with (obj_enemy_parent) {
            if (alarm[0] < 0) {
                hp         -= other.damage;
                alarm[0]    = 60;
                image_blend = c_red;
                if (hp <= 0) room_goto(rm_death);
            }
        }
        exit;
    }
}

// Fired by VERMIN
if (source == "vermin") {
    if (instance_exists(obj_player)) {
        if (point_distance(x, y, obj_player.x, obj_player.y) < 20) {
            obj_player.hp -= damage;
            exit;
        }
    }
}