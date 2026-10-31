// Only react to player spray
if (other.source == "player") {
    var roll = irandom(2);  // 0 = rat, 1 = heal, 2 = both

    if (roll == 0 || roll == 2) {
        instance_create_layer(x, y, "Instances", obj_ally_rat);
    }
    if (roll == 1 || roll == 2) {
        obj_player.hp = min(
            obj_player.hp + obj_rmFINAL_controls.heal_amount,
            obj_player.hp_total
        );
    }

    instance_destroy(other);  // destroy the spray
    instance_destroy();       // destroy the token
}