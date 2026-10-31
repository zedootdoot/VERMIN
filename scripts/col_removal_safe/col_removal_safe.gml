function col_removal_safe(tm, tx, ty, mw, mh) {
    var left_empty  = (tx - 1 >= 0) ? (tilemap_get(tm, tx - 1, ty) == 0) : true;
    var right_empty = (tx + 1 < mw) ? (tilemap_get(tm, tx + 1, ty) == 0) : true;

    if (left_empty && right_empty) return false;
    if (left_empty || right_empty) return false;

    var empty_above = 0;
    for (var check = ty - 1; check >= 0; check--) {
        if (tilemap_get(tm, tx, check) == 0) empty_above++;
        else break;
    }

    var empty_below = 0;
    for (var check = ty + 1; check < mh; check++) {
        if (tilemap_get(tm, tx, check) == 0) empty_below++;
        else break;
    }

    if (1 + empty_above + empty_below >= 3) return false;

    return true;
}