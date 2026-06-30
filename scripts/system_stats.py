#!/usr/bin/env python3

import glob
import subprocess
import sys
import time

import psutil


def gpu_usage_percent():
    # Nvidia
    try:
        out = subprocess.check_output(
            [
                "nvidia-smi",
                "--query-gpu=utilization.gpu",
                "--format=csv,noheader,nounits",
            ],
            text=True,
        )

        values = [int(x) for x in out.splitlines() if x.strip()]

        if values:
            max(values)
    except (FileNotFoundError, subprocess.CalledProcessError):
        pass

    # AMD
    values = []

    for path in glob.glob("/sys/class/drm/card*/device/gpu_busy_percent"):
        try:
            with open(path) as f:
                values.append(int(f.read()))
        except OSError:
            pass

    return max(values) if values else 0


def main():
    psutil.cpu_percent()
    interval = float(sys.argv[1]) if len(sys.argv) > 1 else 1

    while True:
        data = [
            round(psutil.cpu_percent()),
            round(gpu_usage_percent()),
            round(psutil.virtual_memory().percent),
            round(psutil.disk_usage("/").percent),
        ]
        data_str = ";".join(map(str, data))

        print(data_str, flush=True)
        time.sleep(interval)


if __name__ == "__main__":
    main()
