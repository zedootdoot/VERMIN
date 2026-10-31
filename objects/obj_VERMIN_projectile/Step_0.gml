show_debug_message("proj pos: " + string(x) + "," + string(y) + " player pos: " + string(obj_player.x) + "," + string(obj_player.y) + " dist: " + string(point_distance(x, y, obj_player.x, obj_player.y)));
x += speed_x;
y += speed_y;

burst_speed_phase1 = 4;
burst_speed        = 5;

lifetime--;
if (lifetime <= 0) instance_destroy();
if (x < 0 || x > room_width || y < 0 || y > room_height) instance_destroy();

if (place_meeting(x, y, obj_player)) {
    obj_player.hp -= damage;
    instance_destroy();
}

if (point_distance(x, y, obj_player.x, obj_player.y) < 20) {
    obj_player.hp -= damage;
    instance_destroy();
}