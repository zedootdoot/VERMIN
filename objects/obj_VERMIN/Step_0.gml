// --- Knockback ---
if (kb_x != 0 || kb_y != 0) {
    var kb_dist = point_distance(x, y, kb_target_x, kb_target_y);
    if (kb_dist > 1) {
        var kb_dir = point_direction(x, y, kb_target_x, kb_target_y);
        x += lengthdir_x(min(kb_dist, 5), kb_dir);
        y += lengthdir_y(min(kb_dist, 5), kb_dir);
        x  = clamp(x, 32, 768);
        y  = clamp(y, 32, 768);
    } else {
        kb_x        = 0;
        kb_y        = 0;
        kb_target_x = x;
        kb_target_y = y;
    }
}

if (iframes > 0)   iframes--;
if (hit_flash > 0) hit_flash--;

bar_scale = lerp(bar_scale, bar_scale_target, 0.1);


switch (phase) {

    case "approach":
        if (!instance_exists(obj_player)) break;
        var dx   = obj_player.x - x;
        var dy   = obj_player.y - y;
        var dist = point_distance(x, y, obj_player.x, obj_player.y);

        if (dist > approach_dist) {
            x += (dx / dist) * move_speed;
            y += (dy / dist) * move_speed;
            x  = clamp(x, 32, 768);
            y  = clamp(y, 32, 768);
            is_moving = true;
            if (abs(dx) > abs(dy)) {
                facing = (dx > 0) ? "right" : "left";
            } else {
                facing = (dy > 0) ? "down" : "up";
            }
        } else {
            is_moving = false;
            phase = "dialogue";
            with (obj_rmFINAL_controls) phase = "dialogue";
        }
        break;

    case "dialogue":
    case "respawn_dialogue":
        is_moving = false;
        if (instance_exists(obj_player)) {
            var dx = obj_player.x - x;
            var dy = obj_player.y - y;
            if (abs(dx) > abs(dy)) {
                facing = (dx > 0) ? "right" : "left";
            } else {
                facing = (dy > 0) ? "down" : "up";
            }
        }

        if (!dialogue_done) {
            char_timer++;
            if (char_timer >= char_delay) {
                char_timer = 0;
                var full_line = dialogue[dialogue_index];
                if (current_char < string_length(full_line)) {
                    current_char++;
                    dialogue_text = string_copy(full_line, 1, current_char);
                    var _c = string_char_at(full_line, current_char);
                    if (_c != " " && _c != "." && _c != "," && _c != "!" && _c != "?") {
                        var _s = audio_play_sound(snd_boss_dialogue, 0, false);
                        audio_sound_pitch(_s, random_range(0.82, 1.08));
                    }
                } else {
                    dialogue_done     = true;
                    waiting_for_input = true;
                }
            }
        }

        if (waiting_for_input && keyboard_check_pressed(ord("Z"))) {
            dialogue_index++;
            if (dialogue_index >= array_length(dialogue)) {
                phase         = "fight";
                dialogue_text = "";
                with (obj_rmFINAL_controls) {
                    phase               = "fight";
                    player_locked       = false;
                    obj_player.can_move = true;
                }
            } else {
                dialogue_text     = "";
                current_char      = 0;
                char_timer        = 0;
                dialogue_done     = false;
                waiting_for_input = false;
            }
        }
        break;

    case "fight":
        if (!instance_exists(obj_player)) break;

        // Phase 2 trigger
        if (phase2_triggered && !is_phase2) {
            is_phase2        = true;
            move_speed_fight = move_speed_phase2;
            burst_cooldown   = 60;
            with (obj_rmFINAL_controls) {
                phase2               = true;
                audio_stop_sound(current_music);
                current_music        = audio_play_sound(music_phase2, 1, true);
                global.current_music = current_music;
            }
        }

        // Distraction
        if (distracted) {
            distract_timer--;
            if (distract_timer <= 0 || !instance_exists(distract_target)) {
                distracted      = false;
                distract_target = noone;
            }
        }

        var _target = (distracted && instance_exists(distract_target)) ? distract_target : obj_player;
        var dx      = _target.x - x;
        var dy      = _target.y - y;
        var dist    = point_distance(x, y, _target.x, _target.y);

        // Movement — blocked during knockback
        var _in_knockback = (kb_x != 0 || kb_y != 0);

        if (!_in_knockback) {
        if (dist > attack_range) {
            var mx = (dx / dist) * move_speed_fight;
            var my = (dy / dist) * move_speed_fight;
            move_and_collide(mx, my, [tilemap_col, obj_box, obj_bed]);
            x = clamp(x, 32, 768);
            y = clamp(y, 32, 768);
            is_moving = true;
            if (abs(dx) > abs(dy)) {
                facing = (dx > 0) ? "right" : "left";
            } else {
                facing = (dy > 0) ? "down" : "up";
            }
        } else {
            is_moving = false;
            if (attack_cooldown <= 0 && !distracted) {
                with (obj_player) hp -= other.attack_damage;
                attack_cooldown = attack_rate;
            }
        }
    } else {
        is_moving = false;
    }
    
        if (attack_cooldown > 0) attack_cooldown--;

        // Spray
        spray_cooldown--;
        if (spray_cooldown <= 0 && instance_exists(obj_player)) {
            spray_cooldown = spray_rate;
            var spray_angle = point_direction(x, y, obj_player.x, obj_player.y);
            var _inst = instance_create_depth(x, y, depth, obj_spray);
            _inst.image_angle = spray_angle;
            _inst.damage      = spray_damage;
            _inst.source      = "vermin";
        }

        // Burst
        burst_cooldown--;
        if (burst_cooldown <= 0) {
            if (!is_phase2) {
                burst_cooldown = burst_rate_phase1;
                for (var b = 0; b < burst_count_phase1; b++) {
                    var angle = (360 / burst_count_phase1) * b;
                    var proj  = instance_create_layer(x, y, "Instances", obj_VERMIN_projectile);
                    proj.speed_x = lengthdir_x(burst_speed_phase1, angle);
                    proj.speed_y = lengthdir_y(burst_speed_phase1, angle);
                    proj.damage  = attack_damage;
                }
            } else {
                burst_cooldown = burst_rate;
                for (var b = 0; b < burst_count; b++) {
                    var angle = (360 / burst_count) * b;
                    var proj  = instance_create_layer(x, y, "Instances", obj_VERMIN_projectile);
                    proj.speed_x = lengthdir_x(burst_speed, angle);
                    proj.speed_y = lengthdir_y(burst_speed, angle);
                    proj.damage  = attack_damage;
                }
            }
        }

        // HP hits 0
        if (hp <= 0) {
            hp               = max_hp * 2;
            max_hp           = max_hp * 2;
            hp_locked        = true;
            phase2_triggered = true;
            iframes          = iframes_max;
            bar_scale_target = 2;
            with (obj_rmFINAL_controls) {
                show_error_message = true;
                error_persistent   = true;
                error_timer        = 180;
                error_flash        = 0;
            }
        }

        if (hp_locked && hp <= 0) hp = 1;

        // Player dead
        if (obj_player.hp <= 0) {
            obj_player.can_move = false;
            if (!is_phase2) {
                audio_stop_sound(global.current_music);
                global.current_music = noone;
                room_goto(rm_death);
            } else {
                phase = "win";
                with (obj_rmFINAL_controls) phase = "win";
            }
        }
        break;

    case "win":
        is_moving = false;
        if (instance_exists(obj_player)) {
            var dx = obj_player.x - x;
            var dy = obj_player.y - y;
            if (abs(dx) > abs(dy)) {
                facing = (dx > 0) ? "right" : "left";
            } else {
                facing = (dy > 0) ? "down" : "up";
            }
        }
        break;
}

// Sprite
switch (facing) {
    case "down":  sprite_index = is_moving ? spr_voidplayer_front_walk : spr_voidplayer_front_idle; break;
    case "up":    sprite_index = is_moving ? spr_voidplayer_back_walk  : spr_voidplayer_back_idle;  break;
    case "left":  sprite_index = is_moving ? spr_voidplayer_left_walk  : spr_voidplayer_left_idle;  break;
    case "right": sprite_index = is_moving ? spr_voidplayer_right_walk : spr_voidplayer_right_idle; break;
}

image_blend = (hit_flash > 0 && (hit_flash mod 4) < 2) ? c_red : c_white;