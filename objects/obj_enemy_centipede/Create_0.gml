target_x = x;
target_y = y;
alarm[0] = 60;
tilemap = layer_tilemap_get_id("tiles_col");


// Knockback
kb_x = 0;
kb_y = 0;

// Rotation (disabled by default)
current_angle = 0;        
target_angle = 0;         
rotation_speed = 5;       
can_rotate = true;       // FALSE by default - enable in child objects

// Attack system
attack_cooldown = 0;      
attack_range = 0;         // 0 = no attacks by default
attack_rate = 120;        
has_ranged_attack = false; // FALSE by default - enable in child objects

// SFX placeholders (set these in child objects)
snd_hurt = snd_centipede_hit;           
snd_death = snd_centipede_death;          


// Define attack function
perform_attack = function() {
    // Default ranged attack (if enabled)
    if (has_ranged_attack && instance_exists(obj_player)) {
        var projectile = instance_create_depth(x, y, depth - 1, obj_enemy_projectile);
        projectile.direction = point_direction(x, y, obj_player.x, obj_player.y);
        projectile.speed = 3;
        projectile.image_angle = projectile.direction;
        
        // Play attack sound
        if (snd_attack != -1) {
            audio_play_sound(snd_attack, 1, false);
        }
    }
}