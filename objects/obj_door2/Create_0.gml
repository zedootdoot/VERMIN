// Interaction settings
interact_distance = 100;
showing_dialogue = false;
just_closed = false;
image_xscale = .5;
image_yscale = .5;


// Dialogue content - CHANGE THESE IN EACH INSTANCE
dialogue_lines = [
    "its a door.",
    "will you proceed?",
];
current_line = 0;  // Which line we're on

// Menu options (shown after all dialogue)
has_menu = true;  // Set to true to show menu after dialogue
menu_option_1 = "PROCEED";  // Customize these
menu_option_2 = "DON'T PROCEED";
target_room = rm_job1_silly;  // Room to go to if PROCEED selected

// Option selection
option_selected = 0;  // 0 = first option, 1 = second option
input_locked = false;
input_lock_timer = 0;

// Add this alongside your existing door create variables
cleared_flag = "global.job5_room2_cleared"; // change per door instance
is_cleared = false; // will be set on room entry
if (global.job5_room2_cleared) is_cleared = true