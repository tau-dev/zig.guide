// hide-start
const expect = @import("std").testing.expect;
const MyErrorSet = error{ Critical, Recoverable };

fn failingFunction() MyErrorSet!void {
    return error.Recoverable;
}

//hide-end
fn failFn() MyErrorSet!i32 {
    try failingFunction();
    return 12;
}

test "try" {
    const v = failFn() catch |err| {
        try expect(err == error.Recoverable);
        return;
    };
    try expect(v == 12); // is never reached
}
