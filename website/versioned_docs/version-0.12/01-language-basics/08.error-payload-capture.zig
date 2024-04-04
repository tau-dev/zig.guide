// hide-start
const expect = @import("std").testing.expect;
const assert = @import("std").debug.assert;

// hide-end
const MyErrorSet = error{ Critical, Recoverable };

fn failingFunction() MyErrorSet!u32 {
    return error.Recoverable;
}

fn inferredFunction() !u32 {
    // We have decided that we can recover from error.Recoverable, but will propagate error.Critical.
    const res = failingFunction() catch |err|
        if (err == error.Recoverable) 2 else return error.Critical;

    return res;
}

test "inferred error sets" {
    const res: error{Critical}!u32 = inferredFunction();

    try expect((res catch 3) == 2);
}
