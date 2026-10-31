// Hard lock on death
if (hp <= 0) {
    if (sprite_index == spr_player_front_walk) sprite_index = spr_player_front_idle;
    else if (sprite_index == spr_player_back_walk) sprite_index = spr_player_back_idle;
    else if (sprite_index == spr_player_left_walk) sprite_index = spr_player_left_idle;
    else if (sprite_index == spr_player_right_walk) sprite_index = spr_player_right_idle;
    exit;
}

var _ui_open = false;
if (instance_exists(obj_computer)) _ui_open = obj_computer.ui_open;

var front_walk, back_walk, left_walk, right_walk, front_idle, back_idle, left_idle, right_idle;

if (global.current_job == 0) {
    global.crase = 0;
    front_walk = spr_player_front_walk;
    back_walk  = spr_player_back_walk;
    left_walk  = spr_player_left_walk;
    right_walk = spr_player_right_walk;
    front_idle = spr_player_front_idle;
    back_idle  = spr_player_back_idle;
    left_idle  = spr_player_left_idle;
    right_idle = spr_player_right_idle;
} else if (global.current_job == 1) {
    global.crase = 1;
    front_walk = spr_scratchplayer_front_walk;
    back_walk  = spr_player_back_walk;
    left_walk  = spr_scratchplayer_left_walk;
    right_walk = spr_player_right_walk;
    front_idle = spr_scratchplayer_front_idle;
    back_idle  = spr_player_back_idle;
    left_idle  = spr_scratchplayer_left_idle;
    right_idle = spr_player_right_idle;
} else if (global.current_job == 2) {
    global.crase = 2;
    front_walk = spr_bloodplayer_front_walk;
    back_walk  = spr_bloodplayer_back_walk;
    left_walk  = spr_bloodplayer_left_walk;
    right_walk = spr_bloodplayer_right_walk;
    front_idle = spr_bloodplayer_front_idle;
    back_idle  = spr_bloodplayer_back_idle;
    left_idle  = spr_bloodplayer_left_idle;
    right_idle = spr_bloodplayer_right_idle;
} else if (global.current_job >= 3) {
    global.crase = 3;
    front_walk = spr_cursedplayer_front_walk;
    back_walk  = spr_bloodplayer_back_walk;
    left_walk  = spr_cursedplayer_left_walk;
    right_walk = spr_cursedplayer_right_walk;
    front_idle = spr_cursedplayer_front_idle;
    back_idle  = spr_bloodplayer_back_idle;
    left_idle  = spr_cursedplayer_left_idle;
    right_idle = spr_cursedplayer_right_idle;
}

var mirror_ok = !instance_exists(obj_mirror) || !obj_mirror.interacting;
var cot_ok    = !instance_exists(obj_cot)    || !obj_cot.interacting;
var bomb_ok   = !instance_exists(obj_bomb_shop) || !obj_bomb_shop.interacting;
var door1_ok  = !instance_exists(obj_door1) || (!obj_door1.just_closed && !obj_door1.showing_dialogue);
var door2_ok  = !instance_exists(obj_door2) || (!obj_door2.just_closed && !obj_door2.showing_dialogue);
var door3_ok  = !instance_exists(obj_door3) || (!obj_door3.just_closed && !obj_door3.showing_dialogue);

if (_ui_open || global.options_open || !mirror_ok || !cot_ok || !bomb_ok || !door1_ok || !door2_ok || !door3_ok) {
    if (sprite_index == front_walk) sprite_index = front_idle;
    else if (sprite_index == back_walk) sprite_index = back_idle;
    else if (sprite_index == left_walk) sprite_index = left_idle;
    else if (sprite_index == right_walk) sprite_index = right_idle;
}

if ((!_ui_open && !global.options_open) && mirror_ok && cot_ok && door1_ok && door2_ok && door3_ok && bomb_ok) {
    var _hor = keyboard_check(vk_right) - keyboard_check(vk_left);
    var _ver = keyboard_check(vk_down)  - keyboard_check(vk_up);

    move_and_collide(_hor * move_speed, _ver * move_speed, [tilemap, obj_cot, obj_box, obj_bed, obj_door1, obj_door2, obj_door3, obj_bomb_shop], undefined, undefined, undefined, move_speed, move_speed);

    if (_hor != 0 || _ver != 0) {
        if (_ver > 0)       sprite_index = front_walk;
        else if (_ver < 0)  sprite_index = back_walk;
        else if (_hor > 0)  sprite_index = right_walk;
        else if (_hor < 0)  sprite_index = left_walk;
        facing = point_direction(0, 0, _hor, _ver);
    } else {
        if (sprite_index == front_walk || sprite_index == spr_player_front_walk ||
            sprite_index == spr_scratchplayer_front_walk || sprite_index == spr_bloodplayer_front_walk ||
            sprite_index == spr_cursedplayer_front_walk) {
            sprite_index = front_idle;
        } else if (sprite_index == back_walk || sprite_index == spr_player_back_walk ||
                   sprite_index == spr_bloodplayer_back_walk) {
            sprite_index = back_idle;
        } else if (sprite_index == left_walk || sprite_index == spr_player_left_walk ||
                   sprite_index == spr_scratchplayer_left_walk || sprite_index == spr_bloodplayer_left_walk ||
                   sprite_index == spr_cursedplayer_left_walk) {
            sprite_index = left_idle;
        } else if (sprite_index == right_walk || sprite_index == spr_player_right_walk ||
                   sprite_index == spr_bloodplayer_right_walk || sprite_index == spr_cursedplayer_right_walk) {
            sprite_index = right_idle;
        } else if (sprite_index == spr_player_front_idle || sprite_index == spr_scratchplayer_front_idle ||
                   sprite_index == spr_bloodplayer_front_idle || sprite_index == spr_cursedplayer_front_idle) {
            sprite_index = front_idle;
        } else if (sprite_index == spr_player_back_idle || sprite_index == spr_bloodplayer_back_idle) {
            sprite_index = back_idle;
        } else if (sprite_index == spr_player_left_idle || sprite_index == spr_scratchplayer_left_idle ||
                   sprite_index == spr_bloodplayer_left_idle || sprite_index == spr_cursedplayer_left_idle) {
            sprite_index = left_idle;
        } else if (sprite_index == spr_player_right_idle || sprite_index == spr_bloodplayer_right_idle ||
                   sprite_index == spr_cursedplayer_right_idle) {
            sprite_index = right_idle;
        } else {
            if (variable_instance_exists(id, "facing")) {
                if (facing >= 315 || facing < 45)        sprite_index = right_idle;
                else if (facing >= 45 && facing < 135)   sprite_index = back_idle;
                else if (facing >= 135 && facing < 225)  sprite_index = left_idle;
                else                                      sprite_index = front_idle;
            } else {
                sprite_index = front_idle;
            }
        }
    }
} else {
    var needs_update = false;
    switch (global.current_job) {
        case 0:
            if (sprite_index != spr_player_front_idle && sprite_index != spr_player_back_idle &&
                sprite_index != spr_player_left_idle  && sprite_index != spr_player_right_idle)
                needs_update = true;
            break;
        case 1:
            if (sprite_index != spr_scratchplayer_front_idle && sprite_index != spr_player_back_idle &&
                sprite_index != spr_scratchplayer_left_idle  && sprite_index != spr_player_right_idle)
                needs_update = true;
            break;
        case 2:
            if (sprite_index != spr_bloodplayer_front_idle && sprite_index != spr_bloodplayer_back_idle &&
                sprite_index != spr_bloodplayer_left_idle  && sprite_index != spr_bloodplayer_right_idle)
                needs_update = true;
            break;
        case 3:
            if (sprite_index != spr_cursedplayer_front_idle && sprite_index != spr_bloodplayer_back_idle &&
                sprite_index != spr_cursedplayer_left_idle  && sprite_index != spr_cursedplayer_right_idle)
                needs_update = true;
            break;
    }
    if (needs_update) sprite_index = front_idle;
}

if (attack_cooldown > 0) attack_cooldown--;

// Attack
var _vermin_talking = instance_exists(obj_VERMIN) && obj_VERMIN.phase == "dialogue";
var _vermin_walking = instance_exists(obj_VERMIN) && obj_VERMIN.phase == "approach";

if (keyboard_check_pressed(ord("X")) && room != rm_van && !global.options_open
    && attack_cooldown <= 0 && !_vermin_talking && !_vermin_walking) {
    var _inst = instance_create_depth(x, y, depth, obj_spray);
    _inst.image_angle = facing;
    _inst.damage     *= damage;
    _inst.source      = "player";
    attack_cooldown   = attack_cooldown_max;
}

if (keyboard_check_pressed(vk_f11)) {
    window_set_fullscreen(!window_get_fullscreen());
}