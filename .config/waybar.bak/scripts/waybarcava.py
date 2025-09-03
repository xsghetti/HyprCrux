#!/usr/bin/env python3

import os
import subprocess
import time
import sys
import json
import math
from collections import deque
import signal

NUM_BARS = 14
CAVA_FIFO = "/tmp/cava_visualizer.fifo"
CAVA_CONFIG = os.path.expanduser("~/.config/cava/visualizer_config")
CAVA_DIR = os.path.dirname(CAVA_CONFIG)

BLOCKS = ["⠀", "░", "▒", "▓", "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█"]

WAVE_BLOCKS = ["⠀", "·", "∘", "○", "●", "◐", "◑", "◒", "◓", "◔", "◕", "⬤"]
BRAILLE_BLOCKS = ["⠀", "⠁", "⠃", "⠇", "⠏", "⠟", "⠿", "⡿", "⣿"]


class SmoothVisualizer:
    def __init__(self, bars=NUM_BARS, smoothing_factor=0.7, wave_amplitude=1.5):
        self.bars = bars
        self.smoothing_factor = smoothing_factor
        self.wave_amplitude = wave_amplitude
        self.history = deque(maxlen=3)
        self.smooth_levels = [0.0] * bars
        self.velocity = [0.0] * bars
        self.time_offset = 0.0

        self.wave_coeffs = []
        for i in range(bars):
            self.wave_coeffs.append(
                {
                    "base1": i * math.pi / 6,
                    "base2": i * math.pi / 4,
                    "base3": i * math.pi / 8,
                }
            )

    def physics_smooth(self, index, target_value):
        """Optimized physics-based smoothing"""
        current = self.smooth_levels[index]
        diff = target_value - current

        force = diff * 0.3
        self.velocity[index] = self.velocity[index] * 0.8 + force
        new_value = current + self.velocity[index]

        return max(0, min(len(BLOCKS) - 1, new_value))

    def apply_wave_modulation(self, values):
        """Optimized wave modulation using pre-calculated coefficients"""
        self.time_offset += 0.1
        wave_values = []

        sin1 = math.sin(self.time_offset)
        sin2 = math.sin(self.time_offset * 1.3)
        sin3 = math.sin(self.time_offset * 0.7)

        for i, val in enumerate(values):
            coeffs = self.wave_coeffs[i]

            wave1 = sin1 * math.sin(coeffs["base1"]) * self.wave_amplitude
            wave2 = sin2 * math.sin(coeffs["base2"]) * (self.wave_amplitude * 0.5)
            wave3 = sin3 * math.sin(coeffs["base3"]) * (self.wave_amplitude * 0.3)

            combined_wave = wave1 + wave2 + wave3
            new_val = max(0, min(len(BLOCKS) - 1, val + combined_wave))
            wave_values.append(new_val)

        return wave_values

    def process_frame(self, raw_values):
        """Optimized frame processing"""
        if not raw_values:
            for i in range(self.bars):
                self.smooth_levels[i] = self.physics_smooth(i, 0)
            return self.smooth_levels

        if len(raw_values) < self.bars:
            raw_values.extend([0] * (self.bars - len(raw_values)))
        elif len(raw_values) > self.bars:
            raw_values = raw_values[: self.bars]

        values = self.apply_wave_modulation(raw_values)

        self.history.append(values)

        if len(self.history) >= 2:
            prev_frame = self.history[-2]
            for i in range(self.bars):
                current = values[i]
                previous = prev_frame[i] if i < len(prev_frame) else 0
                values[i] = current * 0.6 + previous * 0.4

        for i in range(self.bars):
            self.smooth_levels[i] = self.physics_smooth(i, values[i])

        return self.smooth_levels

    def render(self, levels, style="blocks"):
        """Optimized rendering"""
        if style == "wave":
            blocks = WAVE_BLOCKS
        elif style == "braille":
            blocks = BRAILLE_BLOCKS
        else:
            blocks = BLOCKS

        return "".join(blocks[min(int(level), len(blocks) - 1)] for level in levels)


def check_playing():
    """
    audio detection that only returns True when there's actual audio output.
    returns False during silence (like when Discord is connected but no one is speaking).
    """
    try:
        result = subprocess.run(
            ["pactl", "list", "sink-inputs", "short"],
            capture_output=True,
            text=True,
            timeout=2,
        )

        if result.returncode != 0 or not result.stdout.strip():
            return False

        detailed_result = subprocess.run(
            ["pactl", "list", "sink-inputs"], capture_output=True, text=True, timeout=2
        )

        if detailed_result.returncode != 0:
            return False

        output = detailed_result.stdout

        sections = output.split("Sink Input #")[1:]

        for section in sections:
            lines = section.split("\n")
            is_muted = True
            is_corked = True

            for line in lines:
                line = line.strip()
                if "Mute: no" in line:
                    is_muted = False
                elif "Corked: no" in line:
                    is_corked = False

            if not is_muted and not is_corked:
                return True

        return False

    except Exception:
        return False


def backup_original_config():
    original_config = os.path.expanduser("~/.config/cava/config")
    backup_config = os.path.expanduser("~/.config/cava/config.backup")

    if os.path.exists(original_config) and not os.path.exists(backup_config):
        import shutil

        shutil.copy2(original_config, backup_config)
        print(f"Backed up original config to {backup_config}")


def setup_cava():
    os.makedirs(CAVA_DIR, exist_ok=True)

    backup_original_config()

    if os.path.exists(CAVA_FIFO):
        os.remove(CAVA_FIFO)
    os.mkfifo(CAVA_FIFO)

    with open(CAVA_CONFIG, "w") as f:
        f.write(
            f"""[general]
bars = {NUM_BARS}
sensitivity = 100
framerate = 30
[input]
method = pulse
source = auto
[output]
method = raw
raw_target = {CAVA_FIFO}
data_format = ascii
ascii_max_range = 11
[smoothing]
integral = 64
monstercat = 1
waves = 1
gravity = 100
"""
        )


def start_cava():
    """Start cava process with separate config"""
    # Return the process object so we can kill it later
    return subprocess.Popen(
        ["cava", "-p", CAVA_CONFIG],  # Use separate config file
        stdout=subprocess.DEVNULL,
        stderr=subprocess.DEVNULL,
    )


def cleanup(cava_proc=None):
    """Clean up resources"""
    try:
        if cava_proc is not None:
            cava_proc.terminate()
            try:
                cava_proc.wait(timeout=2)
            except subprocess.TimeoutExpired:
                cava_proc.kill()
        if os.path.exists(CAVA_FIFO):
            os.remove(CAVA_FIFO)
        subprocess.run(["pkill", "-f", CAVA_CONFIG], stderr=subprocess.DEVNULL)
    except:
        pass


def main():
    """Optimized main loop"""
    style = "blocks"
    if len(sys.argv) > 1 and sys.argv[1] in ["blocks", "wave", "braille"]:
        style = sys.argv[1]

    cava_proc = None
    try:
        setup_cava()
        time.sleep(0.5)
        cava_proc = start_cava()
        time.sleep(1)

        visualizer = SmoothVisualizer(
            bars=NUM_BARS, smoothing_factor=0.75, wave_amplitude=1.2
        )

        with open(CAVA_FIFO, "r") as fifo:
            frame_count = 0
            idle_count = 0
            max_idle = 10  # Number of idle cycles before killing cava

            while True:
                if not check_playing():
                    print('{"text": " ", "class": "idle"}', flush=True)
                    idle_count += 1
                    if cava_proc is not None:
                        # Kill cava after max_idle idle cycles
                        if idle_count >= max_idle:
                            cava_proc.terminate()
                            try:
                                cava_proc.wait(timeout=2)
                            except subprocess.TimeoutExpired:
                                cava_proc.kill()
                            cava_proc = None
                    time.sleep(0.2)
                    continue
                else:
                    idle_count = 0
                    if cava_proc is None:
                        cava_proc = start_cava()
                        time.sleep(1)

                try:
                    line = fifo.readline()
                    if not line:
                        time.sleep(0.05)
                        continue

                    line = line.strip()
                    if not line:
                        continue

                    raw_values = []
                    if ";" in line:
                        raw_values = [int(x) for x in line.split(";") if x.isdigit()]
                    else:
                        raw_values = [int(x) for x in line if x.isdigit()]

                    levels = visualizer.process_frame(raw_values)
                    bars = visualizer.render(levels, style)

                    print(
                        json.dumps({"text": bars, "class": "visualizer-only"}),
                        flush=True,
                    )

                    frame_count += 1
                    if frame_count % 3 == 0:
                        time.sleep(0.02)

                except (ValueError, IndexError, BrokenPipeError):
                    time.sleep(0.1)
                    continue

    except (FileNotFoundError, KeyboardInterrupt):
        pass
    except Exception:
        print('{"text": "⠀", "class": "error"}', flush=True)
    finally:
        cleanup(cava_proc)


if __name__ == "__main__":
    main()
