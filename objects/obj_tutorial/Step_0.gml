
if triggered && !done {
    count++
    if count > 120 && commands_continue_check() {
        done = true
        count = 0;
    }
}

if done {
    count++
}