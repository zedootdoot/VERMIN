lifetime--;
if (lifetime <= 0) instance_destroy();

if (!instance_exists(obj_VERMIN)) {
    instance_destroy();
    exit;
}

// Move toward VERMIN
var dx   = obj_VERMIN.x - x;
var dy   = obj_VERMIN.y - y;
var dist = point_distance(x, y, obj_VERMIN.x, obj_VERMIN.y);

if (dist > 16) {
    x += (dx / dist) * move_speed;
    y += (dy / dist) * move_speed;
    is_moving = true;

    if (abs(dx) > abs(dy)) {
        facing = (dx > 0) ? "right" : "left";
    } else {
        facing = (dy > 0) ? "down" : "up";
    }
} else {
    is_moving = false;
    // Deal damage and distract
    if (attack_cd <= 0) {
        with (obj_VERMIN) {
            if (iframes <= 0) {
                hp        -= other.damage;
                hit_flash  = iframes_max;
                iframes    = iframes_max;
            }
            // Distract — temporarily target rat instead of player
            distracted       = true;
            distract_target  = other.id;
            distract_timer   = other.distract_dur;
        }
        attack_cd = attack_rate;
    }
}

if (attack_cd > 0) attack_cd--;

// Sprite — assign your rat sprites here
switch (facing) {
    //case "down":  sprite_index = spr_rat_front; break;
    //case "up":    sprite_index = spr_rat_back;  break;
    case "left":  sprite_index = spr_rat_left;  break;
    case "right": sprite_index = spr_rat_right; break;
}