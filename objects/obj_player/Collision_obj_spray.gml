if (instance_exists(obj_VERMIN) && other.source == obj_VERMIN) {
    hp -= other.damage;
    instance_destroy(other);
}