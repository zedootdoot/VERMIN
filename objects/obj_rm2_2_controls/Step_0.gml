// Initialize variables in Create Event
if (!variable_instance_exists(id, "fade_timer")) fade_timer = 0;
if (!variable_instance_exists(id, "show_complete_message")) show_complete_message = false;
if (!variable_instance_exists(id, "sound played")) sound_played = false;

// Check if all enemies are defeated
var all_enemies_defeated = (instance_number(obj_enemy_parent) == 0);

// If the room is cleared and delay hasn't started yet, start delay
if (!room_cleared && all_enemies_defeated) {

    if (fade_timer <= 0) {
        fade_timer = room_speed * 2; // 2-second delay
        show_complete_message = true; // show the message
        
        //sound
        if (!sound_played) {
            audio_play_sound(snd_lvl_complete, 1, false);
            sound_played = true;
        }
    } else {
        fade_timer -= 1;
    }
    if (fade_timer <= 0) {
        room_cleared = true;
        global.room_cleared = true;
        global.current_job = 2;
        show_complete_message = false;

        if (!global.job2_paid) {
           global.job2_paid = true;
           var _earned = irandom_range(1, 1000);
           global.money += _earned;
           global.pending_payment_amount = _earned;
           global.pending_payment_text = "You'll maybe find a use for this.";
           global.has_pending_payment = true;
       }

        with (obj_fade) {
            fading_out = true;
            next_room = rm_van;
        }
    }
}