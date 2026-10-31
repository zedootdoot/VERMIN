if (!global.options_open){
    if (alarm[0] < 0)
    {
        hp -= other.damage;
        alarm[0] = 60;
        image_blend = c_red;
        
        if (hp <= 0) {
            room_goto(rm_death)
            
                //with (obj_enemy_parent) {
                    //x = start_x;
                    //y = start_y;
                    //hp = hp_total;
                   // image_blend = c_white;
                //}
            }
        //any other reset code
    }
}