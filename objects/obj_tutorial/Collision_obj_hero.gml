triggered = true

with (obj_tutorial) {
    if id != other.id {
        if triggered && !done {
            done = true
            count = 0
        }
    }
}
