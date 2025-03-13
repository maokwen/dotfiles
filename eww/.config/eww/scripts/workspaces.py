import socket
import os
import time
import json
import sys
import bisect

def recv_lines(sock, buffer_size=4096):
    buffer = ""
    while True:
        data = sock.recv(buffer_size).decode("utf-8")
        if not data:
            break

        buffer += data
        lines = buffer.split("\n")
        for line in lines[:-1]:
            if line == "":
                continue
            yield line

        buffer = lines[-1]

    if buffer.strip():
        yield buffer.strip()

def main():
    socket_path = os.getenv("NIRI_SOCKET")
    if not socket_path:
        print("NIRI_SOCKET environment variable not set", file=sys.stderr)
        return

    print("connecting to", socket_path, file=sys.stderr)

    with socket.socket(socket.AF_UNIX, socket.SOCK_STREAM) as s:
        try:
            s.connect(socket_path)
            s.sendall(b'"EventStream"\n')

            for line in recv_lines(s):
                try:
                    result = {}
                    obj = json.loads(line)
                    outputs = dict()
                    if "WorkspacesChanged" in obj:
                        for workspace in obj["WorkspacesChanged"]["workspaces"]:
                            output = workspace['output']
                            if output not in outputs:
                                outputs[output] = []
                            bisect.insort(outputs[output], {
                                'id': workspace['idx'],
                                'is_active': workspace['is_active']
                            }, key=lambda x: x['id'])

                        result = []
                        for key in sorted(outputs.keys()):
                            result.append({
                                'output': key,
                                'workspaces': outputs[key]
                            })

                        if len(result) == 0:
                            continue

                        #print(result)
                        json.dump(result, sys.stdout, indent=None)
                        sys.stdout.write('\n')

                except Exception as e:
                    print("Error:", e, file=sys.stderr)

        except Exception as e:
            print("Error:", e, file=sys.stderr)
            time.sleep(5)

if __name__ == "__main__":
    main()
