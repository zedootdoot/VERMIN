move_speed = 2;

tilemap = layer_tilemap_get_id("tiles_col");
if (tilemap == -1) tilemap = layer_tilemap_get_id("tiles_col_1");
if (tilemap == -1) tilemap = layer_tilemap_get_id("tiles_col_3"); 
if (tilemap == -1) tilemap = layer_tilemap_get_id("tiles_col_3");
start_x = x;
start_y = y;
hp = 20;
hp_total = hp;
damage = 1;

facing = 0;

level = 1;
xp = 0;
xp_require = 100;

function add_xp(_xp_to_add)
{
    xp += _xp_to_add
    if (xp >= xp_require)
    {    
        level ++;
        xp -= xp_require;
        xp_require *= 1.4;
        
        hp_total +=5;
        hp = hp_total;
        damage += 0.8;
        }
}

attack_cooldown = 0;
attack_cooldown_max = 10; // Adjust this (15 = quarter second at 60fps)