// hide-start
const expect = @import("std").testing.expect;

// hide-end
test "structural typing" {
    try expect(enum { A, B } != enum { A, B });
    try expect(error{ A, B } == error{ A, B });
    try expect((error{ A, B }).A == (error{ A, B }).A);
}

const FileOpenError = error{
    AccessDenied,
    OutOfMemory,
    FileNotFound,
};

const AllocationError = error{OutOfMemory};

test "coerce error from a subset to a superset" {
    const err: FileOpenError = AllocationError.OutOfMemory;
    try expect(err == FileOpenError.OutOfMemory);

    const err2: anyerror = FileOpenError.FileNotFound;
    try expect(err2 == error.FileNotFound);
}

test "merge error sets" {
    try expect(FileOpenError == (AllocationError || error{ AccessDenied, FileNotFound }));
    try expect((AllocationError || FileOpenError) == FileOpenError);
}
