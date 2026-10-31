/// CREATE EVENT

// Globals
if (!variable_global_exists("music_volume")) 
    global.music_volume = 10;
if (!variable_global_exists("game_paused")) 
    global.game_paused = false;
if (!variable_global_exists("options_open")) 
    global.options_open = false;
if (!variable_global_exists("current_music")) 
    global.current_music = noone;
if (!variable_global_exists("options_allowed")) 
    global.options_allowed = true;
if (!variable_global_exists("game_controls")) 
    global.game_controls = 0;
if (!variable_global_exists("crase")) 
    global.crase = 0;

global.vermin_dialogue_active = false;

// Fullscreen
fullscreen = window_get_fullscreen();
audio_master_gain(global.music_volume / 10);

// Input lock to prevent key bleed at room start
global.input_locked = true;
global.input_lock_timer = room_speed * 0.25; // quarter-second delay

overlay_selection = 0;

// Player currency
if (!variable_global_exists("player_money")) global.player_money = 0;

// Optional: track total earned for stats
if (!variable_global_exists("total_money_earned")) global.total_money_earned = 0;
    
global.job5_room1_cleared = false;
global.job5_room2_cleared = false;
global.job5_room3_cleared = false;

global.money = 0;
global.job1_paid = false;
global.job2_paid = false;
global.job3_paid = false;
global.job4_paid = false;
global.has_pending_payment = false;
global.pending_payment_amount = 0;
global.pending_payment_text = "";

if (!variable_global_exists("respawn_triggered")) global.respawn_triggered = false;
    
if (!variable_global_exists("music_volume")) 
    global.music_volume = 10;
global.music_volume = 10;  // always force to 10, no condition
audio_master_gain(1.0);    // always set master gain to full