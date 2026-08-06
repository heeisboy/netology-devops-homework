#!/usr/bin/env python3
import sys
import os
import re
import datetime

arg = sys.argv[1] if len(sys.argv) > 1 else ''

if arg == '1':
    print("Khromov R.D")
elif arg == '2':
    print(datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S"))
elif arg == '-ping' and len(sys.argv) > 2:
    result = os.popen(f"ping -c 1 {sys.argv[2]}").read()
    match = re.search(r"time=(.*) ms", result)
    print(match.group(1) if match else "No response")
elif arg == '-simple_print' and len(sys.argv) > 2:
    print(sys.argv[2])
else:
    print(f"ERROR: Unknown parameter: {arg}")
