if (alarm[1] < 0) {
    hp -= other.damage;
    image_blend = c_red;
    
    // Play hurt sound (placeholder)
    //if (snd_hurt != -1) {
        //audio_play_sound(snd_hurt, 1, false);
    //}
    
    kb_x = sign(x - other.x);
    kb_y = sign(y - other.y);
    alarm[1] = 20;
}