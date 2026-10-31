/// @function perform_attack()
/// @description Override in child objects for specific attacks
function perform_attack() {
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
    
    // Child objects can override this function for custom behavior
}