if (room == rm_van && global.has_pending_payment && !showing) {
    show_payment(global.pending_payment_amount, global.pending_payment_text);
    global.has_pending_payment = false;
    global.pending_payment_amount = 0;
    global.pending_payment_text = "";
}

if (showing) {
    timer--;
    if (timer <= 0) showing = false;
}