switch (phase) {

    case "approach":
        break;

    case "dialogue":
        if (!player_locked) {
            player_locked       = true;
            obj_player.can_move = false;
        }
        break;

    case "respawn_dialogue":
        if (!player_locked) {
            player_locked       = true;
            obj_player.can_move = false;
        }
        break;

    case "fight":
        if (player_locked) {
            player_locked       = false;
            obj_player.can_move = true;
        }

        if (!music_swapped) {
            audio_stop_sound(current_music);
            current_music        = audio_play_sound(music_fight, 1, true);
            global.current_music = current_music;
            music_swapped        = true;
        }

        // Error message
        if (show_error_message) {
            error_flash++;
            if (!error_persistent) {
                error_timer--;
                if (error_timer <= 0) {
                    show_error_message = false;
                    error_flash        = 0;
                }
            }
            error_glitch_timer++;
            if (error_glitch_timer >= 3) {
                error_glitch_timer = 0;
                error_glitch_x     = irandom_range(-6, 6);
                error_glitch_y     = irandom_range(-3, 3);
            }
        }

        // Tile degradation
        if (instance_exists(obj_VERMIN)) {
            var hp_ratio = obj_VERMIN.hp / obj_VERMIN.max_hp;
            degrade_rate = max(15, round(degrade_rate_base * hp_ratio));
        }

        degrade_timer++;
        if (degrade_timer >= degrade_rate) {
            degrade_timer = 0;
            if (!col_exhausted && array_length(col_tiles) > 0) {
                var removed  = false;
                var attempts = min(20, array_length(col_tiles));
                for (var a = 0; a < attempts; a++) {
                    var pick = irandom(array_length(col_tiles) - 1);
                    var cell = col_tiles[pick];
                    if (col_removal_safe(tilemap_col, cell.cx, cell.cy, map_width, map_height)) {
                        tilemap_set(tilemap_col, 0, cell.cx, cell.cy);
                        array_delete(col_tiles, pick, 1);
                        removed = true;
                        break;
                    }
                }
                if (!removed) col_exhausted = true;
                if (array_length(col_tiles) == 0) col_exhausted = true;
            } else if (array_length(back_tiles) > 0) {
                var pick = irandom(array_length(back_tiles) - 1);
                var cell = back_tiles[pick];
                tilemap_set(tilemap_back, 0, cell.cx, cell.cy);
                array_delete(back_tiles, pick, 1);
            }
        }

        // Help tokens
        if (!phase2 && instance_exists(obj_player)) {
            token_timer--;
            if (token_timer <= 0 && obj_player.hp <= 10) {
                token_timer = token_interval;
                if (!instance_exists(obj_help_token)) {
                    instance_create_layer(
                        irandom_range(80, 720),
                        irandom_range(80, 720),
                        "Instances", obj_help_token
                    );
                }
            }
        }
        break;

    case "win":
        show_error_message  = false;
        error_persistent    = false;
        error_flash         = 0;
        obj_player.can_move = false;

        if (!mono_active) {
            win_alpha = min(win_alpha + 0.008, 1);
            if (win_alpha >= 1) {
                if (!exterminated_done) {
                    exterminated_alpha = min(exterminated_alpha + 0.03, 1);
                    if (exterminated_alpha >= 1) {
                        exterminated_timer++;
                        if (exterminated_timer >= exterminated_hold) exterminated_done = true;
                    }
                } else {
                    exterminated_alpha = max(exterminated_alpha - 0.03, 0);
                    if (exterminated_alpha <= 0) {
                        mono_active = true;
                        mono_alpha  = 0;
                    }
                }
            }
        }

        if (mono_active) {
            mono_alpha = min(mono_alpha + 0.03, 1);

            if (!mono_done) {
                mono_char_timer++;
                if (mono_char_timer >= mono_char_delay) {
                    mono_char_timer = 0;
                    var full_line = monologue[mono_index];
                    if (mono_char < string_length(full_line)) {
                        mono_char++;
                        mono_text = string_copy(full_line, 1, mono_char);
                        var _c = string_char_at(full_line, mono_char);
                        if (_c != " " && _c != "," && _c != "!" && _c != "?") {
                            var _s = audio_play_sound(snd_boss_dialogue, 0, false);
                            audio_sound_pitch(_s, random_range(0.92, 1.08));
                        }
                    } else {
                        mono_done = true;
                        mono_wait = true;
                    }
                }
            }

            if (mono_wait && keyboard_check_pressed(ord("Z"))) {
                mono_index++;
                if (mono_index >= array_length(monologue)) {
                    mono_fade_out = true;
                } else {
                    mono_text       = "";
                    mono_char       = 0;
                    mono_char_timer = 0;
                    mono_done       = false;
                    mono_wait       = false;
                }
            }

            if (mono_fade_out) {
                mono_fade_alpha = max(mono_fade_alpha - 0.005, 0);
                if (mono_fade_alpha <= 0) {
                    audio_stop_sound(current_music);
                    global.current_music = noone;
                    room_goto(rm_credits);
                }
            }
        }
        break;
}