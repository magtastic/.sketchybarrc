#!/usr/bin/env bun
import { $ } from "bun";

const running = (await $`pgrep -x caffeinate`.quiet().nothrow()).exitCode === 0;

if (running) {
  await $`killall caffeinate`;
} else {
  Bun.spawn(["caffeinate", "-id"]);
}

await $`sketchybar -m --trigger caffeinate`;
