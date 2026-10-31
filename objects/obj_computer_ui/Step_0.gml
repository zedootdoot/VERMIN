if (!ui_open){
    global.options_open = false;
    global.options_allowed = false;
}
// Update available jobs dynamically
menu_items = [];
job_descriptions = [];
job_playable = []; // NEW: tracks which jobs can be played

// Job 001
if (global.current_job > 0) {
    array_push(menu_items, "Job_001 [COMPLETED]");
    array_push(job_descriptions, "Job 001: [COMPLETED]");
    array_push(job_playable, false);
} else {
    array_push(menu_items, "Job_001");
    array_push(job_descriptions, "Job 001: Location: Home Attic\n\nAttic is infested with rats.\nExterminate them all.");
    array_push(job_playable, true);
}

// Job 002
if (global.current_job >= 1) {
    if (global.current_job > 1) {
        array_push(menu_items, "Job_002 [COMPLETED]");
        array_push(job_descriptions, "Job 002: [COMPLETED]");
        array_push(job_playable, false);
    } else {
        array_push(menu_items, "Job_002");
        array_push(job_descriptions, "Job 002: Location: Apartment Basement\n\nRumors and complaints of large pests \ninfesting the basement.\nExterminate them all.");
        array_push(job_playable, true);
    }
}

// Job 003
if (global.current_job >= 2) {
    if (global.current_job > 2) {
        array_push(menu_items, "Job_003 [COMPLETED]");
        array_push(job_descriptions, "Job 003: [COMPLETED]");
        array_push(job_playable, false);
    } else {
        array_push(menu_items, "Job_003");
        array_push(job_descriptions, "Job 003: Location: Orphanage Basement\n\nThe orphanage called, about monsters\nlurking in the basement.\nExterminate them all.");
        array_push(job_playable, true);
    }
}

// Job 004
if (global.current_job >= 3) {
    if (global.current_job > 3) {
        array_push(menu_items, "Job_004 [COMPLETED]");
        array_push(job_descriptions, "Job 004: [DETELPMOC]");
        array_push(job_playable, false);
    } else {
        array_push(menu_items, "Job_004");
        array_push(job_descriptions, "Job 004: Location: [ERROR]\n\n.lla meht etanimretxE");
        array_push(job_playable, true);
    }
}

// Job 005
if (global.current_job >= 4) {
    array_push(menu_items, "Job_005");
    array_push(job_descriptions, "Job 005: Location: [REDACTED]\n\nInteresting...\n\nThis job should not exist\n\nThere must be a reason.\n\n\nGo on then.\n\n\nFinish the job.");
    array_push(job_playable, true); // Always playable (final job)
}

// Always keep EXIT at the end
array_push(menu_items, "EXIT");
array_push(job_descriptions, "BEGONE");
array_push(job_playable, true);

if (instance_exists(obj_computer) && obj_computer.ui_open) {
    
    // When selection changes, reset typing
    if (keyboard_check_pressed(vk_down) || keyboard_check_pressed(vk_up)) {
        typing_index = 0;
        typed_text = "";
    }
    // Typing effect
    var full_text = job_descriptions[menu_selection];
    if (typing_index < string_length(full_text)) {
        typing_timer++;
        if (typing_timer >= typing_speed) {
            typing_timer = 0;
            typing_index++;
            typed_text = string_copy(full_text, 1, typing_index);
    
            // Dialogue sound per character
            var _c = string_char_at(full_text, typing_index);
            if (_c != " " && _c != "." && _c != "," && _c != "!" && _c != "?") {
                var _s = audio_play_sound(snd_computer_dialogue, 1, false);
                audio_sound_pitch(_s, random_range(0.95, 1.05));
            }
        }
    }
    // --- Navigate menu ---
    if (keyboard_check_pressed(vk_down)) menu_selection = (menu_selection + 1) mod array_length(menu_items);
    if (keyboard_check_pressed(vk_up))   menu_selection = (menu_selection - 1 + array_length(menu_items)) mod array_length(menu_items);
    
        // --- Select menu item ---
    if (keyboard_check_pressed(ord("Z"))) {
        // Check if typing is complete
        var full_text = job_descriptions[menu_selection];
        if (typing_index < string_length(full_text)) {
            // Typing not finished - skip to end instead
            typing_index = string_length(full_text);
            typed_text = full_text;
            exit;
        }
        
        // Check if this job is playable
        if (!job_playable[menu_selection]) {
            // Play error sound or show message (optional)
            // Do nothing - job already completed
            exit;
        }
        
        var choice = menu_items[menu_selection];
        
        // Extract job number from string (remove [COMPLETED] if present)
        if (string_pos("Job_001", choice) > 0) {
            with (obj_fade) {
                next_room = rm_job1;
                fading_out = true;
            }
            ui_open = false;
            instance_destroy();
        }
        else if (string_pos("Job_002", choice) > 0) {
            with (obj_fade) {
                next_room = rm_job2;
                fading_out = true;
            }
        }
        else if (string_pos("Job_003", choice) > 0) {
            with (obj_fade) {
                next_room = rm_job3;
                fading_out = true;
            }
        }
        else if (string_pos("Job_004", choice) > 0) {
            with (obj_fade) {
                next_room = rm_job4;
                fading_out = true;
            }
        }
        else if (string_pos("Job_005", choice) > 0) {
            with (obj_fade) {
                next_room = rm_job5_main;
                fading_out = true;
            }
        }
        else if (choice == "EXIT") {
            ui_open = false;
            obj_computer.just_closed_ui = true;
            obj_computer.ui_open = false;
            instance_destroy();
        }
    }
}