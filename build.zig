const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const lib = b.addExecutable(.{
        .name = "mulang",
        .rootSourceFile = .{ .path = "src/mulang.zig" },
        .target = target,
        .optimize = optimize,
    });

    lib.linkLibC(); // Optional: if you need libc
    lib.dynamic_linkage = true; // 🔥 This makes it a shared library

    b.installArtifact(lib);
}
