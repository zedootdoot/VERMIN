// Movement
move_speed = 1.5;
facing     = "down";
is_moving  = false;

// Phase
phase = "approach";

// Dialogue
dialogue = [
    "...",
    "So you made it.",
    "I've been waiting.",
    "You knoow, don't you?",
    "These '[JOBS]'.",
    "They are not right.",
    "They are inhumane.",
    "You are no exterminator.",
    "You are just a monster.",
    "You're just vermin.",
    "Just like the rest of them.",
    "Let me show you what that means."
];
approach_dist     = 48;
dialogue_index    = 0;
dialogue_text     = "";
char_timer        = 0;
char_delay        = 3;
current_char      = 0;
dialogue_done     = false;
waiting_for_input = false;

// Combat
max_hp           = 100;
hp               = max_hp;
move_speed_fight = 2;
attack_range     = 32;
attack_rate      = 45;
attack_cooldown  = 0;
attack_damage    = 5;
// Phase 2
is_phase2         = false;
phase2_triggered  = false;
move_speed_phase2 = 2.25;

// Burst phase 1
burst_rate_phase1  = 300;
burst_cooldown     = 300;
burst_count_phase1 = 4;
burst_speed_phase1 = 2;

// Burst phase 2
burst_rate  = 180;
burst_count = 8;
burst_speed = 3;

// Spray
spray_rate     = 150;
spray_cooldown = 150;
spray_damage   = 2;

// Knockback
kb_x        = 0;
kb_y        = 0;
kb_target_x = x;
kb_target_y = y;
kb_strength = 32;

// Iframes
iframes     = 0;
iframes_max = 16;

// Hit flash
hit_flash = 0;

// Health bar
hp_locked        = false;
bar_scale        = 1;
bar_scale_target = 1;
is_dead          = false;

// Distraction
distracted      = false;
distract_target = noone;
distract_timer  = 0;

tilemap_col = layer_tilemap_get_id("tiles_col");