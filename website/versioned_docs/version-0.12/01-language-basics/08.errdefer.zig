// hide-start
const expect = @import("std").testing.expect;
const MyErrorSet = error{ Critical, Recoverable };

fn failingFunction() MyErrorSet!void {
    return error.Recoverable;
}

//hide-end
var problems: u32 = 98;

fn failFnCounter() MyErrorSet!void {
    errdefer problems += 1;
    try failingFunction();
}

test "errdefer" {
    failFnCounter() catch |err| {
        try expect(err == error.Recoverable);
        try expect(problems == 99);
        return;
    };
}
