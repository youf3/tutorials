#!/usr/bin/python3

import socket
import sys
import argparse

HOST = "192.168.105.241"
PORT = 59999

def main(args):
    s = socket.socket(socket.AF_INET,   socket.SOCK_STREAM)
    s.connect((HOST, PORT))
    print("[+] Connected with Server")

    # get file name to send
    f_send = args.P4Source 
    # open file
    with open(f_send, "rb") as f:
        # send file
        print("[+] Sending file...")
        data = f.read()
        # print(data)
        s.sendall(data)

    print('[-] Finished sending')
    s.send(b'//stop')
    f = open(args.output, "wb")
    print('[+] Receving compiled p4 codes...')
    while True:
        # get file bytes
        data = s.recv(4096)
        if not data:
            break
        # write bytes on file
        #print(data)
        f.write(data)
    # close connection
    s.close()
    print("[-] Finished")

parser = argparse.ArgumentParser()
parser.add_argument("P4Source", help='Path to the P4 source code to compile')
parser.add_argument( '-o' ,'--output', help='Output filename for compiled code', default='basic.tar.gz')
args = parser.parse_args()

main(args)
