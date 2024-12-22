import std/net
import std/socketstreams
import std/os
import std/streams
import std/rdstdin
import std/osproc

let s = newSocket(AF_UNIX, SOCK_STREAM, IPPROTO_NONE)
s.connectUnix(getEnv("NIRI_SOCKET"))

echo getEnv("NIRI_SOCKET")

s.send("123")
s.send("\"EventStream\"")
#s.close()

#let rs = newSocket(AF_UNIX, SOCK_STREAM, IPPROTO_NONE)
#rs.connectUnix(getEnv("NIRI_SOCKET"))
#rs.send("\"WorkspaceChanged\"")

s.send("\"EventStream\"", maxRetries = 1)
echo "waiting for response"
var line: string
while true:
    s.readLine(line)
    echo line

let wss = newWriteSocketStream(s)
#wss.write("WorkspaceChanged")
wss.write("\"EventStream\"")
wss.flush()
var sline: string
while true:
    echo readLineFromStdin(sline)
    if sline.len > 0:
        echo sline

let rss = newReadSocketStream(s)

while rss.readLine(sline):
    echo sline
