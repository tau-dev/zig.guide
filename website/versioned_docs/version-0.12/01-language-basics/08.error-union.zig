// hide-start
const expect = @import("std").testing.expect;

// hide-end
const AllocationError = error{OutOfMemory};

test "error union" {
    const maybe_error: AllocationError!u16 = 10;
    const no_error: u16 = maybe_error catch 0;

    try expect(no_error == 10);
}
