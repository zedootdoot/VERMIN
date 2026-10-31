// Interaction settings
interact_distance = 100;
showing_dialogue = false;
just_closed = false;
image_xscale = .2;
image_yscale = .2;
// Dialogue content - CHANGE THESE IN EACH INSTANCE
dialogue_lines = [
    "its a door.",
    "will you proceed?",
];
current_line = 0;
has_menu = true;
menu_option_1 = "PROCEED";
menu_option_2 = "DON'T PROCEED";
target_room = rm_FINAL;
option_selected = 0;
input_locked = false;
input_lock_timer = 0;
cleared_flag = "global.job5_room3_cleared";
is_cleared = false;

// Destroy if already cleared
if (global.job5_room3_cleared) is_cleared = true;

// Locked until rooms 1 and 2 are both cleared
if (!global.job5_room1_cleared || !global.job5_room2_cleared) {
    dialogue_lines = [
        "this door won't budge.",
        "something feels unfinished...",
    ];
    has_menu = false;
    target_room = -1;
}