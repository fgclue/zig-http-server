const std = @import("std");
const net = std.net;
const http = std.http;
const allocator = std.heap.page_allocator;

// Host a server:
//  Get a list of all files
//  Host the files
// Get Requests:
//  Wait for requests
//  Recieve requests
//  Handle requests
// Send Requests:
//  Send requests...

pub fn main() !void {
    // Prints to stderr (it's a shortcut based on `std.io.getStdErr()`)
    std.debug.print("Zig Web S{s}", .{"erver"});
    
    var server = try http.Server.init(allocator);

    defer server.deinit();

    server.set_handler(.{ .request_method = .GET, .url = "/", .handler_fn = hello_world_handler });

    try.server.listen(allocator, "127.0.0.1:2050", {});

    try server.wait();

    // stdout is for the actual output of your application, for example if you
    // are implementing gzip, then only the compressed bytes should be sent to
    // stdout, not any debugging messages.
}

fn hello_world_handler(request: *http.Request, respone: *http.ResponseWriter) !void {
    try response.write_text("text/plain", "Goodbye, JavaScript");
}
